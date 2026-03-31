### (1) Mutual Authentication, Correctness, and Integrity

Both authorized parties, such as the authorized vehicle and RSU, communicating with BEPHAP can be verified as legitimate entities. The message sent by an accredited vehicle or RSU can be proved correct without being modified or fabricated.

### (2) Data Confidentiality

Confidentiality ensures that only legitimate receivers can access the content of a message, which may contain sensitive information. External adversaries cannot obtain any confidential information, and internal attackers cannot access anything beyond their initial private information.

### (3) Conditional Privacy-Preserving

BEPHAP meets the conditional privacy-preserving requirements as follows:

#### (a) Identity Anonymity

No one except for the LEA can reveal the real identity of a vehicle based on received or intercepted messages.

#### (b) Unlinkability

No one can link multiple messages to the same vehicle, except for entities that require this information initially, such as LEA, RSM, and RSU.

### (4) Traceability

The real identity of the message sender should be bound to the message so that the LEA can trace vehicles sending malicious messages.

### (5) Non-Repudiation

Only the LEA can identify the vehicle related to a verification message. It can reveal the real identity of a vehicle in the event of a dispute. Only the vehicle itself can send the associated authentication information, preventing denial of malicious behavior.

### (6) Non-Frameability

No external or internal attacker, including the LEA, can frame an honest vehicle.

### (7) Resisting Attacks

The proposed scheme can withstand typical attacks launched by external adversaries, such as:

- Replay attacks
- Man-in-the-middle attacks
- Impersonation attacks
- Modification attacks

### (8) Key Escrow Freeness

Except for the vehicle itself, no entity has access to its private keys.
