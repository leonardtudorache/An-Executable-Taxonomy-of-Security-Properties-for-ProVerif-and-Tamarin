# Eligibility and Uniqueness:

The former requires that only authorized voters are allowed to submit ballots, and unauthorized voters are not allowed to vote. The latter requires each voter to cast a ballot only once. In the actual deployment of our PIWS protocol, the privacy-preserving intersection of the two parties’ identity identifier sets is essentially a process of screening the eligibility of voters. The identity server maintains all identity identifiers and weights of voters, and it can provide a set of legitimate voters and their weight information. Only the ballots of legitimate voters will be selected by the intersection and included in the tallying phase. Conversely, ballots from illegal voters or duplicate votes are automatically ignored at intersections. The privacy-preserving automatic intersection completes the screening of legitimate voters, which makes it possible to call for a wider range of voters to participate in voting activities when the actual vote is initiated. The ballots that are actually included, weighed, and counted in the tallying phase can be flexibly set through the weight server. In this way, privacy and ballot secrecy can be guaranteed by hiding them among the massive voters and ballots.

# Privacy:

This requires that all ballots should be kept secret from any authority, and voters’ ballot scores or preferences should never be revealed. In Chapter 5, we provide security proof that the protocol is indistinguishable from the security privacy-preserving simulator with perfect ballot secrecy. It can be seen that our PIWS protocol only discloses the voting scores and the optional number of legal voters, and no one can know any information about the identity, privacy, or ballot information of voters.

# Fairness and Integrity:

The former requires that the entire voting process cannot appear adaptive or abortive voting, and the order in which any voter casts his ballot cannot affect the voting results. The latter requires that no one be able to tamper with the ciphertext of the ballot without being detected. These two properties are guaranteed by the security of the encryption algorithm. The premise of adaptive or abortive voting is that voters have the ability to know the intermediate results of voting before casting the vote, and there are two very close scores. Thus, the last voter casts a ballot that is decisive for the final result. However, in our PIWS, no voter can know any information about the intermediate voting stage until the final score is decrypted and announced, and therefore, no voter can purposely cast an adaptive or abortive vote.

# Anonymity:

After each ballot is submitted, it must be impossible to associate the ballot with its voter. In other words, no one can trace the connections between marked ballots and voters. This is also guaranteed by the random oracle and encryption of identity identifiers and ballots.

# Correctness and End-to-End Voter Verifiability:

This requires that each voter has a reliable method to verify whether the corresponding submitted ballot is weighted and counted in an expected way and that the final score of the tallying is correct. This attribute can be ensured based on the audit services provided by the cloud service. Through a public audit or third-party audit, it can be ensured that the processing of valid ballots by the cloud service provider is completed and executed in accordance with the provisions of the protocol. That is, the eligibility ballots are correctly, completely, and uniquely counted in the tallying process and are not decrypted, tampered with, lost, or damaged in the intermediate process.
