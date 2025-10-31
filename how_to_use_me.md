### Why this doc
* Trade-offs often have multiple right answers, and we need a consistent and objective framework to break ties, so that everyone is empowered to break ties locally without contradicting each other.
* Align expectations on me and from me on everything related to work
* This doc focuses on "how" of work by being prescriptive and objective with leading and lagging indicator, and tries to avoid descriptive and subjective terms like "principles"  

#### How to use this document
* Feed this doc into LLM and Describe your problem
* Use the LLM as a way to organize your thoughts against my framework. Ask it: 'Based on this guide, what questions would George likely ask about my proposal?' This will help you prepare your answers. 
* If you've run through that exercise and your path seems clear and reversible, feel empowered to proceed. 
* If the LLM's output highlights multiple trade-offs you're unsure about, that's the perfect agenda for our 15-minute call.

# My Approach to Work & Decisions
This section describes my philosophy through specific situations rather than abstract principles.

#### On navigating speed vs. scalability trade-offs
My Observation: A team often over-engineers for a hypothetical future scale, while a team under pressure often ignores obvious future needs. The right balance depends entirely on our current business goals.

So, instead of saying: "We must build this to be scalable," or "Let's just get an MVP out the door."

I will try to ask: "What is the specific risk of choosing the faster option? Can we live with that risk for the next 6 months? Conversely, what is the specific cost of choosing the more scalable option? Does that cost delay a critical feature for our users right now?"

#### On technical debt and shortcuts

My Observation: Technical debt is a tool, not an evil. Sometimes taking on 'debt' is the right business decision to achieve a goal. The danger is not the debt itself, but when it's taken on unconsciously, with no understanding of its "interest rate" and no plan to "repay" it.

So, instead of saying: "This is too hacky," or "Let's be pragmatic and just do the fast thing."

I will try to ask: "If we choose this shortcut, what is the exact 'repayment' plan? Let's create a ticket right now with a specific, measurable trigger for when we must address this (e.g., 'once this endpoint exceeds 100 requests per second,' or 'before the end of Q4', 'once this module requires non-trivial changes by three different engineers'). Are we all committing to prioritizing that ticket when the trigger hits?"

#### On introducing new technology

My Observation: The enthusiasm for a new tool (e.g., a new database, a new framework) often focuses on its benefits while minimizing the very real, long-term costs of operational ownership. This is a primary source of "Premature Scaling" debt.

So, instead of saying: "Let's stick with what we know," or "This new tool is obviously better."

I will try to ask: 
* Beyond the initial implementation, who will be on-call for this? How will we monitor it? 
* What is our 'off-ramp' strategy if we need to migrate away from this in two years? Or what is the backup option
* What are some non-critical/offline systems we can POC first? Ideally we should deploy this on 2 non-critical/offline systems before we roll out the deployment
* What is the specific, measurable advantage of this new approach that justifies the cost of fragmentation? Is it a 10x improvement in performance or developer velocity, or is it a marginal gain?. Does it unlock a new product capability that is impossible with our current stack, even if the initial version isn't 10x faster?
* "Could we define this as a formal 'paved road' vs. 'dirt path' option? The 'paved road' is our standard, fully-supported stack. If you choose a 'dirt path' (a new technology), the proposing engineer is explicitly signing up to own its documentation, training, and initial operational support."

#### On build vs buy

The lower the stack, the more likely we need to buy. 

Team needs to be aware of that LLM halluciates a lot when advicing on internal tools and processs, even with the help of RAG.

Any build proposal need to include competitor analysis on how other teams handle similar scenarios. We can do things differently from most other teams, but we need to be aware that we are doing things differently and have clear reason and value propersition

#### On project estimates and deadlines

My Observation: An estimate is a probability distribution, not a commitment. Pressure to provide a single number often forces engineers to either omit buffers (leading to missed deadlines) or add excessive buffers (leading to sandbagging).

So, instead of saying: "Just give me the date," or "This will take 6 weeks."

I will try to ask: 
* What is your 50% confidence estimate (50/50 chance of being early or late)? 
* And what is your 90% confidence estimate (the date you feel very certain you can hit)? The gap between those two numbers tells us where the real project risk is. Maybe some POC can reduce the gap between the two?
* Show us the DAG of execution orders, with each node takes no more than 1 week. This will help us identify the critical path and track if the project is on track
* The POC effort should also be included in the effort estimation. I expect POC effort takes around 20% of the project timeline to expose unknown unknowns

