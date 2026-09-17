#!/usr/bin/env bash
#
# run_all.sh -- verify every ProVerif and Tamarin model in this repository
# and record the result.
#
#   ./run_all.sh                 verify everything, write results/run-<stamp>.log
#   TIMEOUT=1200 ./run_all.sh    allow 20 min per model (default 600s)
#   MODEL_DIR=... ./run_all.sh   point at a different tree
#   ./run_all.sh Authentication  restrict to paths matching a substring
#
# Exit status:
#   0  every model that ran was proved
#   1  at least one model failed (falsified, error, or timeout)
#   2  everything that ran passed, but some models were skipped
#      (tool not installed) -- "no failures" is NOT "everything checked"
#
# Requires: tamarin-prover (>= 1.6) for .spthy, proverif (>= 2.0) for .pv.

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODEL_DIR="${MODEL_DIR:-$REPO_ROOT/SecurityProperties}"
RESULT_DIR="${RESULT_DIR:-$REPO_ROOT/results}"
TIMEOUT="${TIMEOUT:-600}"
FILTER="${1:-}"

# Tamarin reads source files using the system locale. Under a non-UTF-8
# locale (LANG=C / POSIX) any non-ASCII byte in a model aborts the run with
# "hGetContents: invalid argument". Force a UTF-8 locale so the outcome does
# not depend on the caller's environment.
export LC_ALL="${LC_ALL:-C.UTF-8}"
export LANG="${LANG:-C.UTF-8}"

# macOS ships no coreutils 'timeout'. Use 'gtimeout' when it is available,
# and otherwise run unbounded rather than failing every model with
# "timeout: command not found" -- a non-terminating model then runs until
# interrupted, which the header below makes explicit.
TIMEOUT_CMD=""
if   command -v timeout  >/dev/null 2>&1; then TIMEOUT_CMD="timeout $TIMEOUT"
elif command -v gtimeout >/dev/null 2>&1; then TIMEOUT_CMD="gtimeout $TIMEOUT"
fi

mkdir -p "$RESULT_DIR"
STAMP="$(date +%Y%m%d-%H%M%S)"
LOG="$RESULT_DIR/run-$STAMP.log"
SUMMARY="$RESULT_DIR/summary-$STAMP.txt"

have() { command -v "$1" >/dev/null 2>&1; }
HAVE_TAMARIN=0; have tamarin-prover && HAVE_TAMARIN=1
HAVE_PROVERIF=0; have proverif && HAVE_PROVERIF=1

PASS=0; FAIL=0; SKIP=0
declare -a ROWS=()

row() { ROWS+=("$(printf '%-9s %-11s %-58s %s' "$1" "$2" "$3" "$4")"); }

{
  echo "======================================================================"
  echo " Model verification run: $(date -u '+%Y-%m-%d %H:%M:%S UTC')"
  echo " model dir : $MODEL_DIR"
  if [ -n "$TIMEOUT_CMD" ]; then
    echo " timeout   : ${TIMEOUT}s per model (${TIMEOUT_CMD%% *})"
  else
    echo " timeout   : none -- no 'timeout'/'gtimeout' on PATH."
    echo "             On macOS: brew install coreutils"
  fi
  [ -n "$FILTER" ] && echo " filter    : $FILTER"
  echo " tamarin   : $( [ $HAVE_TAMARIN -eq 1 ] && tamarin-prover --version 2>/dev/null | head -1 || echo 'NOT INSTALLED' )"
  echo " proverif  : $( [ $HAVE_PROVERIF -eq 1 ] && proverif -help 2>&1 | head -1 || echo 'NOT INSTALLED' )"
  echo "======================================================================"
} | tee "$LOG"

