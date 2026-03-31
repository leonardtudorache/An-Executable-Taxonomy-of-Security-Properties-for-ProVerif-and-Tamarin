# Secrecy

Secrecy means that, from the perspective of the announcer, the target data will not be known to the adversary. The announcer depends on the entity responsible for ensuring the secrecy of the data. The announcer can be any one of the Remote UE, Relay, AMF/PKMF, HN.

# Weak Agreement (WA)

means that, from the perspective of the announcer, the peer has participated in the session apparently with the announcer, but there is no guarantee that the secret data of both parties is consistent. The announcer and peer depend on which two entities are targeted for authentication. The announcer can be any one of the Remote UE, Relay, AMF/PKMF, HN, and peer can be any one of the remaining entities.

# Non-injective Agreement (NI)

means that, from the perspective of the announcer, it ensures that the secret data of both parties is same on the basis of weak agreement. The announcer is the same as the one in WA.

# Injective Agreement (I)

means that, it ensures that both parties have different keys for different sessions on the basis of non-injective agreement.

# indistinguishability (IND)

Covers untraceability and unlinkability, which means that an active attacker cannot distinguish the target UE from two UEs given two UEs and one old session.
