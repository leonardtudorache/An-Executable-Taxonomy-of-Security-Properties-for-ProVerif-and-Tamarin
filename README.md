# Bridging Theory and Practice: An Executable Taxonomy of Security Properties for ProVerif and Tamarin

[![DOI](https://zenodo.org/badge/1193461070.svg)](https://doi.org/10.5281/zenodo.19352739)

### **Project Overview**

Security is fundamentally critical for modern digital systems. As internet and cryptographic protocols govern almost all digital interactions, they must serve as reliable mechanisms that guarantee core security properties like **confidentiality** and **integrity**.

While formal verification tools such as **ProVerif** and **Tamarin** are the industry standard for automated verification, they require specialized domain knowledge. This creates a significant learning curve for protocol designers who often possess a security background rather than a formal methods background.

### **The Taxonomy**

This repository provides the data for a systematic and evidence-based taxonomy of security properties derived from a literature review of **53 recent studies (2022–2025)**. This work bridges the gap between theoretical definitions and practical, executable verification models.

### **Key Features**

- **Systematic Categorization:** An up-to-date view of verified properties used in contemporary research (available in the article).
- **Dual Definitions:** Every property includes an **informal definition** for intuitive comprehension and a **rigorous formal definition** in first-order logic (available in the article).
- **Executable Library:** Ready-to-use modeling patterns and examples implemented in both **ProVerif (.pv)** and **Tamarin (.spthy)**.
- **Evidence-Based:** All properties and patterns are backed by data extracted from the state-of-the-art (SOTA) literature.
- **Reproducible:** Both provers can be run over the whole library with a single script, and the results are kept in version control.
- **DSL Foundation:** This work serves as the groundwork for a future **Domain-Specific Language (DSL)** aimed at further abstracting protocol verification.

---

## 📂 Repository Structure

### **`SecurityProperties/` — the executable taxonomy**

The models are organised to mirror the taxonomy in Figure 1 of the article: one directory per top-level category, one sub-directory per property.

```
SecurityProperties/
├── Authentication/
│   ├── authentication.{md,pv,spthy}         base property (Section 4.2.1)
│   ├── Aliveness/
│   ├── WeakAgreement/
│   ├── Non-injectiveAgreement/
│   ├── InjectiveAgreement/
│   └── MutualAuthentication/                composite — see note below
├── Confidentiality/
│   ├── Secrecy.{pv,spthy}                   base property (Section 4.2.3)
│   ├── ForwardSecrecy/
│   └── Post-compromiseSecurity/
├── Integrity/
│   ├── Unforgeability/
│   └── Non-equivocation/
├── Privacy/
│   ├── Anonymity/
│   └── Unlinkability/
└── Accountability/
    ├── Non-repudiation/
    └── Traceability/
```

Each property directory contains up to three files:

| File | Purpose |
|---|---|
| `<Property>.md` | A Mermaid sequence diagram of the example protocol, annotated with the points at which each event is raised. Tool-independent notation. |
| `<Property>.pv` | The ProVerif model: events, queries and the process calculus encoding. |
| `<Property>.spthy` | The Tamarin model: multiset rewriting rules, restrictions and lemmas. |

A property whose file sits directly in the category directory rather than a sub-directory (`Confidentiality/Secrecy.*`, `Authentication/authentication.*`) is the **base property** of that category — the node the sub-properties strengthen.

**Two notes on placement.** `MutualAuthentication/` sits beside the four Lowe levels for convenience, but it is deliberately absent from the taxonomy in Figure 1: it is a *composite* (agreement checked in both directions), not a fifth primitive. And `Accountability/Traceability/` currently holds a model of RFID **un**traceability — a related but opposite-flavoured privacy property — rather than the Traceability defined in Section 4.2.5; the file comments say so explicitly.

### **Verification harness**

| File | Purpose |
|---|---|
| `run_all.sh` | Runs every `.pv` and `.spthy` under `SecurityProperties/`, writes `results/run-<stamp>.log` plus a summary table, exits non-zero on any failure. |
| `run_proverif.sh` | ProVerif only; writes `proverif-results.txt`. |
| `proverif-results.txt`, `results/` | Recorded tool output. Kept in version control so the claims can be checked without installing either prover. |

Both scripts separate **security** queries (must hold) from **reachability** queries (must be reachable — an unreachable sanity event means the model cannot complete and every other result over it may be vacuous).

### **Supporting documentation & data**

| Directory | Contents |
|---|---|
| `CaseStudies/Signcryption/` | A hands-on case study of Zheng's Signcryption scheme: `signcryption_initial.{pv,spthy}` implement only the algebraic logic, `signcryption.{pv,spthy}` add the taxonomy's unforgeability and secrecy patterns. Referred to as the *Example* folder in the article. |
| `Papers/` | The core research data: 53 reviewed studies (2022–2025) and their associated verification models. |
| `Datasets/` | `dataset.json` and variants — the extracted property data behind the quantitative analysis. |
| `Data Visualization/` | Jupyter notebooks producing the distribution figures from `Datasets/`. |

### **Legacy directories**

`ProVerif Models of Properties/Other/`, `Tamarin Models of Properties/` and `Protocol Sequence Diagrams/` predate the move to `SecurityProperties/` and hold material that was not migrated: exploratory models (access control, multi-factor authentication) and `AuthenticationLevelsLowe.spthy`, which carries all four Lowe lemmas over a single Needham-Schroeder-Lowe model. They are kept for provenance and are **not** maintained — the models under `SecurityProperties/` supersede them.

**Disclaimer**:
The papers referenced in this work are not formally cited using standard academic citation formats. However, each paper can be traced and located through its title as mentioned in the text. Readers are encouraged to search for the original publications by title for full bibliographic details and further reading.

---

## 🛠 Usage

### **Prerequisites**

1. **ProVerif (>= 2.0):** for Dolev-Yao protocol analysis. Tested with 2.05.
2. **Tamarin Prover (>= 1.6.0):** for symbolic state-based analysis. Tested with 1.10.0 (Maude 3.2).
3. **Python 3.x:** to run the visualization notebooks (`pandas`, `matplotlib`).
4. **GNU coreutils** (optional, macOS): `run_proverif.sh` uses `gtimeout` to bound a run. Without it, a non-terminating model runs until interrupted.

### **Verifying the whole library**

```bash
./run_all.sh                    # both provers
./run_proverif.sh               # ProVerif only
./run_all.sh Authentication     # restrict to paths matching a substring
TIMEOUT=1200 ./run_all.sh       # raise the per-model limit (default 600s)
```

### **Verifying a single property**

```bash
proverif SecurityProperties/Confidentiality/Secrecy.pv

tamarin-prover --prove SecurityProperties/Confidentiality/ForwardSecrecy/ForwardSecrecy.spthy
```

Observational-equivalence models must be run in diff mode:

```bash
tamarin-prover --diff --prove SecurityProperties/Privacy/Unlinkability/Unlinkability.spthy
```

`run_all.sh` detects this automatically by looking for `diff(` in the source.

**Locale note.** Tamarin reads source files using the system locale and aborts on any non-ASCII byte under `LANG=C`/`POSIX`. The models are ASCII-only for this reason, and both scripts force a UTF-8 locale so the outcome does not depend on the caller's environment.

---

## ✅ Verification status

Regenerate at any time with `./run_all.sh`; the tables below record the state of the committed result files.

**ProVerif 2.05 — 15/15**, every security query proved and every sanity event reachable (`proverif-results.txt`).

**Tamarin 1.10.0 — see `results/`.** One scope caveat worth stating up front: the Tamarin model for **mutual authentication** is a bounded-session result. Both protocol roles are restricted to a single session; the adversary, certificate issuance and the set of agent identities all remain unbounded. Without that bound the proof search over the seven-message certificate-server flow does not terminate. Every other Tamarin model in the library is an unbounded-session result.

Each model also carries an executability or reachability check, so a "verified" verdict is accompanied by evidence that the protocol can actually complete. The two observational-equivalence models are the exception: ProVerif rejects correspondence queries alongside `choice` (*"Queries are incompatible with choice"*), and Tamarin's `--diff` mode carries no `exists-trace`, so neither tool can express an executability check for them.
