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

I am neutral on this, because custom infra stack is a hard to reverse decision with very severe tradeoffs. However, most medium-large company will end up with its own custom infra stack. See "Introduce new technology" and "build vs buy" section for more discussion.

### Open source our solutions

Not very likely we will open source a brand new solution, because it is either too specific to the company's context, or too general to have multiple competitors already. However, I do expect the team to add features, fix bugs for existing open source projects, and become PMC of these projects

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
