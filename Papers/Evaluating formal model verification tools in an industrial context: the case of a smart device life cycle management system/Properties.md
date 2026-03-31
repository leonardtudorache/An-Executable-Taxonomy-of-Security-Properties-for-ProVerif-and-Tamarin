# Confidentiality

In the case of confidentiality properties, the user must declare the namespace of the data that must remain secret. The data are declared private and the keyword not attacker(dataname) must be used to clearly specify that the attacker must not know the data. Finally, the keywords query attacker(dataname) indicate to ProVerif that we want to check that the attacker is not able to recover the data (here data-name).

# Authentication

In this case, the events needed to express the property are defined first. Those events are called in the process at key moments of the protocol. For instance, the event ManSendBCCertif is sent just before Manufacturer sends the newOwnershipProof into the blockchain. In a similar way, AliceRecBRProof is emitted after Alice receives the newOwnershipProof from the blockchain. Each event contains types as parameters. This allows to take into account part of the context during which the event occurs. To define an authentication property, a query must be written in the form: “query event(eventName1(paramsType)) ==> event(eventName2(paramsType))." with eventName 1 and 2, two specific events. This line of code can be interpreted as: “If event eventName1 occurs then event eventName2 necessarily occurs before."
