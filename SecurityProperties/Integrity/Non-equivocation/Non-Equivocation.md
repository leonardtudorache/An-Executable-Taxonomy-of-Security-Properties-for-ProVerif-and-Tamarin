```mermaid
sequenceDiagram
    participant Signer
    participant Receiver

    Note over Signer: Sign(A, B, m0, zero)
    Signer->>Receiver: (A, B, m0, zero, sig0)

    Note over Receiver: Check b0 = B
    Note over Receiver: Verify sig0 against bind(A, B, m0, zero)
    Note over Receiver: Trigger event accepted(A, B, m0, zero)
    Note over Receiver: Advance local chain position to zero

    Note over Signer: Sign(A, B, m1, succ(zero))
    Signer->>Receiver: (A, B, m1, succ(zero), sig1)

    Note over Receiver: Require a1 = a0 (same claimed sender as the zero-step)
    Note over Receiver: Verify sig1 against bind(A, B, m1, succ(zero))
    Note over Receiver: Trigger event accepted(A, B, m1, succ(zero))
    Note over Receiver: Trigger event accepted_link(A, B, m0, m1, zero) -- carries m0 forward as the completeness witness
    Note over Receiver: Advance local chain position to succ(zero)

    Note over Signer, Receiver: (i) Completeness -- accepted_link(.., m0, m1, zero) implies accepted(A, B, m0, zero) already happened
    Note over Signer, Receiver: (ii) Order preservation -- zero is always accepted before succ(zero)
    Note over Signer, Receiver: (iii) Uniqueness -- a given counter is accepted at most once (within this single Signer/Receiver instance; see .pv comments on why the pair is not replicated)
```
