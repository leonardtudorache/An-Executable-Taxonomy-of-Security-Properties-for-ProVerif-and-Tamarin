correctness, unforgeability, ticket privacy, no-double-spending and anonymity

They provide proofs of these security properties

# Unforgeability

The unforgeability of a ticket prevents an adversary A from creating a new valid ticket. This property is described in ExpUF A . It requires A to produce a ticket such that (1) the ticket has not been produced by the system i.e., tk ∉ TK, denoted as bit b0 in the experiment and (2) make it accept either for a refund, a transfer, or a validation, this is denoted as bit b1 in the experiment. This property must be ensured for any PPT adversary, with read-only access to the shared state and the oracles of Fig. 4a corresponding to possible actions of the users.

# Ticket Privacy

The ticket privacy prevents from an adversary A, external to the system, stealing a ticket from a designated user. The adversary has the capability to generate, manipulate through oracles of Fig. 4a, and corrupt any user within the system. The ticket privacy is focused against entities that are external to the system. In the associated experiment, ExpPRIV A , user U1 is the adversary’s target. U1 purchases a ticket tk and A wins if (1) the purchase went through, (2) A outputted a ticket tk∗ such that tk∗ = tk and (3) A did not corrupt U1. During this process, the adversary has readonly access to the shared state at any point during the experiment. The challenger simulates the user purchasing the ticket targeted for recovery by the adversary, but also D, T , and V, otherwise making the ticket privacy trivially broken as the system requires the ticket for verification purposes.

# No-double-spending

Once purchased, a ticket should be usable only once: the ticket can be refund once, transferred once or validated once. In other words, as done in our security model, none of Refund, Validate or Transfer executed by the challenger against a corrupted user would accept the same ticket twice. This notion differs from what has been formalised in e-cash [3]. Taking as example the protocol introduced by Baldimtsi et al. [3], their model allows execution of a function Spend twice for the same coin and postpone the double spending verification to a second algorithm call Deposit. Applied to ticketing, since the verification occurs after the ticket spent, the consequence for users is the possibility to buy already spent ticket, leading to a ticket rejection (during the second execution of Deposit of the same ticket). Following our notion, an honest client should not acquire a already transferred ticket.

# Anonymity

To model the properties of non-nominative physical tickets, an ETS should preserve the anonymity of a ticket holder U against the system. This is modelled by using two properties, one ensuring the pseudonymity of U and, as a complementary, we ensure unlinkability of the tickets purchased by a single user. This respectively guarantees that a ticket could not be linked by the system as coming from the same holder nor be linked to a user.

# Correctness

Under honest execution of the algorithms, a ticket tk bought by a user U through Purchase, or Transfer, can be either refund or validated, i.e., Validate and Refund output a success bit b which equals 1.
