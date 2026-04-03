# How I Make Decisions

### My Decision-Making Framework (in order of priority)

* User Impact & Business Value: Does this directly and measurably improve the experience for our users or move a key business metric?
* Data and Evidence: What data supports this path? If we have no data, what is the fastest, cheapest experiment we can run to get a signal?
* Cost & Resource Constraints: Does this fit within our budget, timeline, and available engineering resources? Can our team build, test, and operate this effectively with their current skills? Does it introduce a high operational burden or a steep learning curve?

### My role on a project

To align expectations, I will clarify my role with stakeholders at the start of every project. My engagement will fall into one of these three categories. Please ask, "George, what is your role on this?" if it's ever unclear.
* Consulting: I will leave comments on design docs and meeting notes, but I will skip most of the meetings. My goal is to provide context you may be missing. I will only block decisions that I believe will cause immediate, severe harm (e.g., a P0-level issue). I am not accountable for the project's success but am always ready to convert to a more involved role if needed.
* Sponsoring:
  * I am the second point of contact. I am accountable for the project's strategic success and for providing the "Owner" with the resources they need.
  * I will join key milestone meetings (e.g., kickoff, design review, launch review).
  * I will not be in the day-to-day standups, but I expect the Owner to keep me informed of risks or blockers.
  * My "block" is reserved for strategic misalignment (e.g., the decision contradicts our team's OKRs, a non-goal, or a cross-team commitment). For implementation-level decisions, I will voice my opinion, but I trust the "Owner" to make the final call, and we will follow the "disagree and commit" model.
* Owning: I am the DRI (Directly Responsible Individual) and the first point of contact for this project. I am fully accountable for its success from inception to delivery and operation.

### Working with product an design

My Observation: The best products are built by a "triad" (Product, Design, and Engineering) operating as true partners with shared ownership. The worst outcomes happen when these roles become a transactional "service" model (e.g., Product hands a PRD "order" to Eng, Eng "receives" designs from Design). My goal is to be involved before the PRD is finalized, to help shape the problem definition so we can build the right solution sustainably.

#### Common missing points in PRD

These are obvious in hindsight, but my observation is that they are often missing

* Ideally product should start with a reverse launch statement to help stakeholders visualize the impact
* Competitor studies/prior lessons on user experience and product behavior
* The non-goals (what we are explicitly not solving right now)
* The single, most important metric that will tell us if we are successful.

I will fill these sections if products has no bandwidth and review my changes with products to unblock tech discussion

#### On Responding to Solution-First Problem Documents
My Observation: Often, a PRD or request will jump directly to a solution (e.g., "We need a new service with these 3 endpoints," or "Build a dashboard with these 5 charts") without deeply validating the user problem. This is the single most common cause of wasted engineering effort.

So, instead of saying: "Okay, I'll build this," or "This PRD is incomplete, I'm blocking it."

I will try to ask: "Help me get to the 'why' behind this. What specific user behavior are we trying to change? What question is the user unable to answer today? Before we commit to this solution, let's confirm our assumptions about the problem. What is the absolute cheapest experiment we can run to prove our hypothesis about this user need?"

#### On Negotiating Technically Expensive Designs
My Observation: A designer will propose a fantastic, engaging user experience that, under the hood, requires a massive technical investment (e.g., a complex new data model, a technology we don't support, or a rewrite of a core component) for a feature that is still an unproven hypothesis.

So, instead of saying: "That's impossible," or "This design will take 6 months to build."

I will try to ask: "The architecture required to support this specific design is a significant one-way-door investment. Can we partner to find an 80/20 version so that we can validate core user hypothesis sooner, i.e., in weeks? What if we achieve the same core user goal with a simpler UI that lets us use our 'paved road' stack? We can commit to this richer design once we have data that it's the right bet."

#### On Handling Mid-Project Scope Changes
My Observation: A "small tweak" or "minor addition" is requested by Product or Design for a project that is already estimated and in progress. The request seems simple on the surface but has deep architectural implications (e.g., "just add this one extra filter," which breaks the query model or requires a new index).

So, instead of saying: "No, that's scope creep," or "Sure, we'll just add it" (and silently blowing the deadline).

I will try to ask: "That's a valid new requirement. Given our current architecture, that change isn't trivial; it impacts [component X and data store Y]. This represents a formal scope change. We have two options: 1) We can treat this as a V1 priority, re-estimate the project, and communicate a new timeline, or 2) We can park this requirement for a V1.1 fast-follow and deliver the original scope on time. Which path better serves the immediate business goal?"

### RFD/ERD
Rushing into coding with an unclear problem statement is the most common and expensive cause of wasted engineering effort.

I will make sure stakeholders are 80% confident with items below before kicking off the tech solution.

* Assumptions on the state of the world/users. Align with the probability of each assumption, i.e., prior probability in Bayesian theorem.
* Competitor studies/prior lessons for tech solutions
* Technical non-goals
* Leading indictors to measure execution quality and speed, and lagging indicators to measure impact

These answers are hard and require multiple iterations, but the dividend pays off immediately

Design docs are expected to update continuously until at 50% into the project, because that is the first thing sister teams refer to.

#### Design docs review
Design docs need to be approved by 2-3 leads before moving onto the next stage. The approvers are also accountable for the overall success of projects and are expected to follow up throughout the lifecycle. When a projects involves multiple stakeholders, the approvers should be the LCA of the stakeholders reporting lines, as such projects often have big blast radius.
>80% of open threads should be closed by the time the design doc is approved.
For people who are not accountable for the success of the project, their input is highly appreciated, but in most cases their input will not be considered impact.

### My Role in a Technical Debate

I value direct technical debate, but I understand that public disagreement can be uncomfortable. If you disagree with a direction, you do not have to wait for a large meeting. Sending me a direct message with your technical concerns, or scheduling a 15-minute 1:1 to walk me through your logic, is just as effective and welcome.

#### As a Facilitator
My first priority is to ensure all viewpoints are heard, especially from more junior engineers. We document the tradeoffs of each option and ready to switch to alternatives if needed.

I will keep the conversation focused on technical merits. This means I will interrupt the discussion if a point is dragging on for more than 5 mins, and I will ask stakeholders to research offline and come back later for a second round of discussion

I will focus on depersonalize and reframe messages in a calm, objective way, because my observation is that such debate often becomes heated and emotional, e.g.,

When people use a "you" statement: (e.g., "You didn't consider the security implications.")
* Reframe it internally: Their statement isn't a personal attack; it's a poorly-phrased technical concern. They are trying to say, "There is a security implication that has not been addressed."
* My verbal response: Ignore the "you" and address the substance directly. "That's a good point. Let's walk through the security model for this component."

When people use a rhetorical question: (e.g., "Isn't it obvious that we need to use caching here?")
* Reframe it internally: They are expressing a strong opinion and are not good at stating it plainly. They mean, "I believe strongly that we should use caching."
* My verbal response: Answer it as if it were a genuine, polite question. "Caching is definitely an option we should consider. I'm thinking about potential data consistency issues. What are your thoughts on that?"

When a difficult senior attacks a junior dev's idea, I will step in to interpret the message to create psychological safety. "I think that's an interesting point from Sarah. Let's explore it. Bob, I hear your concern is about [X]. Sarah, could you speak to how your proposal addresses [X]?"

When team is blocked by a reasoning such as ""We did it this way at a place you respect, so it must be right", I will clarify that "let's not appeal to authority, what are the cost of such decisions?"

#### As an Information-Gatherer
I will ask clarifying questions to expose the core trade-offs and assumptions behind each position. In fact, my main focus will be assumptions and its prior probabilities because my observation is most wrong decisions are from incorrect/incomplete assumptions.
For my own proposals, I always try to incorporate ideas and components from other options, even though I am fully confident my approach would work. I will always ask "What does your suggestion solve that I might be missing?". I wish more people would follow this style but I acknowledge this is hard

#### As a Tie-Breaker (Last Resort)
If the team is deadlocked, I will make the final call based explicitly on the Decision-Making Framework above. After I make a tie-breaking decision, my immediate next step is to connect with the proponents of the other path. My goal is to acknowledge the value of their arguments, ensure they feel heard, and explicitly check that they are on board to commit to the chosen direction. I will also make sure the chosen path acknowledges the merits of the other path, and committed to pivot if the chosen path does not work out

### Bayesian inference

I will keep asking the assumptions behind a statement, and I will keep pressing on the prior probability of the statement, and marginal likelihood of each assumptions, because my observation is that wrong conclusion often comes from the lack of prior probability and marginal likelihood.
I will also use Bayesian theorem to answer the question: how much guardrail is enough? Since the error state should be rare, we should look for a signal (or a combination of signals happening at the same time), that is rare to happen
When advocating for a consensus, I follow a Bayesian equilibrium model. That is, I will have probability on each stakeholder's positions, and pick a strategy that is good enough and yet aligns more with team's interests over a best strategy (imo) but not align with teams' motivation, and I may pivot my position as I update my belief on each stakeholder's position.

### Simpson's Paradox

When I see a claim on before vs after impact, I will push for before vs after data on different subgroups, and see if the trend is consistent across the groups. If there are outliers, we need to watch out for confounding variables that affects in both grouping (independent variables) and the outcome (dependent variables). Such check is obvious in hindsight but my observation is that many claims don't follow it.

### Leading and lagging indicators

When look at numbers, I will be very explicit if we are watching a leading or a lagging indicator, because my observation is that engs tend to focus on leading indicators during execution, and such focus is likely to replace means (leading indicators) with goals (lagging indicators)
