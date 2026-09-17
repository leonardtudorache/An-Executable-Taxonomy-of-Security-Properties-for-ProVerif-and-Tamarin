```mermaid
sequenceDiagram
    participant Initiator
    participant Server
    participant Responder

    Note over Initiator: Choose identity xA and target hostX
    Initiator->>Server: send(xA, hostX)

    Note over Server: Retrieve public key certificate for hostX
    Server->>Initiator: send(sign((pkX, hostX), skS))

    Note over Initiator: Generate nonce Na
    Initiator->>Responder: send(encrypt((Na, xA), pkX))

    Note over Responder: Decrypt message, extract Na and hostY
    Responder->>Server: send(xB, hostY)

    Note over Server: Retrieve public key certificate for hostY
    Server->>Responder: send(sign((pkY, hostY), skS))

    Note over Responder: Generate nonce Nb
    Responder->>Initiator: send(encrypt((Na, Nb, xB), pkY))

    Note over Initiator: Decrypt message
    Note over Initiator: Trigger event start(xA, hostX, (m3, m, m7))
    Initiator->>Responder: send(encrypt(Nb, pkX))

    Note over Responder: Verify Nb
    Note over Responder: Trigger event end(hostY, xB, (m, m6, m3))

    Note over Initiator, Responder: Property: event(end(A,x,m)) ==> event(start(A,x,m))
```
