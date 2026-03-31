# Receipt-freeness

In the privacy definition, the votes in the left world can be interpreted as the voting intentions of honest voters, while those on the right as the ones expected by the adversary. When the voter is coerced and has to provide to the adversary A any data that it obtained from the voting process, the indistinguishability of the two worlds may not hold directly. Taking EEV as example, if the voter forwards the QR code to A, then the verification procedure allows A to derive the vote.

# Ballot integrity.

Recent works show a connection between privacy and verifiability, e.g. claiming that individual verifiability is needed for privacy [29], or that we should consider various levels of privacy to match various levels of bulletin board corruption [30]. In this paper we take a simpler approach, showing that one single property of ballot integrity is sufficient to define privacy in any corruption model. Intuitively, ballot integrity (defined as Φbi in Figure 4) is a stronger version of result integrity ensuring that ballots tallied for honest voters have been actually cast by them.

# Election verifiability

Individual verifiability: if a voter successfully verifies the vote, it will be correctly counted for the final tally.
Result integrity: the tallied vote for each credential should correspond to a vote cast by the corresponding voter, unless that voter is corrupt, i.e. BBtally(cr, b) ⇒ Reg(id, cr) ∧ (Vote(id, v) ∧ v = open(b) ∨ Corr(id)).
