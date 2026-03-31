# Forward Secrecy

### Informal definition

If AR obtains all the secret information of the sensor node SNj and the long-term master secret key KMS of MS, because of CDHP, he/she still cannot successfully calculate KSH � h(A1, A2, A3, A4∗, idj, T2) without knowing A4∗. Terefore, the protocol achieves perfect forward secrecy.

### Notes

The forward secrecy seems to be verified using the **attacker** query.

# Anonymity and Unlinkability

Te identity idj of the sensor node SNj is in Message 1 � xNj, yNj, Vidj, A1, Tj, T1 􏽮􏽯 and transmitted via an open channel, where Vidj � h(idj, xNj, yNj, A1, A2, h(A2, MHj)Tj, T1), MHj � h(idj, KMS), yNj � idj⊕ h(KMS, aj, Tj). So an adversary cannot compute the identity idj of the sensor SNj because he can not know the secret key KMS of MS. Tus, our scheme achieves anonymity. Moreover, because each session will generate new bj and Tj, the identity idj of the sensor node SNj cannot be tracked by AR.
