## Security Properties

### Noninjective group agreement.
When a group member concludes a protocol run using certain data values v, it indicates that another member of the group has previously executed the protocol with the identical data values v.

### Injective group agreement.
In addition to noninjective group agreement, every protocol execution performed by a group member in the role of verifier must correspond to a distinct protocol execution by a valid entity acting as prover. This notion exemplifies the scenario of single-cast, as it states that a valid protocol run should be accepted by a group member only once.

### One-time group agreement.
When a group member, denoted as A, successfully concludes a protocol run using certain data values v, it indicates that another group member has previously been engaged in running the protocol with the same data values v, and A has not previously participated in a protocol run corresponding to this specific instance.

### Secrecy.
Message payloads should remain secret for all but the intended recipient.
