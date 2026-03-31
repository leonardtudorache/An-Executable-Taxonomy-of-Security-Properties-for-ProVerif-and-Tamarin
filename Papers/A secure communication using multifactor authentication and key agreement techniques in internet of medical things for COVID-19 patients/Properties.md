# Authentication

In this type of attack, Adt successfully assumes the identity of one of the legitimate users or parties to achieve authentication over a protocol. In our scheme, a secret key MSkey of MS, user identity pIdi, random number is chosen by MS like Rj and Ri is not known to Adt. The Adt can not compute the P1j = h (sIdj ||||MSkey|||| Rj ) , P3i = h (pIdi ||||MSkey|||| Ri ) and authentication message < P10ij > . Therefore, Adt cannot impersonate Ui to take-off Sj. Hence, our scheme resists impersonation attacks.

# Perfect Forward Secrecy

In this type of attack, the session key and the privacy of any past or future session must not be exposed to the attacker. In our protocol, session key SK = h(R1 ∣ |||R∗ 2 ||| ∣ R∗ 3) shared between Ui and Sj should not be revealed to Adt. Since in session key R1, R∗ 2, and R∗ 3 are random numbers chosen by the sensor node and user which will differ in every new session. The session key is masked with the hash function. Hence, the adversary cannot get any info regarding the session key so we can claim our scheme resists the perfect forward secrecy.

# Untraceability

The un-traceability means the identity of the user and sensor should not be traceable by the Adt. In the proposed protocol the doctor’s identity pIdi and sensor sIdj are never transmitted directly through an insecure channel. Moreover, to authenticate both the Ui and Sj require the random nonce R1, and R2 which is always fresh for every new session. Hence, our protocol resists the un-traceability of the user and sensor node.
