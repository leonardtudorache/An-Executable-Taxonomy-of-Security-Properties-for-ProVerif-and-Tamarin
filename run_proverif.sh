#!/usr/bin/env bash
#
# run_proverif.sh -- run every ProVerif model in this repository and write
# the results to a text file.
#
#   ./run_proverif.sh                    run all .pv models
#   ./run_proverif.sh Authentication     only paths matching a substring
#   TIMEOUT=1200 ./run_proverif.sh       allow 20 min per model (default 600s)
#   OUT=mylog.txt ./run_proverif.sh      choose the output file
#
# Exit status: 0 if every query was proved, 1 otherwise.

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODEL_DIR="${MODEL_DIR:-$REPO_ROOT/SecurityProperties}"
OUT="${OUT:-$REPO_ROOT/proverif-results.txt}"
TIMEOUT="${TIMEOUT:-600}"
FILTER="${1:-}"

if ! command -v proverif >/dev/null 2>&1; then
  echo "error: proverif not found on PATH." >&2
  echo "       install it from https://bblanche.gitlabpages.inria.fr/proverif/" >&2
  exit 127
fi

# macOS has no coreutils 'timeout'; use 'gtimeout' if present, else run
# unbounded (a looping model will then hang until you Ctrl-C it).
TIMEOUT_CMD=""
if command -v timeout  >/dev/null 2>&1; then TIMEOUT_CMD="timeout $TIMEOUT"
elif command -v gtimeout >/dev/null 2>&1; then TIMEOUT_CMD="gtimeout $TIMEOUT"
fi

PASS=0; FAIL=0
ROWS=()

{
  echo "======================================================================"
  echo " ProVerif verification run"
  echo " date      : $(date '+%Y-%m-%d %H:%M:%S %Z')"
  echo " model dir : $MODEL_DIR"
  echo " proverif  : $(proverif -help 2>&1 | head -1)"
  if [ -n "$TIMEOUT_CMD" ]; then echo " timeout   : ${TIMEOUT}s per model"
  else echo " timeout   : none (install coreutils for 'gtimeout' to bound runs)"; fi
  [ -n "$FILTER" ] && echo " filter    : $FILTER"
  echo "======================================================================"
} > "$OUT"

while IFS= read -r file; do
  [ -n "$FILTER" ] && [[ "$file" != *"$FILTER"* ]] && continue
  rel="${file#$MODEL_DIR/}"
  printf '  %-58s ' "$rel"

  {
    echo
    echo "----------------------------------------------------------------------"
    echo "MODEL: $rel"
    echo "----------------------------------------------------------------------"
  } >> "$OUT"

  start=$(date +%s)
  out="$($TIMEOUT_CMD proverif "$file" 2>&1)"; rc=$?
  elapsed=$(( $(date +%s) - start ))

  printf '%s\n' "$out" >> "$OUT"

  if [ $rc -eq 124 ]; then
    echo "TIMEOUT (${TIMEOUT}s)"
    ROWS+=("$(printf '%-10s %-58s %s' FAIL "$rel" "timed out after ${TIMEOUT}s")")
    FAIL=$((FAIL+1)); continue
  fi

  # ProVerif prints one "RESULT ... is true / is false / cannot be proved."
  # line per query. No RESULT line at all means it never got that far.
  results="$(printf '%s\n' "$out" | grep '^RESULT')"
  if [ -z "$results" ]; then
    echo "ERROR (no RESULT line)"
    ROWS+=("$(printf '%-10s %-58s %s' FAIL "$rel" "no RESULT line -- parse or type error")")
    FAIL=$((FAIL+1)); continue
  fi

  total=$(printf '%s\n' "$results" | grep -c .)

  # Two kinds of query, with OPPOSITE desired answers.
  #
  # ProVerif renders "query event(e)." as "not event(e)". Those are
  # reachability / sanity checks:
  #     "not event(check) is false."  -> check() IS reachable   = good
  #     "not event(check) is true."   -> check() is unreachable = BAD: the
  #        protocol can never get there, so every other query over this
  #        model may be holding vacuously.
  #
  # Everything else -- secrecy ("not attacker(x)"), correspondences,
  # "secret x", observational equivalence -- is good exactly when true.
  reach="$(printf '%s\n' "$results" | grep -E '^RESULT not event\(')"
  sec="$(printf '%s\n'   "$results" | grep -vE '^RESULT not event\(')"

  reach_bad=$(printf '%s\n' "$reach" | grep -c 'is true\.')
  sec_bad=$(printf '%s\n'   "$sec"   | grep -cE 'is false|cannot be proved')
  reach_n=$(printf '%s\n'  "$reach" | grep -c .)
  sec_n=$(printf '%s\n'    "$sec"   | grep -c .)
  bad=$((sec_bad + reach_bad))

  {
    echo
    echo "QUERIES: $total total = $sec_n security + $reach_n reachability"
    echo "         security not proved : $sec_bad"
    echo "         sanity events unreachable (possible vacuity) : $reach_bad"
    echo "         time: ${elapsed}s"
  } >> "$OUT"

  if [ "$bad" -gt 0 ]; then
    detail=""
    [ "$sec_bad"   -gt 0 ] && detail="$sec_bad of $sec_n security queries not proved"
    [ "$reach_bad" -gt 0 ] && detail="${detail:+$detail; }$reach_bad sanity event(s) unreachable"
    echo "FAIL -- $detail (${elapsed}s)"
    ROWS+=("$(printf '%-10s %-58s %s' FAIL "$rel" "$detail")")
    FAIL=$((FAIL+1))
    {
      printf '%s\n' "$sec"   | grep -E 'is false|cannot be proved' | sed 's/^/      /'
      printf '%s\n' "$reach" | grep    'is true\.'                 | sed 's/^/      /'
    } >> "$OUT"
  else
    echo "ok -- $sec_n security, $reach_n reachability (${elapsed}s)"
    ROWS+=("$(printf '%-10s %-58s %s' PASS "$rel" "$sec_n security + $reach_n reachability ok (${elapsed}s)")")
    PASS=$((PASS+1))
  fi
done < <(find "$MODEL_DIR" -name '*.pv' | sort)

{
  echo
  echo "======================================================================"
  printf '%-10s %-58s %s\n' STATUS MODEL DETAIL
  echo "----------------------------------------------------------------------"
  for r in "${ROWS[@]}"; do echo "$r"; done
  echo "----------------------------------------------------------------------"
  echo "passed: $PASS   failed: $FAIL"
  # Deliberately not "RESULT:" -- that prefix belongs to ProVerif's own query
  # verdicts, and reusing it here would pollute a "grep ^RESULT" over the log.
  [ "$FAIL" -gt 0 ] \
    && echo "OVERALL: $FAIL model(s) need attention." \
    || echo "OVERALL: all security queries proved, all sanity events reachable."
  echo "======================================================================"
} | tee -a "$OUT"

echo
echo "Full output written to: $OUT"
[ "$FAIL" -gt 0 ] && exit 1
exit 0
