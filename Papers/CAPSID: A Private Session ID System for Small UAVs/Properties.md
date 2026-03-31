# Off-line verifiable

All flight information broadcasts are signed, allowing any receiver to verify that the broadcast originated from a UAV registered with the licensing authority (FAA in the United States). Authentication does not require an Internet connection nor two-way communication with the UAV.

# Traceable

Every verified broadcast can be traced to an operator. Unsealing an operator’s identity requires cooperation between the FAA and the Custodian; neither can unseal an identity unilaterally. Moreover, CAPSID protects against impersonation, even by a corrupt Custodian.

# Long-term unlinkable

A UAV uses a consistent identifier during a flight, providing short-term linkability that allows a receiver to monitor the UAV’s path. However, a UAV’s long-term identifiers change daily, preventing anyone from linking Remote ID broadcasts from one day to another, ensuring anonymity for operators. This non-linkability property holds even if the licensing authority or Custodian is corrupt.
