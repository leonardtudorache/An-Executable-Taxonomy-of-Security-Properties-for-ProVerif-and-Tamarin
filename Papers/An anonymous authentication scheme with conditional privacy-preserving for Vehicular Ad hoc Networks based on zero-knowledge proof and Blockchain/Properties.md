# Integrity

The vehicle should be able to detect any tampering in messages during broadcasting or sending. ⋅ Entity Authentication: The vehicle should be able to check received message and verify the sender’s legitimacy.

# Non-repudiation

The sender should not deny or dispute the authorship of the message they sent. Strictly speaking, non-repudiation makes it possible to conduct a forensic investigation regarding the message’s origin to identify the attacker, which helps track communication exchange in case of a crime or accident.

# Traceability

This requirement is necessary for VANETs to trace the malicious activity of vehicles. The LEA is the only entity authorized to know the vehicle’s identity and prevent a malicious vehicle from participating in the VANET whenever necessary.

# Privacy preservation

Privacy preservation includes two sub-requirements: anonymity and unlinkability. Anonymity means RSUs, vehicles, and other participants should not be able to retrieve the real identity of the vehicles during communication (i.e., sending and receiving message). In other words, the real identity of the vehicles should not be easily traceable or accessible by unauthorized parties within the network. Unlinkability means RSUs and other participants should not be able to link multiple messages sent from a single vehicle.