#### On Refactoring vs. Building New Features
My Observation: Refactoring should be framed as unblocking a business pain, and project estimate should include refactoring effort as dependency. Another reason I don't refactor for the sake of refactoring is that what is considered bad/ugly is often subjective, and not able to be validated until it receives user feedback.

So, instead of saying: "We need to stop everything and refactor this component," or "We don't have time for refactoring, we have deadlines."

I will try to ask: "How many developer-hours were spent debugging it last quarter? What specific, user-facing feature on our roadmap is currently blocked or slowed down by its complexity? Let's frame this refactoring as an enabler for that future work."

#### On Handling Strong Technical Disagreements

We follow "disagree and commit" model. 
* Each option should have a milestone with proxy metrics to achieve in the frame of 3 months
* Once a decision is made, everyone expects to commit to its success. If an eng feels so strongly against the decided decision. Then I will talk to the engineering manager to find a solution that aligns with their convictions and career goals, which might include finding a better-suited project. Such eng may return to this project later when the direction changes or the eng's expertise is needed
* The decision is made by the LCA of reporting chains of stakeholders, or the LCA's delegate
* However, we are open to pivot to a different option if the committed one is not working. That is why we compare and update project's impact and progress with metrics defined above at least once every 3 months. We will also define early-exit criteria or red flags that would trigger a re-evaluation before the 3-month milestone.

#### How to define DRIs 

DRIs should be defined in the RFD/ERD, and reviewed by each team's engineering manager. I will try to align the project with 60% to 70% of the engs's interests. If the eng has strong opinion against the project, I will talk to the eng manager for alternatives.
Each item should have a primary DRI and backup DRI, and teams should check with the DRIs for answers first before escalation. Primary DRI and backup DRI should and have the power to resolve 80% conflicts themselves.
When DRIs change, old DRIs could still be consulted for opinions, but their opinion should not be blocking. Please escalate if old RIDs and new don't align


#### Working on another team's project

Senior engineers should understand how the immediate upstream and downstream systems work, that is, knowing the high level design/compoments of the system's dependnecy and customers, one level below the interface.
Every eng is welcomed to contribute to another team's code base, on condition that,
* The "giving team" eng's EM is aware of this cross-team contribution and ok with it
* The receiving team has reviewed and approved design proposals with the "giving" team.
* The receiving team owns its roadmap and operational load. To make a contribution likely to be accepted, I recommend the 'giving team' first aligns with the receiving team's priorities. The best cross-team features are those that solve a problem the receiving team already has on its roadmap or that significantly reduce their future maintenance burden.


#### On Prioritizing Bugs vs. Features
Bugs and features should share the same priority score so that the team can prioritize. 
Any risk of data loss, security, privacy, or complaince is P0 immediately

A eng should be able to claim fixing P0 and P1 bugs as impact on the highlight reel. In general, we expect no more 60% of efforts in a year are on bugs. For example, if an eng has spent 50% of time on bugs, then the eng should pick a P1 feature next instead of another bug. Note that we can frame bug fixing as backfill missing features.

If we find a team is consistently spending more than 60% of its time on reactive bug-fixing, I see it as a signal that we need to investigate the root cause—be it excessive technical debt, gaps in our testing, or architectural issues. It's a trigger for a broader strategic conversation, not a performance cap on an individual.


#### On Documentation: How Much is Enough?
The user of the system should be main driver in updating said docs, similar to Feyman's technique of learning, and the system's owner team should review user's updates with high priority. 
The system's user can claim updating said docs as "impact" in the high light reels with backing data. However, this should take less than 20% of the user's time. If more that 20%, then it is a miss on the system owner's side
LLM-generated documentation can be added to code/wiki, only after every single line has been reviewed manually, because 
* LLM often halluciates when documenting internal systems
* LLM documentation is good at what the system/code is doing, but need huamn verifcation on why the system/code is behaving this way, if certain behavior is intended, or what invariants must the code/system hold.

#### On Responding to a Failing Project or Underperforming Feature

