# Authentication Properties

For the authentication property, Lowe categorizes it into four classes: aliveness, weak agreement, non-injective agreement, and injective agreement, which require progressively higher degrees of authentication. During our analysis, we consider the injective agreement, determining that there are uniquely correctly paired UE and home networks communicating with each other during protocol operation and preventing replay attacks.

# Confidentiality Properties

Confidentiality refers to ensuring that information is only accessed or read by authorized entities and is invisible or incomprehensible to unauthorized entities. Confidentiality is crucial in terms of protecting personal privacy, and it is only by ensuring that information remains confidential that sensitive information can be prevented from being leaked or maliciously abusing by illegals. The SUPI belongs to the private information and its confidentiality needs to be safeguarded. After the handshake key is negotiated between the UE and the home network, all subsequent messages need to be encrypted and protected by this key

# Privacy Properties

With respect to privacy, we focus on the unlinkability of the UE. Unlinkability requires the protocol to ensure that the user’s identity cannot be associated with a specific identifier, context, etc., and that an attacker cannot determine whether it is the same user from any two services. The protocol takes many measures to ensure the unlinkability of the UE, such as using SUCI in the transport instead of SUPI, certificate information associated with the user’s identity is also encrypted with a handshake key, and the UE should not reuse a ticket across multiple connections. Despite all these measures to ensure the unlinkability, during our formal analysis and validation, we found some vulnerabilities that prevented the protocol from achieving this security goal.
