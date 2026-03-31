# Node Anonymity

Sensor node identity I DS in the proposed protocol is secured while transferring it over the public channel. The sensor node’s anonymity is preserved in our protocol in this manner.

# Untraceability

The proposed protocol is secured using three-factor authentication (Identity, password and biometric) which are further secured using hash function. Therefore, E cannot differentiate between messages from different users. Moreover, time stamp is used to add an additional security layer in our protocol.

# User Anonymity

When E is unable to obtain the user’s identity, password, or biometric, the user’s anonymity is preserved. As σ ∗ = Rep(B∗ U , τ ), b∗ = YU ⊕ h(I D∗ U ||P W ∗ U || σ ∗)mod m, a hash function and a fuzzy verifier are applied to protect biometrics in this system. As a result, E will be unable to retrieve biometric data from smart card.

# Mutual authentication

Mutual authentication is maintained in the proposed protocol. Before starting the processing, incoming messages are always authenticated first. For instance, on receiving message (L, O, T3) from sensor node, GWN computes L∗ = h(S K ||I DS||T3) and verifies if L∗ = L. If they are not equal, then session is killed. Similarly, sensor node and user node also follow the authentication at their end.