My Observation: When a project is failing to meet its goals, the natural human tendency is to either find someone to blame or to fall into the "sunk cost fallacy" and continue investing in a failing strategy. A senior engineer's role is to calmly treat the failure as a new data point and guide the team toward a rational, blameless decision.

So, instead of saying: "This isn't working, we need to cancel it," or "We just need to push harder."

I will try to ask:
* "Let's separate the strategy from the execution. Is the feature underperforming because of technical issues, or was our initial hypothesis about the user's need incorrect?"
* "What is the cheapest possible experiment we can run in the next two weeks to test if a pivot could salvage this? For example, can we change the user interface, target a different audience, or simplify the core functionality?"
* "If we were a brand new team given this same project today, knowing what we know now, would we still choose to build it? If the answer is 'no,' our default decision should be to decommission it, and document our learnings in a post-mortem."

Note that decomissioning a failing project should be rare, because the huge gap between projection and reality means big gaps in the original assumptions/goals/non-goals discussion, or we didn't built things in easily reversible blocks.

#### On Evaluating Performance on a Failed Project
My Observation: When a project is decommissioned, its direct business impact is, by definition, low. This is a real factor in performance reviews. However, punishing the team for an intelligent risk that didn't pay off creates a risk-averse culture that kills innovation. The challenge is to be honest about the low impact while fairly evaluating the team's work.

So, instead of saying: "Don't worry, this won't affect your performance at all," or "Since the project had zero impact, the team's performance was poor."

I will state the following:
* "Let's be direct: because this project was decommissioned, its business impact was not what we hoped for, and we can't ignore that in our performance model. There are no late surprises here."
* "However, impact is not solely defined by feature success. I will heavily weight my evaluation on the value of reusable building blocks for other projects, such as user stories, test cases, automation scripts, infra setup.
* "Therefore, I will ask: Did we build a high-quality, reliable system based on what we knew? How quickly and cheaply did we run the experiment to invalidate our hypothesis? How insightful and actionable is our post-mortem? Proving an idea is wrong quickly is a valuable contribution, and I will ensure the skill and speed the team demonstrated in delivering that learning is what gets recognized."

#### On reversible changes and blast radius

My criteria for easily reversible changes is
* The change will not cause a SEV 2 and above
* It takes less than 1 business week to undo the changes

My criteria for small blast radius is that no a SEV 2 and above. For example, the problem affects only internal users.

For easily reversible changes or changes with small blast radius, feel free to go ahead with your proposal without approval. Otherwise, please review the proposal with your team first.

#### On Incremental Improvement vs. a "Big Bang" Rewrite
My Observation: Teams often get trapped between two undesirable states. They either suffer from a "death by a thousand cuts" by endlessly patching a legacy system with deep architectural flaws, or they are lured by the promise of a "perfect" greenfield rewrite, which famously underestimates complexity and risk, often leading to multi-year projects that fail to deliver.

So, instead of saying: "We have to rewrite this from scratch; it's unmaintainable," or "A full rewrite is too risky; we must continue to refactor it piece by piece."

I will try to ask:
* "Which specific business goals on our 12-month roadmap are currently blocked or slowed by its limitations?"
* "Instead of a 'big bang,' can we frame this as a 'strangler fig' migration?  What is the smallest, independent piece of functionality we can carve out, rewrite, and route live traffic to within the next three months to validate the new architecture? We can easily route traffic back if things don't work out."
* "If we stick to the incremental path, how do we ensure we're fixing the architectural flaws, not just the surface-level bugs? What's our plan to prevent being in the exact same, but worse, position in two years?"

#### On Generalizing a Solution vs. Keeping it Specific
My Observation: A team builds a simple, effective solution for a specific problem. Soon, another team requests a "slightly different" version. The immediate temptation is to rebuild the original solution as a generic, configurable platform to serve everyone. This often leads to over-engineering, as the "generic" solution is built on the assumptions of only two use cases and becomes complex and difficult to maintain.

My preference is for each team to own a separate solution. However, the common building blocks will be abstracted and owned by both teams - one primary DRI, and one backup DRI, one from each team. When there is a 3rd customer team, we will review the architecture and ownership again - very likely we need a small pod just to own both common buildig blocks and the sucesss of customer teams by then

When I detect potential duplicate work between teams, I will kick off this general vs specifc discussion with teams' stakeholders.

