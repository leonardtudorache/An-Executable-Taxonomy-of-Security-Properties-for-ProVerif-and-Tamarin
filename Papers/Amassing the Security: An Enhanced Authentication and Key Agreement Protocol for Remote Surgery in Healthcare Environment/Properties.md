# Forward secrecy

### Informal definition

No general definition

### Notes

The forward secrecy seems to be verified using the **attacker** query.

# Anonymity

Since no information about Si’s identity is directly stored in Si’s smart card, an attacker cannot obtain Si’s identity information through smart card stolen attacks. Moreover, although A can intercept the message M1 = {Di, Bi, C1, C2, C3, C4, T1} on the public channel, A does not know the values of x and IDk; hence the attacker cannot obtain the IDi of Si by computing IDi = C1 ⊕ h(IDk ‖ x). Therefore, our protocol can provide user anonymity.
