# Forward Secrecy

### Informal definition

Forward secrecy is that even if the adversary compromised the long-term secret, i.e., 𝐺𝑊 𝑁’s 𝑥, the past session keys are still secure. Factually, suppose the adversary knows 𝑥, and further gets 𝐵1 and 𝑥𝑗 , and next obtains 𝐴3 and 𝐴4. However, given the hardness of problem ECCDH, s/he cannot compute 𝐴5 to get 𝑆𝐾. As a result, the proposed protocol achieves the forward secrecy.

### Notes

The forward secrecy seems to be verified using the **attacker** query.

# Mutual authentication

In the proposed protocol, Ui and GW N authenticate each other by the way that GW N checks if D∗ 3 = D3, and Ui sees if D∗ 13 = D13. Then, SNj and GW N authenticate each other by checking if D∗ 6 = D6 and D∗ 9 = D9, respectively. That is, the proposed protocol is of the mutual authentication.

# User anonymity

User anonymity denotes the user’s identity-protection, and the user’s un-traceability. For evaluating the identity-protection, on the one hand, in the registration phase, Ui only submits the hash value A0 to GW N, even if GW N may be corrupted, the adversary can extract no identity information; On the other hand, in the verification phase, the pseudo P IDi in public channel cannot be used to capture user’s real identity I Di . For user’s un-traceability, the randomness of pseudo P IDi directly confuses the adversary to judge whether two communicative sessions he observed are from the same user or not.

# Session key agreement

Session Key Agreement denotes that any one cannot solely or precompute session key without the participating of another one. Given SK = h(A5‖h(B1)‖rg), SK must be comprised of Ui’s timely secret parameter (ru), SNj ’s newly secret parameter (rs), and GW N’s rg, any one of them (Ui or GW N or SNj ) cannot pre-compute the session key.
