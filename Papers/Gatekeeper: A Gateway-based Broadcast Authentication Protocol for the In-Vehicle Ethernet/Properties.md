# SR1 Key Material

Each in-vehicle node MUST own a cryptography key material, which will be used to protect the in-vehicle communication. Specifically, the security protocol MUST support both the symmetric key (e.g., pre-shared key) and the certificate (e.g., public/private key).

# SR2 Integrity

The security protocol MUST support integrity protection to prevent tampering with any data sent over the communication channel.

# SR3 Confidentiality

Confidentiality is an OPTIONAL requirement. It can prevent eavesdropping on the network data. It depends on the use scenarios if this requirement should be enforced (e.g., the transmission of privacy-related data). Besides, enforcing confidentiality brings performance overhead, as shown in Figure 6. Therefore, we leave this as an optional requirement.

# SR4 Authenticity

The security protocol MUST support authentication for the in-vehicle communication. As mentioned in § 4, the attacker is able to join the in-vehicle network. There is no default mechanism of verifying the authenticity of an added malicious device to the in-vehicle network. Therefore, the security protocol needs to ensure that only pre-authorized ECUs are allowed to participate the in-vehicle communication. Since both the symmetric key and certificate must be supported (SR1), the authentication can happen via a symmetric pre-shared key (PSK) or asymmetric cryptography (e.g., RSA, ECDSA).

# SR5 Source Authentication / Spoofing Attack Prevention

For broadcast communication, the protocol participants within a group MUST be able to verify the identity of the sender; otherwise, a spoofing attack can occur within a given group, which is a wellknown vulnerability for CAN bus.

# SR6 End-to-End Protection

The security protocol MUST offer end-to-end security (e.g., integrity, optional confidentiality, and authentication), in which "end" means an ECU. If confidentiality is enabled, only the end nodes can decrypt the packet. Due to the integrity protection, any other nodes (e.g., domain controller, gateway) along a network path cannot modify the packets. For the given architecture in this document (§ 3.1), there are two types of end-to-end protection: (1) intra-domain end-to-end protection (security protocol at L2 is sufficient) and (2) inter-domain end-to-end protection (security protocol at L3 or above is sufficient).

# SR7 Replay Attack Prevention

The security protocol MUST be able to prevent replay attacks. For example, the security protocol can attach a counter [2, 35, 51] or a timestamp in the packet. This will allow the receiver to discard any messages with a repeated/outdated counter or timestamp.

# SR8 DoS Prevention

The security protocol MUST provide the DoS protection mechanism and prevent the attacker from aggressively consuming netwo