# ----------------------------------------------------------------------
# Run one model, append full output to the log, classify the outcome.
# ----------------------------------------------------------------------
run_model() {
  local file="$1" tool="$2"
  local rel="${file#$MODEL_DIR/}"
  local out rc verdicts bad

  {
    echo
    echo "----------------------------------------------------------------------"
    echo "MODEL : $rel"
    echo "TOOL  : $tool"
  } >> "$LOG"

  local cmd=()
  if [ "$tool" = tamarin ]; then
    # Observational-equivalence models must be run in diff mode; detect them
    # from the source rather than hardcoding a list of filenames.
    if grep -q 'diff(' "$file"; then
      cmd=(tamarin-prover --diff --prove "$file")
    else
      cmd=(tamarin-prover --prove "$file")
    fi
  else
    cmd=(proverif "$file")
  fi
  echo "CMD   : ${cmd[*]}" >> "$LOG"

  local start; start=$(date +%s)
  out="$($TIMEOUT_CMD "${cmd[@]}" 2>&1)"; rc=$?
  local elapsed=$(( $(date +%s) - start ))

  printf '%s\n' "$out" >> "$LOG"
  echo "EXIT  : $rc (${elapsed}s)" >> "$LOG"

  # -------- timeout --------
  if [ $rc -eq 124 ]; then
    row FAIL TIMEOUT "$rel" "no result after ${TIMEOUT}s"
    FAIL=$((FAIL+1)); return
  fi

  # -------- 127 = something in the command line was not found. That is a
  #          harness/environment fault, not a model fault; say so plainly
  #          rather than reporting it as a missing verdict. --------
  if [ $rc -eq 127 ]; then
    row FAIL HARNESS "$rel" "$(printf '%s' "$out" | head -1)"
    FAIL=$((FAIL+1)); return
  fi

  # -------- killed by a signal; 137 = SIGKILL, usually the OOM killer --------
  if [ $rc -gt 128 ]; then
    row FAIL KILLED "$rel" "signal $((rc-128)) after ${elapsed}s (out of memory?)"
    FAIL=$((FAIL+1)); return
  fi

  if [ "$tool" = tamarin ]; then
    # Read verdicts out of the "summary of summaries" block. This covers both
    # the normal form ("  aliveness (all-traces): verified (18 steps)") and
    # diff mode ("  DiffLemma:  Observational_equivalence : verified (72 steps)").
    verdicts="$(printf '%s\n' "$out" | sed -n '/summary of summaries:/,$p' \
      | grep -E ':[[:space:]]*(verified|falsified|analysis incomplete)' \
      | sed 's/^[[:space:]]*//')"
    if [ -z "$verdicts" ]; then
      local why="no verdict emitted"
      printf '%s\n' "$out" | grep -qiE 'unexpected|expecting|parse error' && why="parse error"
      printf '%s\n' "$out" | grep -qi 'hGetContents'                       && why="locale/encoding error"
      # Note: "All wellformedness checks were successful." also contains the
      # word, so match only genuine failures.
      printf '%s\n' "$out" | grep -qiE 'wellformedness.*(fail|error)|the following wellformedness' && why="wellformedness error"
      row FAIL ERROR "$rel" "$why"
      FAIL=$((FAIL+1)); return
    fi
    printf '%s\n' "$verdicts" | sed 's/^/        /' >> "$LOG"
    bad="$(printf '%s\n' "$verdicts" | grep -cE 'falsified|analysis incomplete')"
    local total; total="$(printf '%s\n' "$verdicts" | grep -c .)"
    if [ "$bad" -gt 0 ]; then
      row FAIL FALSIFIED "$rel" "$bad of $total lemmas not proved"
      FAIL=$((FAIL+1))
    else
      row PASS verified "$rel" "$total/$total lemmas (${elapsed}s)"
      PASS=$((PASS+1))
    fi
  else
    # ProVerif prints one "RESULT ... is true/false/cannot be proved." per query.
    verdicts="$(printf '%s\n' "$out" | grep '^RESULT')"
    if [ -z "$verdicts" ]; then
      local why="no RESULT line"
      printf '%s\n' "$out" | grep -qiE 'Error|syntax error' && why="parse/type error"
      row FAIL ERROR "$rel" "$why"
      FAIL=$((FAIL+1)); return
    fi
    printf '%s\n' "$verdicts" | sed 's/^/        /' >> "$LOG"

    # Two kinds of query, with OPPOSITE desired answers -- this must stay in
    # step with run_proverif.sh.
    #
    # ProVerif renders "query event(e)." as "not event(e)". Those are
    # reachability / sanity checks:
    #     "not event(check) is false."  -> check() IS reachable   = good
    #     "not event(check) is true."   -> check() is unreachable = BAD, the
    #        protocol can never get there and every other query over this
    #        model may be holding vacuously.
    #
    # Everything else -- secrecy ("not attacker(x)"), correspondences,
    # "secret x", observational equivalence -- is good exactly when true.
    local reach sec reach_bad sec_bad reach_n sec_n
    reach="$(printf '%s\n' "$verdicts" | grep -E '^RESULT not event\(')"
    sec="$(printf '%s\n'   "$verdicts" | grep -vE '^RESULT not event\(')"
    reach_bad=$(printf '%s\n' "$reach" | grep -c 'is true\.')
    sec_bad=$(printf '%s\n'   "$sec"   | grep -cE 'is false|cannot be proved')
    reach_n=$(printf '%s\n'   "$reach" | grep -c .)
    sec_n=$(printf '%s\n'     "$sec"   | grep -c .)
    bad=$((sec_bad + reach_bad))

    if [ "$bad" -gt 0 ]; then
      local detail=""
      [ "$sec_bad"   -gt 0 ] && detail="$sec_bad of $sec_n security queries not proved"
      [ "$reach_bad" -gt 0 ] && detail="${detail:+$detail; }$reach_bad sanity event(s) unreachable"
      row FAIL "not proved" "$rel" "$detail (${elapsed}s)"
      FAIL=$((FAIL+1))
    else
      row PASS true "$rel" "$sec_n security + $reach_n reachability ok (${elapsed}s)"
      PASS=$((PASS+1))
    fi
  fi
}

