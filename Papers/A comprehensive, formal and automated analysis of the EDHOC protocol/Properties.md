# Confidentiality

** \( \text{pkR}, k_3, k_4, X, GY, i, j, k \). 
If 
**AcceptI**(\( \text{pkI}, \text{pkR}, k_3, k_4, X, GY \)) @ \( i \) 
**and** KU(\( k_4 \)) @ \( j \) 
**and\*\* Honest(\( \text{pkR} \)) @ \( k \) 
then

**⇒⇒⇒** 
There exists a time \( t \) such that:

- \( \text{Compromise}(\text{pkR}) @ t \land t < i \) 
    **or**
- \( \text{LeakSessionKey}(k_4) @ t \) 
    **or**
- \( \text{LeakShare}(GY) @ t \) 
    **or**
- \( \text{LeakShare}(X) @ t \)

## Explicit Key Confirmation

After verifying message3, the Responder is assured that the Initiator has calculated the key PRK4x3m (explicit key confirmation) and that no other party than the Responder can compute the key.

## Implicit Key Authentication

After sending message3, the Initiator is assured that no other party than the Responder can compute the key PRK4x3m.

## Session key independence

Compromise of one session key does not compromise other session keys.

## Forward Secrecy

Compromise of the long-term keys (private signature or static DH keys) does not compromise the security of completed EDHOC exchanges.

# Authentication

**∀∀∀** \( \text{pkI}, \text{pkR}, k_4, Y, GX, i, k \). 
If 
**AcceptR**(\( \text{pkI}, \text{pkR}, k_4, Y, GX \)) @ \( i \) 
**and** Honest(\( \text{pkI} \)) @ \( k \) 
then

**⇒⇒⇒** 
There exists a time \( t \), and values \( X, GY, k_3 \) such that:

- \( t < i \land \text{AcceptI}(\text{pkI}, \text{pkR}, k_3, k_4, X, GY) @ t \) 
    **or**
- \( \text{Compromise}(\text{pkI}) @ t \) 
    **or**
- \( \text{LeakShare}(Y) @ t \)

## Authenticated transcript hash

Transcript hashes (hashes of message data) T H2, T H3, T H4 (are) used for key derivation and as additional authenticated data.

## Authenticated data

EDHOC adds an explicit method type and expands the message authentication coverage to additional elements such as algorithms, external authorization data, and previous messages.

## Key compromise impersonation

Compromising the private authentication keys of one party lets an active attacker impersonate that compromised party in EDHOC exchanges with other parties but [...] does not let the attacker impersonate other parties in EDHOC exchanges with the compromised party.

# Identity Protection

```proverif
! (
  new sk1;
  out(pk(sk1));
  new sk2;
  out(pk(sk2));

  ! in(pkR); Init(sk1, pkR)
  |
  ! in(pkR); Init(sk2, pkR)
  |
  ! Resp(sk1)
  |
  ! Resp(sk2)
  |
  ! Init(skb, pk(sk1))
)
```

EDHOC protects the credential identifier of the Initiator against active attacks and the credential identifier of the Responder against passive attacks.

# Non-repudiation

∀∀∀** \( \text{pkr}, \text{derivedKey}, \text{proofnr}, i, j \). 
If 
**WasActiveR**(\( \text{pkr}, \text{derivedKey}, \text{proofnr} \)) @ \( i \) 
**and\*\* Honest(\( \text{pkr} \)) @ \( j \) 
then

**⇒⇒⇒** 
There exists a time \( k \) such that:

- \( \text{DerivedRShared}(\text{pkr}, \text{derivedKey}) @ k \) 
    **or**
- \( \text{Compromise}(\text{pkr}) @ k \)

In EDHOC authenticated with signature keys, the Initiator could theoretically prove that the Responder performed a run of the protocol by presenting the private ephemeral key, and vice versa.

Soundness: if evidence is accepted by a judge then the designated party did participate in the session.  
Completeness: if a party did participate in a session, then the other participant can present evidence to the judge that will be accepted.
