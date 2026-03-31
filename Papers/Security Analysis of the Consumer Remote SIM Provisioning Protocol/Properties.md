Contains formal definitions for security properties

# Mutual authentication

“The Server (the entity providing the function, e.g. SM-DP+) SHALL be authenticated first by the Client. Authentication SHALL include the verification of a valid Server Certificate signed by a GSMA CI.” “The Client SHALL be authenticated by the Server in a second step. In case the Client is the eUICC, authentication SHALL include the verification of a valid eUICC and EUM Certificate signed by a GSMA CI.” “The eUICC, as a Client, SHALL not generate any signed material before having authenticated the Server.” “On the basis of authentication, the Server SHALL always check that the requesting Client is authorized before delivering the requested function execution.”

# Profile binding

Server authorization is not explicitly stated as a goal in the RSP specification but it is implied by the concept of profile binding. After the mutual entity authentication, the server proves to the eUICC that it is authorized to deliver a profile by signing the session identifier It with its GSMA-issued profile binding certificate CertSp . We formalize the binding as the correspondence Auth C, which links the subject identity Sp in the profile binding certificate to the previously authenticated server identity Sa. The formal goal says that, if the eUICC accepts the two certificates together, Sp must be an authorized server, and the server must have intended the two certificates to be used together in this session. The injective correspondence indicates the freshness of the binding

# Authenticated Key Exchange and Profile Download (integrity, confidentiality)

“The communication SHALL be origin authenticated, as well as integrity and confidentiality protected.”
