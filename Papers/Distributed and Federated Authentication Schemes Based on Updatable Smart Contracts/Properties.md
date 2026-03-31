# Forward And Backward Secrecy

### Informal definition

Forward Secrecy and Backward Secrecy: Even if the attacker obtains the session key, they will be unable to access the previous or subsequent keys, as each one is generated randomly with no correlation to the others. Therefore, the proposed scheme can preserve forward and backward secrecy.

### Notes

The forward secrecy seems to be verified using the **attacker** query.

# Mutual Authentication

The user and the SP authenticate each other by verifying MU and MSP because MU and MSP can utilize their private keys. Therefore, the proposed scheme provides mutual authentication.

# Anonymity

In the proposed scheme, T IDU/SP, which changes at every authentication step, was used. Therefore, the proposed scheme ensures user anonymity.
