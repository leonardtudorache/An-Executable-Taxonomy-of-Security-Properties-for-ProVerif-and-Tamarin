# Forward Secrecy

FS is the guarantee that compromise of a session does not impact the security of previous sessions of the protocol. In other words, despite revealing the current session’s state (e.g. identity key and session key) to an attacker, previous message keys cannot be computed.

# Post-Compromise Security

PCS is the guarantee a party A has, that security of their conversation with partner B can be recovered (healed) after the compromise of the latter [13]. In other words, leaking the partner’s keys does not mean that all future communication can be decrypted. To restore security, the parties need a healing phase, during which the attacker does not interfere with the honest communication. Depending on the type of compromise, a protocol offers two levels of PCS a) via weak or partial compromise of ephemeral secrets (session keys) or b) via full compromise of the state (both long-term and session keys).
