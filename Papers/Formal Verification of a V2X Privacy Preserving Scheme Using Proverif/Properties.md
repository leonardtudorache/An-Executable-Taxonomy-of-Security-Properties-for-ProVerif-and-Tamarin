## Confidentiality

Confidentiality: attackers should not able to obtain the secrets of the participants of the protocol, even by actively interacting with them. In our case, the secret to protect is the vehicle’s real identity, vid. Confidentiality can be modeled in Proverif as a Reachability property.  
`query attacker (vid).`

## Strong secrecy

Strong secrecy: attackers, unable to discover the secret, could not even distinguish if it changes. This is useful to capture the attacker’s ability to learn partial information about the secret [8]. In our case, we want to verify the Strong secrecy of the vehicle id. With the formula below, we test whether it is possible to replace the vid with different values (e.g., vidx, vidy), without the adversary being able to distinguish the two cases. This property in Proverif is modeled as Observational Equivalence, denoted by the keyword noninterf.  
`P{vidx/vid} ≈ P{vidy/vid}`  
`noninterf vid.`

## Anonymity

Anonymity: a vehicle should be able to participate in the protocol without revealing its identity. In case the identity, for some reason, is known to the attacker, there is anonymity if the vehicle does not reveal that it is using the service. We verified the anonymity of the vehicle when it uses the group secret key and the pseudo secret key to sign respectively pseudo certificates and messages. The formula below tests whether a process P is equivalent to a version of itself in which gsk is replaced by a dummy value. The same could be verified for the v pseudosk. This property can be modeled in Proverif as Observational Equivalence using the choice construct (equivalent to noninterf but to be used with bound names or variables).  
`!(gsk; P) ≈ !(gsk; P)|P{dummygsk/gsk}`  
`VehicleSignPseudoCert (choice[vgsk, dummygsk])`  
`VehicleSignMessage(choice[v pseudosk, dummysk])`

## Unlinkability

Unlinkability: a vehicle should be able to participate in the protocol multiple times, without an attacker being able to link them. In our case, until a vehicle changes its pseudonym, all messages signed using the same pseudonymous certificate are linkable to each other. Unlinkability is to be searched in the use of a single group key to sign multiple pseudonymous certificates. The formula below checks whether protocol P, in which the vehicle signs several pseudonymous certificates with the same group secret key, is equivalent to a version of itself in which the number of signatures made is limited to one. In Proverif, unlinkability can be modeled as Observational Equivalence between processes, using the equivalence construct.  
`!(P; !sign(gmsk)) ≈ !(P; sign(gmsk))`  
`equivalence`  
`!(gmsk; VehicleSignPseudoCert (gmsk))`  
`!(gmsk; !VehicleSignPseudoCert (gmsk))`
