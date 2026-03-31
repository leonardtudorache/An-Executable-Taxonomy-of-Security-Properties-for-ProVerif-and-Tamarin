# Confidentiality

we tested the secrecy of the symmetric key shared between the device and the owner at the end of the key exchange protocol in the TO2 phase. If the attacker possessed this key, he would be able to decipher all subsequent application messages exchanged after the onboarding process.

# Authentication

Concerning authentication both authentication of the Owner to the Device and, vice versa, of the Device to the Owner were verified. Thus, we expect that only the Owner, as the unique legitimate owner of the OV, can authenticate correctly to the device using this certificate. On the contrary, the device is expected to be the only entity able to authenticate to the Owner using its private key corresponding to OV DevCertChain contained in the OV
