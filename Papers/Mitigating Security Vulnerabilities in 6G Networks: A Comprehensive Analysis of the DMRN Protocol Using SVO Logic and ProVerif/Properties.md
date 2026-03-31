# Mutual Authentication

The DMRN Protocol is not significantly different from the 5G AKA in terms of mutual authentication. Specifically, in the mutual authentication between the UE and the HN, the UE authenticates the HN through the MAC value within the AUTN provided by the HN, and the HN authenticates the UE through the RES* value presented by the UE. More importantly, the two values, MAC and RES*, used for authentication are enhanced by the PQC-powered and PFS-enabled key KS2, and the sequential number SEQ is not used. In this way, the protocol aims to strengthen security compared to the 5G AKA. However, since the SEQ is not used, the UE cannot verify the freshness of the MAC value, as described based on (H2) during the SVO logic verification. To address this issue, the DMRN Protocol has the HN encrypt for the KS2 with the UE’s ephemeral PQC public key pkU, thereby imparting the timeliness of pkU to the encrypted result

# Secure Key Exchange

The KS1 is negotiated through the PQC KEM algorithm with the HN’s ECIES public key pkHN. From the HN’s perspective, it cannot confirm whether KS1 is fresh, because the key’s materials do not include any elements of freshness, as indicated by (H1) in the SVO logic verification. Consequently, the protocol is vulnerable to SUCI replay attacks. On the other hand, the master session key KAUSF and the anchor key KSEAF are derived from two keys, K and KS2. Notably, since the freshness issue of KS2 is addressed through pkU, and it is negotiated using the PQC KEM algorithm in a way that preserves PFS, wherein a strong key exchange is achieved to protect session keys, ensuring the security of signaling messages and user traffic.

# SUPI Concealment

SUPI concealment refers to protecting the privacy of the user’s permanent identifier during the authentication process in a 5G network. The SUCI is a concealed version of the SUPI that is transmitted over the air to prevent the user’s identity from being exposed. Given the operations (c1, KS1) ← Encaps(pkHN), c2 ← Enc(KS1, SUPI||pkU||IDSN), and c3 ← HMAC(KS1, c2), the SUCI is formed by concatenating c1,c2, and c3.

# Perfect Forward

Secrecy PFS refers to a security property that ensures the confidentiality of past communication sessions, even if the long-term keys used in those sessions are compromised in the future. Note that in the DMRN protocol, there are two long-term keys, K and skHN. Thus, for PFS, we should check whether the past session keys, which were derived from the two long-term keys, remain secure in the event that those long-term keys are leaked in the future. With regard to these long-term keys, there is an important key exchange for the key KS2, which is negotiated to derive the master session and anchor keys. The KS2 is agreed through the UE’s ephemeral PQC public key pkU, and since the corresponding private key skU is immediately deleted after the protocol execution, there is no way to recover it in the future.

# Quantum-Safe

Quantum-safe security requirements are essential to protect cryptographic systems against the potential threats of quantum computers, which can break traditional algorithms like RSA and ECIES. KEM addresses these requirements by enabling secure key exchanges based on PQC techniques, which rely on hard mathematical problems believed to be resistant to quantum attacks.
