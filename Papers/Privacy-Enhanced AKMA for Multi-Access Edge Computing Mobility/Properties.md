# Forward Secrecy

### Informal definition

**Forward secrecy** protects against an attacker that has a recording of some past (encrypted) sessions. More precisely, forward secrecy ensures that past recorded encrypted messages (session keys) will remain secret, despite the long-term keys being compromised at some point. One can use ProVerif to show that even if some party in the protocol is corrupted (long-term keys are leaked), the secrets that are shared before the corruption are not revealed to the attacker. Assuming that a long-term key K leaked in the first execution (phase 0), forward secrecy for the subsequent protocol execution (phase 1) is checked by adding the process phase 1; out(c,K) to the main process, where c is a public channel \[Automatic Cryptographic Protocol Verifier. User Manual and Tutorial, INRIA Paris-Rocquencourt. 2021\]

### Proverif

**Forward Secrecy:** In order to prove forward secrecy, we updated the main process of the protocol as follows. `process`

`  new ID_MNO:bitstring;`

`  new ID_AF:bitstring;`

`  (!UE(SUPI,ID_MNO,ID_AF,K) | !MNO(SUPI,ID_MNO,K) | !AF(ID_AF)| phase 1;`

`  out(chUEAF,( K, SUPI, ID_AF)))`

Then, we run the same secrecy queries mentioned above, and ProVerif provides the following outputs: **Verification summary:**

Query not attacker_p1(K\[\]) is false.

Query not attacker_p1(SUPI\[\]) is false.

Query not attacker_p1(nAKID\[\]) is false.

Query not attacker_p1(nKAKMA\[\]) is false.

Query not attacker_p1(nKAF\[\]) is false.

### Notes

The forward secrecy seems to be verified using the **attacker** query.

# Secrecy

The attacker cannot reach the private information. Therefore, the secrecy queries verify the confidentiality and privacy of data. In ProVerif, the secrecy of the term M can be verified using the command query attacker(M). If ProVerif returns query not attacker (M) is true, then the term M remains secret despite the presence of an attacker in the public channels

# Reachability

An event occurs in the protocol. In ProVerif, the reachability of event e can be checked with query event(e)

# Strong secrecy

means that the attacker cannot notice the differences between different sessions that follow from changing secrets in the protocol. It is similar to the concept of indistinguishability and semantic security in the computational proof-based approach in cryptography

# Authentication

The protocol guarantees agent A the aliveness of agent B, if whenever A completes a run of the protocol (apparently with B) then B has previously been running the protocol. Aliveness does not guarantee that B believes that B ran the protocol with A. • The protocol guarantees agent A a weak agreement with agent B, if whenever A completes a run of the protocol (apparently with B) then B has previously been running the protocol, apparently with A [24]. • The protocol guarantees agent A a non-injective agreement with B, if whenever A completes a run of the protocol, apparently with B, then B has previously been running the protocol, apparently with A, both A and B have an identical value for a data item M [24]. The non-injective agreement does not rule out the case when A runs the protocol twice, and B takes part in only one of the runs. If the non-injective agreement is not satisfied, A can be subject to an impersonation attack [25]. • The protocol guarantees agent A an injective agreement with B if, whenever A completes a run of the protocol, apparently with B, then B has previously been running the protocol, apparently with A, both A and B agree on the message M, and each such run of A corresponds to a unique run of B [24]. If the injective agreement is not satisfied, A can be subject to a replay attack [25].