#### On Data-Driven Results vs. Product Intuition
My Observation: sometimes quantitative data from an A/B test or analytics report points to a decision that conflicts with our core product principles or feels like a poor user experience. This often happens when the metric we're tracking is a proxy for, but not a perfect representation of, the actual user value we want to create.

So, instead of saying: "The data is clear, we have to ship this version," or "I don't care what the A/B test says, this is a bad experience and we're not doing it."

I will try to ask:
* "How confident are we that the metric we measured is the right long-term proxy for user value? For example, is it possible we're optimizing a local maximum (like short-term engagement) at the expense of a global goal (like user trust or satisfaction)?"
* "Let's articulate the specific product principle or user experience heuristic that this change seems to violate. Can we define the negative outcome we're predicting? Is that negative outcome something our current experiment is even capable of measuring?"
* "Can we design a new, better experiment to resolve this conflict? For example, could we ship the change to 1% of users for a longer period and supplement it with a qualitative survey to measure satisfaction, in addition to the quantitative metric?"

#### Knowledge vs skill

Skill is much more valuable and harder to gain than knowledge. Therefore, I encourage knowledge sharing, but I would say knowledge sharing is at most 10% of a performance review. At the same time, mentoring on a specific skill with continous feedback loop is much more valulable and appreciated, and can go to 30% of a performance review. 


#### On Interpreting Ambiguous Experiment Results
My Observation: A/B tests don't always produce a clear, statistically significant winner. Results are often flat, statistically weak, or show a messy trade-off (e.g., conversion rate improves, but long-term engagement declines). Teams can get paralyzed in this situation, either by dogmatically refusing to ship anything without 95% significance or by arguing endlessly over how to interpret the murky data.

So, instead of saying: "The result isn't statistically significant, so we have to kill the feature," or "It looks like it's trending positive, let's just ship it."

I will try to ask:
* "Let's assume the result is truly flat. What is the non-metric, strategic value of shipping this change? Does it align with our long-term product vision or simplify our tech stack? What is the cost of the added complexity if we do ship it?"
* "Let's ignore the primary metric for a moment. Did the change cause any meaningful movement—positive or negative—in our key secondary or guardrail metrics? Did it disproportionately help or hurt a specific user segment (e.g., new vs. power users)?"
* "What is the opportunity cost of continuing this experiment? If we spend another two weeks trying to get a clearer signal, what other feature are we not building or testing? Is a 'good enough' decision now more valuable than a 'perfect' decision a month from now?"

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
If the team is deadlocked, I will make the final call based explicitly on the Decision-Making Framework above. After I make a tie-breaking decision, my immediate next step is to connect with the proponents of the other path. My goal is to acknowledge the value of their arguments, ensure they feel heard, and explicitly check that they are on board to commit to the chosen direction. I will also make sure the chosen path acknowledges the merits of the other path, and commited to pivot if the chosen path does not work out


### Bayesian inference

I will keep asking the assumptions behind a statement, and I will keep pressing on the prior probability of the statement, and marginal likelihood of each assumptions, because my observation is that wrong conclusion often comes from the lack of prior probability and marginal likelihood.
I will also use Bayeisan theorem to answer the question: how much guardrail is enough? Since the error state should be rare, we should look for a signal (or a combination of signals happening at the same time), that is rare to happen
When advocating for a concensus, I follow a Bayesian equilibrium model. That is, I will have probability on each stakeholder's positions, and pick a strategy that is good enough and yet aligns more with team's interests over a best strategy (imo) but not align with teams' motivation, and I may pivot my position as I update my belief on each stakeholder's position.

### Simpson's Paradox

When I see a claim on before vs after impact, I will push for before vs after data on different subgroups, and see if the trend is consistent across the groups. If there are outliers, we need to watch out for confounding variables that affects in both grouping (indepedent variables) and the outcome (dependent variables). Such check is obvious in hindsight but my observation is that many claims don't follow it.

### Leading and lagging indicators

When look at numbers, I will be very explicit if we are watching a leading or a lagging indicator, because my observation is that engs tend to focus on leading indicators during execution, and such focus is likely to replace means (leading indicators) with goals (lagging indicators)

