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

Team needs to be aware that LLM hallucinates a lot when advising on internal tools and processes, even with the help of RAG.

Any build proposal need to include competitor analysis on how other teams handle similar scenarios. We can do things differently from most other teams, but we need to be aware that we are doing things differently and have clear reason and value proposition

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

Senior engineers should understand how the immediate upstream and downstream systems work, that is, knowing the high level design/components of the system's dependency and customers, one level below the interface.
Every eng is welcomed to contribute to another team's code base, on condition that,
* The "giving team" eng's EM is aware of this cross-team contribution and ok with it
* The receiving team has reviewed and approved design proposals with the "giving" team.
* The receiving team owns its roadmap and operational load. To make a contribution likely to be accepted, I recommend the 'giving team' first aligns with the receiving team's priorities. The best cross-team features are those that solve a problem the receiving team already has on its roadmap or that significantly reduce their future maintenance burden.

#### On Prioritizing Bugs vs. Features
Bugs and features should share the same priority score so that the team can prioritize.
Any risk of data loss, security, privacy, or compliance is P0 immediately

A eng should be able to claim fixing P0 and P1 bugs as impact on the highlight reel. In general, we expect no more 60% of efforts in a year are on bugs. For example, if an eng has spent 50% of time on bugs, then the eng should pick a P1 feature next instead of another bug. Note that we can frame bug fixing as backfill missing features.

If we find a team is consistently spending more than 60% of its time on reactive bug-fixing, I see it as a signal that we need to investigate the root cause—be it excessive technical debt, gaps in our testing, or architectural issues. It's a trigger for a broader strategic conversation, not a performance cap on an individual.

#### On Documentation: How Much is Enough?
The user of the system should be main driver in updating said docs, similar to Feyman's technique of learning, and the system's owner team should review user's updates with high priority.
The system's user can claim updating said docs as "impact" in the high light reels with backing data. However, this should take less than 20% of the user's time. If more that 20%, then it is a miss on the system owner's side
LLM-generated documentation can be added to code/wiki, only after every single line has been reviewed manually, because
* LLM often hallucinates when documenting internal systems
* LLM documentation is good at what the system/code is doing, but need human verification on why the system/code is behaving this way, if certain behavior is intended, or what invariants must the code/system hold.

#### On Responding to a Failing Project or Underperforming Feature

My Observation: When a project is failing to meet its goals, the natural human tendency is to either find someone to blame or to fall into the "sunk cost fallacy" and continue investing in a failing strategy. A senior engineer's role is to calmly treat the failure as a new data point and guide the team toward a rational, blameless decision.

So, instead of saying: "This isn't working, we need to cancel it," or "We just need to push harder."

I will try to ask:
* "Let's separate the strategy from the execution. Is the feature underperforming because of technical issues, or was our initial hypothesis about the user's need incorrect?"
* "What is the cheapest possible experiment we can run in the next two weeks to test if a pivot could salvage this? For example, can we change the user interface, target a different audience, or simplify the core functionality?"
* "If we were a brand new team given this same project today, knowing what we know now, would we still choose to build it? If the answer is 'no,' our default decision should be to decommission it, and document our learnings in a post-mortem."

Note that decommissioning a failing project should be rare, because the huge gap between projection and reality means big gaps in the original assumptions/goals/non-goals discussion, or we didn't built things in easily reversible blocks.

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

My preference is for each team to own a separate solution. However, the common building blocks will be abstracted and owned by both teams - one primary DRI, and one backup DRI, one from each team. When there is a 3rd customer team, we will review the architecture and ownership again - very likely we need a small pod just to own both common building blocks and the success of customer teams by then

When I detect potential duplicate work between teams, I will kick off this general vs specific discussion with teams' stakeholders.

#### On Data-Driven Results vs. Product Intuition
My Observation: sometimes quantitative data from an A/B test or analytics report points to a decision that conflicts with our core product principles or feels like a poor user experience. This often happens when the metric we're tracking is a proxy for, but not a perfect representation of, the actual user value we want to create.

So, instead of saying: "The data is clear, we have to ship this version," or "I don't care what the A/B test says, this is a bad experience and we're not doing it."

I will try to ask:
* "How confident are we that the metric we measured is the right long-term proxy for user value? For example, is it possible we're optimizing a local maximum (like short-term engagement) at the expense of a global goal (like user trust or satisfaction)?"
* "Let's articulate the specific product principle or user experience heuristic that this change seems to violate. Can we define the negative outcome we're predicting? Is that negative outcome something our current experiment is even capable of measuring?"
* "Can we design a new, better experiment to resolve this conflict? For example, could we ship the change to 1% of users for a longer period and supplement it with a qualitative survey to measure satisfaction, in addition to the quantitative metric?"

#### Knowledge vs skill

Skill is much more valuable and harder to gain than knowledge. Therefore, I encourage knowledge sharing, but I would say knowledge sharing is at most 10% of a performance review. At the same time, mentoring on a specific skill with continuous feedback loop is much more valuable and appreciated, and can go to 30% of a performance review.

#### On Interpreting Ambiguous Experiment Results
My Observation: A/B tests don't always produce a clear, statistically significant winner. Results are often flat, statistically weak, or show a messy trade-off (e.g., conversion rate improves, but long-term engagement declines). Teams can get paralyzed in this situation, either by dogmatically refusing to ship anything without 95% significance or by arguing endlessly over how to interpret the murky data.

So, instead of saying: "The result isn't statistically significant, so we have to kill the feature," or "It looks like it's trending positive, let's just ship it."

I will try to ask:
* "Let's assume the result is truly flat. What is the non-metric, strategic value of shipping this change? Does it align with our long-term product vision or simplify our tech stack? What is the cost of the added complexity if we do ship it?"
* "Let's ignore the primary metric for a moment. Did the change cause any meaningful movement—positive or negative—in our key secondary or guardrail metrics? Did it disproportionately help or hurt a specific user segment (e.g., new vs. power users)?"
* "What is the opportunity cost of continuing this experiment? If we spend another two weeks trying to get a clearer signal, what other feature are we not building or testing? Is a 'good enough' decision now more valuable than a 'perfect' decision a month from now?"
