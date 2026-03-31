# Forward Secrecy

secrecy of message m is preserved even if the attacker recovers the encryption keys after S is completed.

### Informal definition

Assuming that the current k is strong and secret, secrecy after rekeying is preserved even if the authorization keys of both parties are compromised before the rekeying protocol is executed. This can be proved in ProVerif by running the rekeying protocol without encrypting the messages with the authorization keys so that they are accessible to the adversary (which models the untrusted server), then letting A and B exchange a message m encrypted with the new key, and finally verifying that the attacker cannot obtain m:

`query X : Principal, m : Msg, k : SharedKey, a, b : Zp; `

`event(ClientSendsMessageWithNewKey(X, k, m)) `

`   ∧ attacker(m)`

`⇒ (event(RevealedInitiatorEphemeralKey(a)) `

`   ∧ event(RevealedResponderEphemeralKey(b)))`

` ∨ (event(PostCompromisedInitiatorEphemeralKey(a))`

`    ∧ event(PostCompromisedResponderEphemeralKey(b))).`

If client X sends a secret chat message encrypted with the newly negotiated key, then the message can be learned by the attacker only if both exponents are leaked, during or after the rekeying session.

Forward secrecy and future secrecy are guaranteed by the periodic rotation of the keys, assuming that each new key established via the rekeying protocol is independent of the previous keys (which is the case if the exponents are uniformly random). If an attacker recovers a session key, she can decrypt at most 10 0 messages or a week worth of messages. While older or newer messages cannot be deciphered, in some circumstances such window of compromise might still be considered excessively wide. Given the above, leaking an authorization key at any time does not compromise the secrecy of any message.

**Search for keyword PFS in the models (perfect forward secrecy)**

### Notes

The forward secrecy is verified using a proper query.

# Secrecy

if a message m is exchanged in a session S between two honest principals A and B then m is secret (i.e., known only to A and B) unless an attacker can break some cryptographic construction or recover the encryption keys before or during S.

# Authentication

if B receives m which is supposed to come from A, then it was really sent by A.

# Integrity

if m is sent from A to B then B receives m and not some forged m′ = m instead.