# ----------------------------------------------------------------------
while IFS= read -r file; do
  [ -n "$FILTER" ] && [[ "$file" != *"$FILTER"* ]] && continue
  rel="${file#$MODEL_DIR/}"
  case "$file" in
    *.spthy)
      if [ $HAVE_TAMARIN -eq 1 ]; then run_model "$file" tamarin
      else row SKIP "no tool" "$rel" "tamarin-prover not installed"; SKIP=$((SKIP+1)); fi ;;
    *.pv)
      if [ $HAVE_PROVERIF -eq 1 ]; then run_model "$file" proverif
      else row SKIP "no tool" "$rel" "proverif not installed"; SKIP=$((SKIP+1)); fi ;;
  esac
done < <(find "$MODEL_DIR" \( -name '*.spthy' -o -name '*.pv' \) | sort)

# ----------------------------------------------------------------------
{
  echo
  echo "======================================================================"
  printf '%-9s %-11s %-58s %s\n' STATUS VERDICT MODEL DETAIL
  echo "----------------------------------------------------------------------"
  for r in "${ROWS[@]}"; do echo "$r"; done
  echo "----------------------------------------------------------------------"
  echo "passed: $PASS   failed: $FAIL   skipped: $SKIP"
  if [ "$FAIL" -gt 0 ]; then
    echo "RESULT: FAILURES PRESENT -- see $LOG"
  elif [ "$SKIP" -gt 0 ]; then
    echo "RESULT: no failures, but $SKIP model(s) never ran (missing tool)."
    echo "        This is NOT a clean bill of health."
  else
    echo "RESULT: all models proved."
  fi
  echo "======================================================================"
  echo "full log: $LOG"
} | tee "$SUMMARY" | tee -a "$LOG"

[ "$FAIL" -gt 0 ] && exit 1
[ "$SKIP" -gt 0 ] && exit 2
exit 0
