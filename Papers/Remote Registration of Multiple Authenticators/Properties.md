# Secure hardware-based authentication.

Only those with physical access to a registered authenticator can authenticate. Another factor, such as a password or a biometric, may be added for local authentication (of the user to the authenticator) or as a second factor for the RP.

# Secure registration of authenticators.

Authenticators can be registered when an account is created. They can also be registered during a session in which the user has already authenticated with a registered authenticator. Authenticators cannot be registered in any other instance.

# Interchangeable authenticators.

For convenience and resilience, the user can designate a set of authenticators such that each authenticator in the set has the same functionality and can be used interchangeably. The loss or destruction of a subset of authenticators does not prevent the remaining authenticators from functioning.

# Privacy across RPs.

A user’s interactions with an RP cannot be linked to their interactions with any other RP.

**Unique key pairs.** The derived key pairs are unique for each RP. Using the same public key across different RPs can lead to vulnerabilities in privacy. This would conflict with our design goals in Sec. 3.

**R2 Repeatable key derivation.** Key pairs can be derived deterministically and on demand. This minimises information that authenticators must store.

**R3 Secure private keys.** Each authenticator in the set can derive exactly one private key for each RP. No entity outside of the set can compute any private keys.

**R4 Mutually derived public keys.** In addition to their own public key, each authenticator can derive the public keys of other authenticators in the set.

**R5 Privacy preserving public keys.** Other than authenticators in the set, no other entity can derive the public keys which are used for authentication. Otherwise, they would be able to link public keys across RPs.

**R6 Compatibility with chosen signature schemes.** Finally, the derived key pairs should be compatible with the appropriate signature scheme for each solution in Sec. 4.
