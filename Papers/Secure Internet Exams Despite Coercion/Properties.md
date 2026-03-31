## Security Properties Definitions

First, we check whether Anonymous Submission holds in our protocol: specifically, that even if two honest candidates swap their answers in two different runs of the protocol then the attacker cannot distinguish the two resulting systems.

**Definition 3 (Anonymous Submission).** An exam protocol ensures Anonymous Submission if any exam process EP, any two candidates id₁ and id₂, and any two answers a₁ and a₂:

EP{id₁,id₂}[C^σ_{id₁}^a₁ | C^σ_{id₂}^a₂]|marked ≈ₗ EP{id₁,id₂}[C^σ_{id₁}^a₂ | C^σ_{id₂}^a₁]|marked

The difference between Anonymous Submission and Anonymous Marking is that the latter considers two honest candidates who swap their secret keys in two different runs. While both properties aim at hiding the link between candidate's key and answer, the definition of Anonymous Submission crucially enables a definition of coercion-resistance. To model this, we additionally let the candidates publish their answers and their secret keys on the public channel, and verify that Anonymous Submission still holds:

EP{id₁,id₂}[C^σ_{id₁}^a₁ | C^σ_{id₂}^a₂]|marked ≈ₗ EP{id₁,id₂}[C′ | C^σ_{id₂}^a₁]|marked

where C′ is a process such that C′\out(chc,·) ≈ₗ C^σ\_{id₁}^a₂, i.e. C′ is the process that acts like one submitting answer a₂, but pretends to cooperate with the attacker by revealing their secrets through channel chc.

Then, we check whether Single-Blindness holds in our protocol. We check that if two honest examiners swap their marks in two different runs of the protocol, then the attacker cannot distinguish the two resulting systems.

**Definition 4 (Single-Blindness).** An exam protocol ensures Single-Blindness if for any exam process EP, any two examiners id₁ and id₂, any two marks m₁ and m₂:

EP{id₁,id₂}[E^σ_{id₁}^m₁ | E^σ_{id₂}^m₂] ≈ₗ EP{id₁,id₂}[E^σ_{id₁}^m₂ | E^σ_{id₂}^m₁]

As for Anonymous Submission, we also check that Single-Blindness holds under examiner coercion. We let the examiners publish their marks and secret keys on the public channel:

EP{id₁,id₂}[E^σ_{id₁}^m₁ | E^σ_{id₂}^m₂] ≈ₗ EP{id₁,id₂}[E′ | E^σ_{id₂}^m₁]

where E′ is a process such that E′\out(chc,·) ≈ₗ E^σ\_{id₁}^m₂.

The difference between Single-Blindness and Anonymous Examiner is that the latter considers two honest examiners who swap their keys in two different runs. While both properties aim at hiding the link between key and mark, the definition of Single-Blindness enables the definition of coercion-resistance.