# Communication Preferences
### Preferred Channels (by situation)
* For Urgent Issues (e.g., Production Outage): page me right away regardless of time  
* For General Questions & Asynchronous Discussion: use a project or a team's Slack channel. Try not to use DM for discussion
* For Non-Urgent, Blocking Issues: DM me with the link to the thread and I will reply in the team/project channel with higher priority than general questions.
* For Decisions That Need a Record:
    * Set up a 15 mins meeting with AI notes enabled.
    * Document the decision in the RFD/ERD/Wiki, and tag the LCA of DRIs in the org chart
* For Complex or Sensitive Topics:
    * DM me with the topic, and we will 1:1 case by case
* For pings and reminders:
    * DM me, and I should give you an ETA

### My Communication Style & What to Expect

* I try to use positive framing and avoid negaitve whenever possible. For example, I will say, "add more guardrails to limit the blast radius" rather than "missing guardrails will greatly increase the blast radius". This is a style I wish more people will follow.
* I try to explain the reason behind my decision. For example, "let's add a feature flag, because this change needs to be easily reversible". This is a style I wish more people will follow.
* When talking to people, I will interrupt the monologue from time to time to rephrase what you said, to make sure we are on the same page.
* I try to maintain eye contact with people. Let me know if you prefer a different style.
* I use "I think", "I assume", "I feel" a lot, because I try hard to distinguish my preception of facts and facts itself, and I hope others pay attenion to the difference fact and preception too.
* Conversely, I try not to use "You" statement because it often sounds more accusational than intended. In fact, LLMs will rewrite most of the "you" statements
* I prefer being prescriptive and to go from bottom-up (fact to theory), rather than top-down (principle to action), because 1. the top-down approach often sounds more preachy than intended. 2. The same abstract principle means differently to different person (similar to why we need this doc to begin with)
* Upon hearing a "no" from another team, I want to work with the other team to understand why my request does not align with the team's charter/goal/roadmap. This often signals oppurtunity in new projects, or an expanded scope of existing projects
* When I see major gaps, such as missed timeline, wrong assumptions that could derail the whole design, I will call out the issues/risks, ask the meeting to move onto the next topic, and I will follow up with the gap's stakeholders right after the meeting to RCA and come up with a recovery plan, and inform stakeholders in Slack on the next action items
* When I ask questions, I often lead with a 'first guess'. You'll hear me say something like, "What is the benefit of this approach? My guess is it's because..." Please know that my guess is often incomplete or inaccurate, and that's intentional. I do this because:
 * It's a forcing function for me to think through the problem.
 * It makes the tone more collaborative.
 * It's much easier for you to correct my wrong guess than to answer a cold, open-ended question.
Please feel free to say "No, that's not quite right..." and give me the real answer. Don't treat my guess as the 'right' answer I want to hear.
* I will iterate on my pitches. You will see me propose many ideas and initiatives. I fully expect most of my initial pitches won't be right, and that's a key part of the process. I see a "rejection" as valuable feedback that we're not yet aligned. My next pitch will simply be an iteration, built on the concerns and insights from the last one, until we have collectively found and aligned on the right strategic opportunity.


### Response Times
* Messages/mails to be ACKed within 2 hours if sent between 8:30 AM and 7:30 PM. Ping me against if no ACK in 2 hours

# Work Style & Collaboration

### My Rhythm & Availability
* In general I am in office every day
* I am online and reachable during this window: 8:30 AM - 7:30 PM. This is the window where I am generally available, but it is not an expectation for anyone else to maintain these hours. Please do not feel obligated to respond to non-urgent messages outside of your own working hours.
* I am actively working and expect others to be as well: 10:30 AM - 12 PM, 1PM to 6 PM, 
* Deep Work / Focus Time: I don't have pre-scheduled focus blocks. Please interrupt me when you are blocked.  For non-urgent/blocking matters, a Slack message is best, and I will follow the ACK ETA discussed above 
* Best Time to Schedule Meetings: Whenever you see a slot on my calendar. 

