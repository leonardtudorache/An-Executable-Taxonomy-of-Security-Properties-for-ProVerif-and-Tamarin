# Data integrity (+MITM)

Our proposed protocol performs a series of steps to protect from Man-in-the-Middle attacks and realize data integrity. We create a hash value for a string using the SHA-256 hash algorithm to encode the random number and shared key, which is presented as Mx=Hash (Ni||Ki). The vehicle hashes the data and compares it with the received value to achieve data integrity. Therefore any change to a message while in transit will lead to the failure of the comparison check on the ECU side, thereby leading to a failed authentication.

# Replay Attack

Generally, a replay attack implies that the attacker intercepts and sends a packet that the destination host has received to deceive the system. In our proposed protocol, the shared key is distributed from the third party to the vehicle and smartphone sides. Even though the shared key is brute-force compromised by the attacker, the random number is varied by Ni = PRNG(Ni) in every authentication period. Therefore, the replayed message will likely fail to authenticate.
