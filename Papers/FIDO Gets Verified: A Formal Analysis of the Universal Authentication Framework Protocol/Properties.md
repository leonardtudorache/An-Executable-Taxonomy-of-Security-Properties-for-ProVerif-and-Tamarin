# Strong User Authentication

Authenticate (i.e., recognize) a user and/or a device to a Relying Party with high (cryptographic) strength.

SG-10 DoS Resistance: Be resilient to Denial of Service Attacks. I.e., prevent attackers from inserting invalid registration information for a legitimate user for the next login phase. Afterward, the legitimate user will not be able to log in successfully anymore. SG-11 Forgery Resistance: Be resilient to Forgery Attacks (Impersonation Attacks). I.e., prevent attackers from attempting to modify intercepted communications to masquerade as the legitimate user and log into the system. SG-12 Parallel Session Resistance: Be resilient to parallel Session Attacks. Without knowing a user’s authentication credential, an attacker can masquerade as a legitimate user by creating a valid authentication message out of some eavesdropped communication between the user and the server. SG-13 Forwarding Resistance: Be resilient to Forwarding and Replay Attacks. Having intercepted previous communications, an attacker can impersonate the legal user to authenticate to the system. The attacker can replay or forward the intercepted messages.

#### SG-10: DoS Resistance

Be resilient to **Denial of Service (DoS) Attacks**.  
Prevent attackers from inserting invalid registration information for a legitimate user during the next login phase. This ensures that the legitimate user can still log in successfully.

#### SG-11: Forgery Resistance

Be resilient to **Forgery Attacks (Impersonation Attacks)**.  
Prevent attackers from modifying intercepted communications to masquerade as the legitimate user and gain unauthorized access to the system.

#### SG-12: Parallel Session Resistance

Be resilient to **Parallel Session Attacks**.  
Without knowing a user’s authentication credentials, an attacker should not be able to masquerade as the legitimate user by crafting a valid authentication message from eavesdropped communication between the user and the server.

#### SG-13: Forwarding Resistance

Be resilient to **Forwarding and Replay Attacks**.  
Prevent attackers from using previously intercepted communications to impersonate a legitimate user. This includes replaying or forwarding old messages to gain unauthorized access.

### Security Goals

#### SG-5: Verifier Leak Resilience

Be resilient to **leaks from other relying parties**.  
Nothing that a verifier could possibly leak should help an attacker impersonate the user to another relying party.

#### SG-6: Authenticator Leak Resilience

Be resilient to **leaks from other FIDO Authenticators**.  
Nothing that a particular FIDO Authenticator could possibly leak should help an attacker impersonate any other user to any relying party.

#### SG-7: User Consent

Notify the user **before establishing a relationship with a new relying party**, requiring **explicit consent** from the user.

#### SG-14: Transaction Non-Repudiation

Provide **strong cryptographic non-repudiation** for secure transactions, ensuring that actions cannot be denied after the fact.

#### SG-4: Unlinkability

Protect the protocol conversation such that **any two Relying Parties cannot link** the conversation to the same user, preserving user privacy.

# Confidentiality Properties

The confidentiality of skAT , skAU , and kW is required in Section 4.1 of the security reference. Formally, the cryptographic key skAT , skAU , and kW should remain secret in the presence of the active attacker during the registration and the authentication process.

# Privacy Properties

The UAF protocol should ensure that the private data related to the user cannot be compromised. Otherwise, the attacker can identify a user or trace user behaviors.