### My Meeting Philosophy
* Keep the meeting < 30 mins, and <= 5 attendees. I will reject 90% of meetings bigger than this.
* If you think the meeting really need more than 30 mins, share the ERD/RFD/doc first, and let's resolve 80% of threads async before sending out the meeting invitation
* Meeting invitations must include the exactly what decisions to make or what questions to answer 
* Meetings are for making decisions, not for open-ended discussions or status updates. I will close the meeting early if we feel we need to do more homework because we can resolve next batch of threads. For the similar reason, I will interrupt and move onto the next topic if a dialogue is diverging or not progressing after 2 mins, and I will that that dialogue to the "open questions" sections of the meeting notes


### How I Approach Code Reviews (PRs)

#### Scope
PRs should be small and focused on a single logical change. A PR changing more than ~200 lines will likely get a comment asking to break it up.

PR content should have more than 80% test coverage. Feel free to create separate PRs just to backfill tests

Often we need to refactor existing code to add new features. In such cases, I prefer a separate PR just for refactoring and without behavioral change first, and then a second PR for the feature.

Description: 
* The PR description should include a link to the Jira ticket
* a concise summary of the "why," 
* Tests performed, including screenshots/GIFs for any UI changes.


#### My Review Turnaround
I aim to review all PRs assigned to me within 4 business hours. For larger changes, I will leave a comment with an ETA for my full review.

#### My Comments
Comments prefixed with [nit], [question], [no need to change] are non-blocking. Other comments are blocking


### My Approach to Mentorship & Pairing
When you're stuck: Please don't hesitate to reach out. Before you do, please be ready to articulate: 1) The problem you are trying to solve, 2) The approaches you have already tried, and 3) Why you think they didn't work.

Our pairing sessions: you should be able to give an answer better than mine after our session, because you have more context on your problem. I will ask a lot of clarifying questions, and maintain that in our 1:1 doc  

Beyond the code: Feel free to set up 15-30 mins 1:1 session with me on career development, navigating the organization, and improving communication skills. The agenda should be filled with hard/senstive, and specific questions. I prefer our 1:1 to be in person, and ideally I'd like to walk with you in a park to talk through things

### Giving and Receiving Feedback


#### Receiving Feedback
I genuinely want your feedback on everything, even if it is not tech related, for example, "you use the desk I prefer too much". Please DM me and we can have a quick call. Specific examples are the most helpful (e.g., "In the design review yesterday, when you said X, it had Y impact on the team."). 

#### Giving Feedback
I follow the "radical candor" model, i.e., my feedbacks will be immediate, direct, and empathetic. For me, empathy means I will always deliver constructive feedback privately, focus on the work and behavior rather than the person, and be committed to helping you act on it. I totally expect people to be uncomfortable with negative feedbacks and let's do a mini-RCA together - it is possible I misinterpreted facts.
For immediate, in-the-moment feedback about a specific piece of work, code, or interaction, I will always come to you directly and privately first. 
For persistent pattern over time, I believe in a 'no surprises' policy for managers, as it ensures they always have the full context to support you. Therefore, I will briefly align with your manager before we discuss feedback. The conversation itself will always be a direct one between you and me, but this approach ensures we are all working together from the same set of information.

### Social 
I prioritize my time for deep, focused 1:1s on career and technical challenges, as I believe that's where I can provide the most value. This means I may attend fewer large social events. When I do join team gatherings, my goal is to connect with as many people as possible, so please don't be surprised if I move around frequently—I want to make sure I get a chance to chat with everyone.


# My Technology Philosophy

### Technical Debt projects
Technical debt is any decision that makes future development slower or riskier. This isn't always "bad code"; it can be a "good" architecture that is simply wrong for our current scale and needs.

#### Type 1: Implementation Debt (Shortcuts)

What it is: A conscious choice to implement a limited or less robust solution to meet a pressing deadline.

Example: Hardcoding a configuration value instead of building a UI to manage it.

When it's acceptable: Only when the cost of delay is proven to be higher than the cost of future rework. To be approved, any proposal for this type of debt must include a formal SLA for repayment. This SLA includes:

A documented estimate of the repayment effort (e.g., in story points or engineer-weeks).

A committed repayment date (e.g., "within 3 months" or "before the end of Q4").

This repayment plan must be formally acknowledged and agreed upon by the relevant Product Manager and Engineering Manager, ensuring it is prioritized alongside feature work.

#### Type 2 & 3: Architectural Debt (Premature Abstraction & Scaling)

What it is: These are high-cost, "one-way door" decisions that are very difficult to reverse. They include building overly generic systems (Type 2) or adopting complex infrastructure before it's needed (Type 3).

