# Bridging Theory and Practice: An Executable Taxonomy of Security Properties for ProVerif and Tamarin

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
- **DSL Foundation:** This work serves as the groundwork for a future **Domain-Specific Language (DSL)** aimed at further abstracting protocol verification.

---

## 📂 Folder Details

### **Formal Models**

- **`ProVerif Models of Properties/`** Executable `.pv` files implementing properties such as Aliveness, Injective Agreement, Secrecy, and Unlinkability. These are optimized for automated analysis in the Dolev-Yao model.
- **`Tamarin Models of Properties/`** Executable `.spthy` files for properties like Forward Secrecy, Post-Compromise Security (PCS), and Non-equivocation. These leverage symbolic analysis for complex state-dependent properties.

### **Supporting Documentation & Data**

- **`Protocol Sequence Diagrams/`** Markdown-based visualizations and explanations of protocol flows to assist in the "intuitive comprehension" of the formal models.
- **`Example/`** A hands-on case study of a **Signcryption** protocol, providing a step-by-step evolution from initial sketches to complete formal models.
- **`Papers/`** Contains the core research data: the extraction of security properties from the 53 reviewed studies (2022-2025) and their associated verification models.
- **`Data Visualization/`** Jupyter notebooks and the `dataset.json` used to analyze the taxonomy's distribution and the literature review results.

**Disclaimer**:
The papers referenced in this work are not formally cited using standard academic citation formats. However, each paper can be traced and located through its title as mentioned in the text. Readers are encouraged to search for the original publications by title for full bibliographic details and further reading.

---

## 🛠 Usage

To ensure reproducibility, follow the setup and execution steps below.

### **Prerequisites**

1. **ProVerif (>= 2.0):** For Dolev-Yao protocol analysis.
2. **Tamarin Prover (>= 1.6.0):** For symbolic state-based analysis.
3. **Python 3.x:** Required to run visualization notebooks (Libraries: `pandas`, `matplotlib`).

### **Executing Models**

#### **Using ProVerif**

To verify a specific property, run the following command in your terminal:

```bash
proverif "ProVerif Models of Properties/Secrecy.pv"
```

#### **Using Tamarin**

To prove a property, run the following command:

```bash
tamarin-prover "Tamarin Models of Properties/ForwardSecrecy.spthy" --prove
```
