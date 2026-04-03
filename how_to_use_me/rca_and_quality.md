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
