# The formal definition of unlinkability.

Recall that the core of the unlinkability scheme is the equivalence between the idealised and the real-world system. We define both in Fig. 6. Notice that in the system UTXimpl defining the real-world scenario the card with the private key c can participate in any number of sessions, while in the system UTXspec defining the idealised situation, the card can only participate in one session at most. The possibility of entering the PIN arbitrarily many times is given by the process !user⟨PIN⟩, and accessing the database in arbitrarily many bank-terminal sessions given by the process !⟨si, PAN⟩⟨⟨PIN, mk, φ (c, g)⟩⟩, remains the same for both real and idealised worlds. We are ready now to give the unlinkability definition. Definition 1. (unlinkability) We say that the payments are unlinkable if UTXimpl ∼ UTXspec, where ∼ is quasi-open bisimilarity. There is a difference with the definition of unlinkability for key establishment considered in [26], where the terminal and the bank are deliberately omitted. The reason is that the key establishment in isolation, i.e. the UTX protocol up to the Cardholder verification phase, requires no shared secret between the parties, yet to execute, for instance, a full high-value transaction, at least the PIN is required to be shared between all three parties involved in the protocol. In addition, to validate a transaction there is a secret mk shared between the bank and the card, meaning that, even if only transactions without the PIN are modelled, the bank and card must be explicitly modelled in a transaction.

# Unlinkability in the face of coarse identities.

Below we justify the observation made in Section 2.2.3 where we pointed out that unlinkability can only be achieved up to the fingerprint comprising the coarse identities of the card being revealed.

# Authentication

## This paper contains formal definitions of the security properties.
