## TPM-Based Security Extensions for DDS

### Code Base Attestation

Our extension of the DDS security architecture must introduce support for the **TPM-based attestation** of remote participants’ code bases. The attestation process should be **transparently integrated** into the existing DDS authentication protocol. To allow flexible configurations for different use cases, both **unidirectional** and **bidirectional (mutual)** remote attestation must be supported.

### (R2) Integrity Verification

DDS participants must be able to specify **“golden” reference values** for the expected PCR digests of their trustworthy software stacks. These reference values should be **automatically used** by all peers for verifying transmitted attestation evidence.

### (R3) Attested Channels

The protocol extension must **cryptographically bind** the established secure communication channels to the **attested trusted platforms**. This is necessary to:
- Prevent **masquerading attacks** [24]
- Ensure that transmitted messages can only be encrypted by **trustworthy DDS participants** with verified code bases

### (R4) Replay Protection

Attackers must **not be able to replay** previously intercepted attestation evidence to impersonate a trusted platform.

### (R5) Backwards Compatibility

Since DDS is deployed in distributed systems, we cannot assume all participants:
- Have a platform TPM
- Run an extended DDS implementation with remote attestation support

To prevent **partitioning** of the DDS network and ensure **seamless communication**, our protocol extension must provide **full backwards compatibility** with the standard non-TPM authentication process.
