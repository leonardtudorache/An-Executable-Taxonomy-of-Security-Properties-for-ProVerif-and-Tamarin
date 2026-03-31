# Forward Secrecy

### Informal definition

Suppose that the adversary A gains the server’s long-term data SIDj and Xs in the proposed protocol. Regarding the session key equation SK = SKu = SKs = h (V 2||Ns||IDi||SIDj ) = M2 ⊕ h ( Xs||V 2||IDi), it will be computational impossible for A to acquire the temporarily established session key because in the login and authentication phase, parameters IDi and V 2 can not be extracted by A according to the analysis in the part of resist key compromise impersonation attack, and the random number Ns is not transmitted via a public channel in any plaintext or ciphertext forms. Hence, the proposed protocol provides the security property of perfect forward secrecy.

Perfect forward secrecy means that, the leakage of the crucial long-term secrets, such as the private keys of users or server, will not necessarily expose the session key in previous sessions to the adversary

### Notes

The forward secrecy seems to be verified using the **attacker** query.

# Mutual Authentication

The proposed scheme achieves mutual authentication in the following two processes. Firstly, after getting the messages {G I Di , T1, M1, B3, B4} from a user, the server checks the condition M1∗ = M1 and if the condition is met, the user is authenticated successfully by the server. Secondly, after the server produces the messages {M2, M3, T2} and sends them to the user, the user also checks the condition M3∗ = M3 and if the condition is met, the server is authenticated successfully by the user.

# Anonymity and Untraceability

When the adversary A attends to extract the user identity I Di with the knowledge of the information sent in the public channel, it has to compute E R Di = B3 ⊕ h (T1|| Xs) and I Di = E R Di ⊕ h (Nr ||S I D j ). However, A cannot do this without obtaining the parameter Nr stored in server’s private blockchain and server’s long-term secret key Xs synchronously. If the adversary A wants to sponsor a tracing attack through the messages transmitted in the public channel, then at least one long-term message is needed. Nevertheless, there are no longterm messages in either {G I Di , T1, M1, B3, B4} or {M2, M3, T2}, or in other words, ephemeral information exists in each message of {G I Di , T1, M1, B3, B4} and {M2, M3, T2} (e.g., “Nu ” and “T1” exist in equations “G I Di = (Nu · B1) ⊕ h (I Di||T1|| Xs)” and “M1 = h (Gi||T1|| (Nu · B1))”, “T1” exists in equation “B3 = E R Di ⊕ h (T1|| Xs)”, “Nu ” exists in equation “B4 = Aui ⊕ h (Nu · B1||I Di)”, etc.). Therefore, the proposed protocol not only provides anonymity for users, but also supports the untraceability feature of users.
