## Pairing Security Properties

**PAIR-1: PEG authentication**
Whenever the deployment manager believes to have established a session key with a PEG G, PEG G established the same session key. Hence, PEG is authenticated to the deployment manager and, by extension, to the user. This ensures, even while pairing over wireless interfaces, that PEG which performed the pairing is, in fact, the same PEG in the scanned device.

**PAIR-2: Weak manager authentication**
Whenever PEG G establishes a key with the deployment manager M, the latter (or its delegate) must have earlier scanned the data inscribed on the device in which G is present. This is accomplished by mixing PSK in the handshake, thereby verifying that the party performing the pairing had, at some point, physical access to the device.

**PAIR-3: Key secrecy**
Whenever the deployment manager establishes a key with a benign PEG, that key is not known to the adversary.

**PAIR-4: Verification of intent**
No new keys can be established without a time-adjacent physical interaction. This ensures that an entity with current physical device access intends to pair the device.
