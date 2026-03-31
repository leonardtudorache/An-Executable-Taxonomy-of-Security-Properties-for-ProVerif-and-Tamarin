# Anonymity and Untraceability

In the authentication phase, the vehicle’s real identity IDi is concealed, utilizing the pseudonym RIDi. This approach ensures that adversaries cannot determine the actual identity of the vehicle, thereby maintaining anonymity. Moreover, the information uploaded to the blockchain by RSUs, (TIDi, nj, h(RIDi||TIDi||k)), only serves to verify the vehicle’s RID without revealing the RSU details. The dynamic temporary identity TID updates via blockchain, and refreshed TID values using RSU-specific nonces nk break long-term pseudonym linkage. With TIDi being refreshed during each handover authentication, it becomes impossible for adversaries to track the vehicle’s movement across RSUs, ensuring untraceability.

# Mutual Authentication

The improved protocol establishes robust mutual authentication through a bidirectional verification framework. Throughout the authentication phase, both RSUj and RSUk can deduce the vehicle’s pseudonymous RID from the transmitted vehicle data. In the initial authentication, the vehicle sends Ri and β, enabling the RSUs to verify the legitimacy of its pseudonymous RID using the TA’s public key, Y. The RSU cryptographically validates vehicle registration credentials using the TA’s public key through elliptic curve operations, while the vehicle authenticates the RSU by verifying timestamped session key hashes. This step ensures the authentication of Vi by the RSUs. Also, in both the initial and handover authentication phases, the vehicle receives M6 and M11, respectively. By verifying the source of these messages as being from RSUj and RSUk, in handover scenarios, infrastructure nodes authenticate vehicles through blockchain-stored identity records, while vehicles confirm RSU legitimacy via temporary identity decryption and session key verification.

# Perfect Forward Security

Even with access to keys like sj and k, adversaries cannot calculate the session key SKij due to the inclusion of Qij in the initial authentication phase. Since the necessary random numbers bi and bj for the computation of Qij are beyond the reach of adversaries, determining SKij is infeasible. This unavailability also extends to the TIDi required for subsequent handover authentication, ensuring our scheme’s provision of perfect forward security.

# Identity privacy

The proposed protocol should enable vehicle users to authenticate without revealing their identity and ensure that their activities and actions cannot be traced.

# Confidentiality

The proposed protocol needs to ensure that all data and information on public transmission channels remain private and prevent unauthorized access and leakage.

# Message integrity

The proposed protocol needs to ensure that the data transmitted during the authentication process have not been tampered with
