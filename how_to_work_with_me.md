#### Why this doc
* Trade-offs often have multiple right answers, and we need a consistent and objective framework to break ties, so that everyone is empowered to break ties locally without contradicting each other.
* Align expectations on me and from me on everything related to work

#### How to use this document
* Feed this doc into LLM
* Describe your problem, and ask LLM for opinions based on this doc's framework.
* If LLM is confident and you agree, then very likely you can follow the LLM's call
* If you disagree or LLM is not very confident, let us have a 15 mins call to break ties

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
 

#### On project estimates and deadlines

My Observation: An estimate is a probability distribution, not a commitment. Pressure to provide a single number often forces engineers to either omit buffers (leading to missed deadlines) or add excessive buffers (leading to sandbagging).

So, instead of saying: "Just give me the date," or "This will take 6 weeks."

I will try to ask: 
* What is your 50% confidence estimate (50/50 chance of being early or late)? 
* And what is your 90% confidence estimate (the date you feel very certain you can hit)? The gap between those two numbers tells us where the real project risk is.
* Show us the DAG of execution orders, with each node takes no more than 1 week. This will help us identify the critical path and track if the project is on track


# How I Make Decisions

### My Decision-Making Framework (in order of priority)
[Highest Priority Criterion]

[Second Priority Criterion]

[Third Priority Criterion]

...

### What I Need to See in a Proposal
The Problem:

The Proposal:

Trade-offs Considered:

The Ask:

### My Role in a Technical Debate
Describe your role: are you a facilitator, a tie-breaker, an information-gatherer?


# Communication Preferences
### Preferred Channels (by situation)
* For Urgent Issues (e.g., Production Outage): page me right away regardless of time  
* For General Questions & Asynchronous Discussion: use a project or a team's Slack channel. Try not to use DM for discussion
* For Decisions That Need a Record:
    * Set up a 15 mins meeting with AI notes enabled.
    * Document the decision in the RFD/ERD/Wiki, and tag the LCA of DRIs in the org chart
* For Complex or Sensitive Topics:
    * DM me with the topic, and we will 1:1 case by case
* For pings and reminders:
    * DM me, and I should give you an ETA

### My Communication Style & What to Expect
Describe your style (e.g., direct, concise) and how it should be interpreted.

### Response Times
* Messages/mails to be ACKed within 2 hours if sent between 8:30 AM and 7:30 PM. Ping me against if no ACK in 2 hours

# Work Style & Collaboration

### My Rhythm & Availability
* In general I am in office every day
* I am online and reachable during this window: 8:30 AM - 7:30 PM. 
* I am actively working and expect others to be as well: 10:30 AM - 12 PM, 1PM to 6 PM, 
* Deep Work / Focus Time: I don't have pre-scheduled focus blocks. Please interrupt me when you are blocked.  For non-urgent/blocking matters, a Slack message is best, and I will follow the ACK ETA discussed above 
* Best Time to Schedule Meetings: Whenever you see a slot on my calendar. 

### My Meeting Philosophy
* Keep the meeting < 30 mins, and <= 5 attendees. I will reject 90% of meetings bigger than this.
* If you think the meeting really need more than 30 mins, share the ERD/RFD/doc first, and let's resolve 80% of threads async before sending out the meeting invitation
* Meeting invitations must include the exactly what decisions to make or what questions to answer 
* Meetings are for making decisions, not for open-ended discussions or status updates. I will close the meeting early if we feel we need to do more homework because we can resolve next batch of threads


### How I Approach Code Reviews (PRs)
* Scope:
* Description:
* My Review Turnaround:
* My Comments:
What it covers: Your daily rhythm, how you approach tasks, and how you work with others (e.g., code reviews, feedback, mentorship).


### My Approach to Mentorship & Pairing
Describe how you prefer to help colleagues who are stuck or want to learn.

### Giving and Receiving Feedback
Explain how you prefer to give and receive feedback (e.g., in public/private, specific models like SBI).

# My Technology Philosophy

### My Definition of Technical Debt
To me, technical debt is any decision that makes future development slower or riskier. This isn't always "bad code"; it can be a "good" architecture that is simply wrong for our current scale and needs.

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


### Guiding Principles
(e.g., Boring is Better, Leverage Managed Services, Testing is Non-Negotiable)

### My Stance on Testing
(e.g., Testing pyramid, expected coverage, types of tests you value most)

### My Current Preferred Stack (for new projects)
Backend:

Frontend:

Database:

Infrastructure:

CI/CD:


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