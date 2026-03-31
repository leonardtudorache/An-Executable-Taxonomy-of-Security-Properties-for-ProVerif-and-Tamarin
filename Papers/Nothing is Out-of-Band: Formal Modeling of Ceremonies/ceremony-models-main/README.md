# CSF2024 paper on formal modeling of security ceremonies

The `code-voting.spthy` theory illustrates a possible implementation of
our code voting example ceremony. The theory uses Tamarin's built-in knowledge
inference rules for the Dolev-Yao adversary.

The theory has open chains in Tamarin's dependency graphs.
We have therefore written a typing lemma to resolve the open chains.
(The automatic generation of a typing lemma with the `--auto-sources` flag does not work for this theory.) 

The `code-voting.spthy` file was analyzed with Tamarin 1.8.
The functional lemma can be automatically proven.
The proofs of the typing lemma as well as the integrity lemma are still open. 
The secrecy lemma can be proven automatically, but this proof is dependent on the typing lemma which is not proven.

The second theory file is `code-voting-one-run.spthy` which restricts the ceremony to only one run of each role. In this theory all lemmas can be automatically proven. 