Example (Type 2): Creating a generic rule engine for a business rule that only has one if statement.

Example (Type 3): Using Kubernetes for a single service that could run on a simpler managed platform.

When it's acceptable: Only under the narrow and specific conditions outlined below. Because these decisions are so hard to undo, any proposal requires a rigorous approval process:

The full effort estimate and projected maintenance costs must be formally agreed upon by the key stakeholders (e.g., Director of Eng, Head of Product).

In the event of a significant estimation overrun (e.g., the final cost is >= 3x the initial estimate), a blameless RCA will be conducted, with the same level of rigor as a Sev-2 production incident, to understand the failure in our planning and estimation process.

#### Specific Conditions for Type 2 (Abstraction):

We have strong external evidence (industry studies, competitor analysis) showing similar problems in our domain inevitably require this abstraction.

OR there is a concrete, funded roadmap (next 2 quarters) with 3+ distinct teams already committed to adopting this system.

#### Specific Conditions for Type 3 (Scaling):

Driven by a non-negotiable business need like a contractual client SLA, a high-stakes marketing launch, or strict regulatory compliance (HIPAA, FedRAMP).


### Business impact driven projects
Such projects are normally on the user's critical path
This type of projects will follow "Boring is better". In general, A new tool/stack needs to be in action for other projects before it can be used here
Such projects are best suited for engs looking for promotions, and often involves around 5 engs

### New tech projects
Such projects should be offline/controlled access, and is intended to be the POC sandbox of new techs. 
Such projects are best suited for engs interested in new tech, and is not the best choice for promotion packet. Such project normally employs 1-2 engs
The ultimate goal for a successful 'new tech project' is to graduate into a 'business impact project.' The most compelling promotion packets often come from engineers who successfully shepherd a new technology from an offline POC to a core system that drives measurable user value.


### Build our own infra stack

I am neutral on this, because custom infra stack is a hard to reverse decision with very severe tradeoffs. However, most medium-large company will end up with its own custom infra stack. See "Introduce new technology" and "build vs buy" section for more disucssion.

### Open source our solutions

Not very likely we will open source a brand new solution, because it is either too specific to the company's context, or too general to have mutliple competitors already. However, I do expect the team to add features, fix bugs for existing open source projects, and become PMC of these projects


### Complexity relative to use cases

I prefer to keep the design as simple as possible, unless at PRD stage we explicit say we need a highly scalable systems to handle complex use cases (which should be very rare). I'd rather we introduce complexity and do traffic switches as we onboard more use cases/traffics, so that we can launch and verify PMF sooner

### My Stance on Testing

I follow "testing pyramid"
* > 80% unit test coverage
* Automated smoke tests on most common paths
* Monthly manual testing on edge cases

### My Preferred Stack for new projects
I am always open to proposals for new technologies. See "On introducing new technology" section for more details

* Backend: Go or Java
* Frontend: TypeScript whth React.
* Database: PostgreSQL or MySql
* Infrastructure: Terraform on EKS. 
    * Not everything has to be in Terraform though because TF changes have huge blast radius, so it is better to keep it only for hard to reverse changes.
* Data warehouse: Snowflake
* Workflow management: Temporal or airflow

#### Stack I want to avoid for new projects
* Ruby on rails: Not scalable for a team environment. 
  * Dynanmic typling: We had to introduce sorbet to add static type back
  * mixin without references: hard to navigate with IDE
  * High learning curve with RoR's keywords
* NoSQL DB: 90% of case SQL db is performant enough with k-v data modeling
* Clickhouse: very high maintenance overhead. Lacking in ecosystem and toolchains


# My Framework for RCAs and Bar Raising

#### My Philosophy on Incidents

My core belief is that we do not blame people; we blame the system. Every production incident is a treasure—a painful but invaluable opportunity to find a weakness in our systems (technical or procedural) before it can cause a more catastrophic failure. Our goal in a post-mortem is never to find who made a mistake, but to understand what weakness in our system allowed an inevitable human error to impact users.

#### Triggers for a Formal RCA
A formal, written Root Cause Analysis (RCA) is mandatory for any of the following events:

