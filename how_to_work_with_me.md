### Why this doc
* Trade-offs often have multiple right answers, and we need a consistent and objective framework to break ties, so that everyone is empowered to break ties locally without contradicting each other.
* Align expectations on me and from me on everything related to work
* This doc focuses on "how" of work by being prescriptive and objective with leading and lagging indicator, and tries to avoid descriptive and subjective terms like "principles"  

#### How to use this document
* Feed this doc into LLM
* Describe your problem, and ask LLM for opinions based on this doc's framework.
* If LLM is confident and you agree, then very likely you can go ahead with your judgement. For example, for small, local decisions, you can go ahead without approval. 
    * If a situation involves complex team history or sensitive interpersonal dynamics, the LLM's advice might be logically sound but contextually incomplete. In those cases, a human conversation is always the better path.
    * For hard to reverse changes, let's still have a quick call. See "Easily reversible changes" section for more details
* If you disagree with the output, LLM is not very confident, let us have a 15 mins call to break ties

# My Approach to Work & Decisions
This section describes my philosophy through specific situations rather than abstract principles.

#### On navigating speed vs. scalability trade-offs
My Observation: A team often over-engineers for a hypothetical future scale, while a team under pressure often ignores obvious future needs. The right balance depends entirely on our current business goals.

So, instead of saying: "We must build this to be scalable," or "Let's just get an MVP out the door."

I will try to ask: "What is the specific risk of choosing the faster option? Can we live with that risk for the next 6 months? Conversely, what is the specific cost of choosing the more scalable option? Does that cost delay a critical feature for our users right now?"

#### On technical debt and shortcuts

My Observation: Technical debt is a tool, not an evil. Sometimes taking on 'debt' is the right business decision to achieve a goal. The danger is not the debt itself, but when it's taken on unconsciously, with no understanding of its "interest rate" and no plan to "repay" it.

So, instead of saying: "This is too hacky," or "Let's be pragmatic and just do the fast thing."

I will try to ask: "If we choose this shortcut, what is the exact 'repayment' plan? Let's create a ticket right now with a specific, measurable trigger for when we must address this (e.g., 'once this endpoint exceeds 100 requests per second,' or 'before the end of Q4'). Are we all committing to prioritizing that ticket when the trigger hits?"

#### On introducing new technology

My Observation: The enthusiasm for a new tool (e.g., a new database, a new framework) often focuses on its benefits while minimizing the very real, long-term costs of operational ownership. This is a primary source of "Premature Scaling" debt.

So, instead of saying: "Let's stick with what we know," or "This new tool is obviously better."

I will try to ask: 
* Beyond the initial implementation, who will be on-call for this? How will we monitor it? 
* What is our 'off-ramp' strategy if we need to migrate away from this in two years? Or what is the backup option
* What are some non-critical/offline systems we can POC first? Ideally we should deploy this on 2 non-critical/offline systems before we roll out the deployment
* "What is the specific, measurable advantage of this new approach that justifies the cost of fragmentation? Is it a 10x improvement in performance or developer velocity, or is it a marginal gain?"
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
* And what is your 90% confidence estimate (the date you feel very certain you can hit)? The gap between those two numbers tells us where the real project risk is.
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
* The decision is made by the LCA of reporting chains of stakeholders
* However, we are open to pivot to a different option if the committed one is not working. That is why we compare and update project's impact and progress with metrics defined above at least once every 3 months. We will also define early-exit criteria or red flags that would trigger a re-evaluation before the 3-month milestone.

#### On Code Ownership and Cross-Team Contributions

Which team is owning what should be defined in the RFD/ERD, and reviewed by each team's engineering manager.

Every eng is welcomed to contribute to another team's code base, on condition that,
* The "giving team" eng's EM is aware of this cross-team contribution and ok with it
* The receiving team has reviewed and approved design proposals with the "giving" team.
* The receiving team owns its roadmap and operational load. To make a contribution likely to be accepted, I recommend the 'giving team' first aligns with the receiving team's priorities. The best cross-team features are those that solve a problem the receiving team already has on its roadmap or that significantly reduce their future maintenance burden.

I expect senior engineers to understand how the immediate upstream and downstream systems work, that is, knowing the high level design/compoments of the system's dependnecy and users, one level below the interface


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

#### On Data-Driven Results vs. Product Intuition
My Observation: sometimes quantitative data from an A/B test or analytics report points to a decision that conflicts with our core product principles or feels like a poor user experience. This often happens when the metric we're tracking is a proxy for, but not a perfect representation of, the actual user value we want to create.

So, instead of saying: "The data is clear, we have to ship this version," or "I don't care what the A/B test says, this is a bad experience and we're not doing it."

