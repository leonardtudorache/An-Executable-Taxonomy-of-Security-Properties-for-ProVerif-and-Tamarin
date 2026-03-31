# Authentication

The notion of authentication was defined as that every entity must be able to verify whether they are talking to the “right person”. This goal was divided into two sub-goals. First, each entity(client or server) can verify whether the other endpoint is operated by the expected middleboxes. It is called entity authentication. Second, If a session between two endpoints consists of an ordered set of middleboxes M B1 ... M Bn−1, then any data received by M Bj must be a prefix of the data sent by M Bj−1 or M Bj+1, where 1 < j < n − 1. It is called data authentication. We refined entity authentication into two security goals. First, the client ensures the delegated middleboxes by verifying the warrant in signature. It is called verifiability. Second, each middlebox can be identified as an appropriately delegated middlebox by checking its public key from the proxy signature. It is called strong-identifiability.

# Secrecy

The notion of secrecy can be defined as that adversaries should learn nothing more from observing ciphertext in network connections. This goal is divided into two sub-goals. First, each mdTLS segment sent from entities should be encrypted with a strong ciphersuite. It is called segment secrecy. Second, each segment should have its own security parameters, such as a unique session key, to prevent the data from being reused. It is called individual secrecy.

# Integrity

The notion of integrity means that only authorized or delegated entities can make or modify messages under their permissions. This goal is divided into two sub-goals. First, the entity can confirm which middleboxes have made each modification to the message. It is called modification accountability. Second, endpoints can determine the list and order of middleboxes that messages pass through. It is called path integrity. In mdTLS, we defined one security goal additionally. Delegated middleboxes can generate valid signatures. It means, in converse, undelegated entities cannot modify messages because they cannot generate and verify the signatures. Hence, it is called strong-unforgeability.
