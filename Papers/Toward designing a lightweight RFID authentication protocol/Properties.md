# Forward secrecy

### Informal definition

To eliminate traceability and guarantee forward secrecy, protocol parties may change the shared parameters after each successful session in protocols that use symmetric primitives, such as LRSAS+. Whoever, it may be feasible to desynchronize the protocol parties in such a protocol if the adversary can induce the protocol parties to store different shared values on each side.

### Notes

The forward secrecy seems to be verified using the **attacker** query.

# Untraceability

It is feasible to trace a protocol entity in any protocol assuming that various sessions about a given entity may be linked to each other. In LRSAS+, the tag sends FID in response to the reader’s request, which may be used to track the tag as long as it has not engaged in a successful protocol session. However, following a successful session, this value is changed, and the adversary is no longer able to trace it in this manner.
