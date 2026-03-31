# Confidentiality of Tenant Designs

The protocol ensures tenant design confidentiality throughout validation and deployment.

# Design Integrity in the TEE

To ensure that the design received by the TEE is not tampered with, we verified that the TEE only validates designs that were explicitly submitted by the tenant. Cryptographic mechanisms such as encryption and digital signatures ensure that the design remains unmodified during transmission. The results confirmed that the TEE does not validate or receive any design unless it matches what was submitted by the tenant, thereby preventing tampering or forgery of the design.

# Mutual Authentication between Tenant and FPGA

Mutual authentication is critical to ensuring that the tenant is communicating with the correct FPGA, and vice versa. We verified that the tenant and FPGA authenticate each other before proceeding with key exchange and bitstream deployment.

# Secure Key Establishment

To ensure that a secure shared key is established between the tenant and FPGA, we verified that the key is derived only after a successful ECDHE exchange. The results confirmed that the shared key is always derived from a valid ECDHE exchange, ensuring secure key establishment for encrypting the bitstream.
