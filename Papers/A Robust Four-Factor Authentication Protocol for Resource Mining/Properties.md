# Forward Secrecy

### Informal definition

Perfect forward secrecy means that forming the current session key is impossible even if an adversary obtains the current session’s long-term secrets.

The forward secrecy assures the strength of a session-key despite the situation where any of the long-term keys Kij or Lkj is exposed to attacker A. Our protocol provides perfect forward secrecy as the session key SKik is constructed in such a way that these long term keys just aid in establishing the key, not computing it. So, despite the fact that the long term keys are leaked, A cannot compute the current session key SKik = bi .Sβk + Dk .U αi = dk .U βi + Bi .Sαk , as discussed in point ’j’. Hence, our protocol provides robust perfect forward secrecy.

### Notes

The forward secrecy seems to be verified using the **attacker** query.

# Anonymity

### Informal definition

We say that a protocol satisfies the anonymity when the identity of a system’s user (user, sensor, gateway) cannot be determined from public communications, contents of the smart card/device, or information kept in the memories of other system’s users.

# Untraceability

For tracing any user of the system, attacker A should be able to differentiate the source of the messages in different sessions. A cannot identify the source of a message in our protocol as the parameters being sent over a public channel are in the hash digest format that were constructed with the current timestamps and random numbers. Since these parameters change in each active session, the source of a message remains indistinguishable. Thus, the proposed protocol ensures the un-traceability.