I will try to ask:
* "How confident are we that the metric we measured is the right long-term proxy for user value? For example, is it possible we're optimizing a local maximum (like short-term engagement) at the expense of a global goal (like user trust or satisfaction)?"
* "Let's articulate the specific product principle or user experience heuristic that this change seems to violate. Can we define the negative outcome we're predicting? Is that negative outcome something our current experiment is even capable of measuring?"
* "Can we design a new, better experiment to resolve this conflict? For example, could we ship the change to 1% of users for a longer period and supplement it with a qualitative survey to measure satisfaction, in addition to the quantitative metric?"


#### Knowledge vs skill

Skill is much more valuable and harder to gain than knowledge. Therefore, I encourage knowledge sharing, but I would say knowledge sharing is at most 10% of a performance review. At the same time, mentoring on a specific skill with continous feedback loop is much more valulable and appreciated, and can go to 30% of a performance review. 

# How I Make Decisions

### My Decision-Making Framework (in order of priority)

* User Impact & Business Value: Does this directly and measurably improve the experience for our users or move a key business metric?
* Data and Evidence: What data supports this path? If we have no data, what is the fastest, cheapest experiment we can run to get a signal?
* Cost & Resource Constraints: Does this fit within our budget, timeline, and available engineering resources? Can our team build, test, and operate this effectively with their current skills? Does it introduce a high operational burden or a steep learning curve? 

### PRD/RFD/ERD
Rushing into coding with an unclear problem statement is the most common and expensive cause of wasted engineering effort. 

I will make sure stakeholders are 80% confident with items below before kicking off the tech solution.

* The specific user problem we are solving. Ideally product should start with a reverse launch statement to help stakeholders visualize the impact
* Assumptions on the state of the world/users. Align with the probability of each assumption, i.e., prior probability in Bayesian theorem. 
* Competitor studies/prior lessons
* The non-goals (what we are explicitly not solving right now) 
* The single, most important metric that will tell us if we are successful. 

These answers are hard and require multiple iterations, but the dividend pays off immediately

### My Role in a Technical Debate

As a Facilitator: My first priority is to ensure all viewpoints are heard, especially from more junior engineers, and to keep the conversation focused on technical merits. This means I will interrupt the discussion if a point is dragging on for more than 5 mins, and I will ask stakeholders to research offline and come back later for a second round of discussion

As an Information-Gatherer: I will ask clarifying questions to expose the core trade-offs and assumptions behind each position. In fact, my main focus will be assumptions because engs made wrong decisions not because the tech call is wrong, but because engs have incorrect/incomplete assumptions

As a Tie-Breaker (Last Resort): If the team is deadlocked, I will make the final call based explicitly on the Decision-Making Framework above.

### Bayesian inference

I will keep asking the assumptions behind a statement, and I will keep pressing on the prior probability of the statement, and marginal likelihood of each assumptions, because my observation is that wrong conclusion often comes from the lack of prior probability and marginal likelihood.

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
My goal as a mentor is to help you become a better problem-solver, not just to give you the answer.

When you're stuck: Please don't hesitate to reach out. Before you do, please be ready to articulate: 1) The problem you are trying to solve, 2) The approaches you have already tried, and 3) Why you think they didn't work.

Our pairing sessions: you should be able to give an answer better than mine after our session, because you have more context on your problem. I will ask a lot of clarifying questions, and maintain that in our 1:1 doc  

Beyond the code: Feel free to set up 15-30 mins 1:1 session with me on career development, navigating the organization, and improving communication skills. The agenda should be filled with hard/senstive, and specific questions. I prefer our 1:1 to be in person, and ideally I'd like to have a walk with you to talk through things

### Giving and Receiving Feedback


#### Receiving Feedback
I genuinely want your feedback on everything, even if it is not tech related, for example, "you use the desk I prefer too much". Please DM me and we can have a quick call. Specific examples are the most helpful (e.g., "In the design review yesterday, when you said X, it had Y impact on the team."). 

#### Giving Feedback
I follow the "radical candor" model, i.e., my feedbacks will be immediate, direct, and empathetic. For me, empathy means I will always deliver constructive feedback privately, focus on the work and behavior rather than the person, and be committed to helping you act on it. I totally expect people to be uncomfortable with negative feedbacks and let's do a mini-RCA together - it is possible I misinterpreted facts.


# My Technology Philosophy

### My Definition of Technical Debt
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
Such projects are best suited for engs looking for promotions

### New tech projects
Such projects should be offline/controlled access, and is intended to be the POC sandbox of new techs. 
Such projects are best suited for engs interested in new tech, and is not good fit for promotion packet

### SFT our own LLM model

At this moment I prefer we use SFT only as the last resort, because
* We experienced catastrophic forgetting with SFT model in the past
* Once a new model is out every 6 months, we have to re-do the SFT 
* Industry study shows that >70% of LLM quality issue can be mitigated by lower lift options, such as RAG or contextrual engineering

At this moment, I feel the priority is to add the company's evals for LLMs

### Build our own infra stack

I am neutral on this, because custom infra stack is a hard to reverse decision with very severe tradeoffs. See "Introduce new technology" and "build vs buy" section for more disucssion


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