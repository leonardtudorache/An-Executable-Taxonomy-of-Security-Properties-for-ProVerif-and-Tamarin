# Forward Secrecy

### Informal definition

The forward secrecy of the session key indicates that, although the long-term key x of Sj is leaked to A, all previous session keys remain safe. Assume that A eavesdrops further: {{M1, M2, K1}, {K3, M3}}. To calculate the prior session key SK = H(K4 ‖ IDi ‖ Vi), A needs to know IDi ‖ Vi = DK2 (M2) = Da·X(M2) and K4 = b · K1 = abP. Further, computational difficulties arise for A when they try to obtain the stochastic parameters a or b. Thus, A is unable to calculate SK. Forward secrecy can be achieved successfully with the presented 2FA protocol.

### Notes

The forward secrecy seems to be verified using the **attacker** query. And there is an injective event query that is not properly defined → might be related to secrecy.

# Untraceability and Anonymity

User anonymity refers to hiding part of the user’s information during communication, and un-traceability means that the user’s identity cannot be tracked. Practically, in order to obtain the user’s identity during the communication session, A needs to extract all parameters {ai, Ai, Bi, X, P, n0} stored in SCi and obtain {M1, M2, K1}, {K3, M3} from Ui and Sj, but no identity information is preserved in the user’s smart card or conveyed over the open channel in the proposed protocol. For user traceability, M1 = H(IDi ‖ K1 ‖ K2 ‖ Vi) and M2 = EK2 (IDi ‖ Vi) are variable. The user’s real identity IDi cannot be traced by A. Thus, user anonymity and un-traceability can be achieved.

# Mutual Authentication

In the presented protocol, Sj verifies Ui by checking whether M∗ 1 = M1, while Ui checks Sj by verifying if M′ 3 = M3. After mutual authentication, a common session key SK is negotiated by Sj and Ui; that is, mutual authentication can be achieved safely with the proposed protocol.