* Any SEV-2 and above production incident.
* Any security or data-privacy incident, which should be at least SEV-2
* Any incident involving data loss or corruption, which should be least SEV-2
* A significant project estimation overrun (e.g., final cost is >= 3x the initial estimate), as defined in our "Technical Debt" philosophy.

#### The RCA Process & Roles

* RCA Driver: A single engineer is designated as the driver for the RCA. This is often the on-call engineer who handled the incident, but their role is to facilitate the process, not to take blame.
* The RCA Document: The driver is responsible for producing a written RCA document within 3 business days of the incident's resolution. This document is blameless and focuses on facts.

#### Required RCA Document Structure

* Summary (TL;DR): What happened, what was the impact, and what are we doing to fix it? (3 sentences max).
* Impact: Quantified business and user impact (e.g., "15% of users were unable to log in for 32 minutes, resulting in 50 support tickets").
* Timeline of Events: A factual, timestamped log of events from detection to resolution.
* Root Cause Analysis: The most important section of the RCA doc. A "5 Whys" style analysis to move past the immediate cause (e.g., "a bad deploy") to the systemic root cause (e.g., "our CI/CD pipeline lacks automated checks for this class of configuration error"). 
5 Whys can go deeper than 5 layers, because big incidents are often the result of gaps in > 5 systems
* Corrective Actions (Action Items): A list of concrete, actionable tasks to fix the underlying issues.

### What Makes a Good Corrective Action (The "Bar-Raising" Part)
This is the most important output of an RCA. Every action item must have a designated owner and a target due date. We prioritize two types of actions:

* Short-Term (Containment): What do we need to do right now to prevent an immediate recurrence? (e.g., "Roll back the change," "Add a temporary validation rule"). Short term AIs should take < 2 weeks to implement, and have higher priority over all other works

* Long-Term (Systemic Improvement): What do we need to do to prevent this entire class of problem from ever happening again? This is the "bar-raising" work. (e.g., "Automate the configuration check in CI/CD," "Improve monitoring to detect this anomaly within 60 seconds," "Refactor the component to be idempotent").

My expectation is that at least 50% of our corrective actions from any major incident fall into the "Long-Term" category.

#### My Role in the Process

* I will ask questions on every SEV-2 and above RCA, and I expect >80% questions to be address before the RCA review.
* I will act as a facilitator in RCA meetings to ensure they remain blameless and focused on systemic issues.
* I will hold the team and leadership accountable for ensuring that "Long-Term" corrective actions are prioritized and completed, not just filed away.

# Working with LLMs

### SFT our own LLM model

At this moment I prefer we use SFT only as the last resort, because
* We experienced catastrophic forgetting with SFT model in the past
* Once a new model is out every 6 months, we have to re-do the SFT 
* Industry study shows that >70% of LLM quality issue can be mitigated by lower lift options, such as RAG or contextrual engineering

At this moment, I feel the priority is to add the company's evals for LLMs

### PMF for LLMs 
At this moment, LLM-powered products are best fitted for internal tools and workflows. In most cases, I feel a LLM powered workflow is good enough. An single agent system is likely ovekill, and a multi-agent system is almost always an overkill

### Code from LLM
Treat LLM as a genius intern. The engs are still accountable for the LLM generated code, and code should be reviewed as if producted by human, because LLM often gives bad code because of lack of internal context.
For production features, come up with an internal design doc for LLM. This internal design doc should include which components will be added/modified, and which internal libraries could be used in the place of external libraries. This internal design doc should be reviewed and commited first, and then fed into LLM to generate the actual code.

# How I build trust with you

The ultimate way is to deliver hard projects that aligns with your goals. To do this, I will

* Check my understanding of the data model and system architecture with the engineers. The santity check is that I should be able to product a diagram of data model with roles and goals of each component
* Go through the design docs of last half years and check my understanding of team's goals and roadmap with managers. The sanity check that I should be able maintain a roadmap which does not differ much from the team's goals
* Go through the user workflows that covers 80% of use cases, and compare my understanding with PMs
* Go through the RCAs of last half years and identify recurring patterns 
* Have quarterly 1:1 all engineers to gather bottom up initiatives. The sanity check is that I should be able to call out at least 100 engs by name
* Have monthly to bi-monthly 1:1 with sister teams managers to identify gaps and overlaps between teams