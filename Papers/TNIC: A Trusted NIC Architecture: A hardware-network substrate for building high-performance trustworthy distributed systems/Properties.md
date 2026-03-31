## Security Properties

**Remote attestation.** We define the main attestation lemma for any tnic device tnic and associated IP Vendor ipv. The lemma holds if, after the last step of the remote attestation protocol, the tnic device is in a valid, expected state:

∀ ipv,tnic,c,ti . Dipv (c) @ ti ⟹ ∃ tj . tj < ti ∧ Dtnic (c) @ tj     (1)

**Transferable authentication.** We define the lemma, which states that any accepted message was sent by an authentic tnic device in a valid configuration:

∀ e1,m,ti . Ae1 (m) @ ti ⟹ ∃ e2,tj . tj < ti ∧ Se2 (m) @ tj     (2)

**Non-equivocation.** We further extend the model by three lemmas that help to reason about non-equivocation. For any message that is accepted, it holds that:

(i) there is no message that was sent before but not accepted:

∀ e1,e2,mj,ti,tj . Ae1 (mj) @ ti ∧ Se2 (mj) @ tj
⟹ (∀mk,tk . tk < tj ∧ Se2 (mk) @ tk 
⟹ ∃ tl . tl < ti ∧ Ae1 (mk) @ tl)     (3)

(ii) there is no message that was sent after, but accepted before:

∀ e1,mi,mj,ti,tj . ti < tj ∧ Ae1 (mi) @ ti ∧ Ae1 (mj) @ tj
⟹ ∃ e2,tk,tl . tk < tl ∧ Se2 (mk) @ tk ∧ Se2 (ml) @ tl     (4)

(iii) this message has not been accepted before:

∀ e1,m,ti,tj . Ae1 (m) @ ti ∧ Ae1 (m) @ tj ⟹ ti = tj     (5)

Our complete verification includes additional action facts and lemmas to verify properties like the secrecy of private information and the implications of out-of-band key compromises. To sum up, Tamarin successfully shows that there is no sequence of transitions that leads to any state where our lemmas are violated. Thus, the attestation and transferable authentication lemmas hold for our model, and the counters behave as expected for non-equivocation.