Writing an effective design document can be tricky in itself they often add unnecessary complexity if not done with care.

### Motivation section
* What is the overview of the problem?
* How does this link in with long-term requirements?
* Should be readable by non-developers

Could someone else follow the design and implement it? You may not be the one implementing this, and it’s even more likely that you will not be the only one maintaining it.

What use cases verify that this design work?

should be version controlled

I tend to look at the Design Document as providing more of a technical overview and the Plan as a second document which includes assumptions, justifications, and the like necessary for meeting the customer's requirements.

If you have a three-document model:

- Design - the picture that describes the end result (it often doesn't include product names, but might in some cases)

- Plan - a milestone-level view of how that design will get accomplished (no commands are included, but product names and the processes selected might very well be documented)

- Implementation - a step-by-step list of what to do which could be used to reproduce the work, possibly by someone who isn’t familiar with the design or plan.

Another way of thinking of it might be this:

- A design is the type of document a company might produce to be sent off for bidding (i.e., the customer might produce)

- A plan is individual -- the order and way you solve and verify your solution might be different from someone else, but

- If you just provide implementation steps without the plan, how will you know you did the job?

A design document is a complete high-level solution to the problem presented. It should be detailed enough that somebody who already understands the problem could go out and code the project without having to make any significant decisions. Further, if this somebody happens to be an experienced coder, they should be able to use the design document to code the solution in a few hours (not necessarily including debugging).

### From medium

I’ve seen first hand a strong correlation between good design docs and the ultimate success of the project.

* Overview

A high level summary that every engineer at the company should understand and use to decide if it’s useful for them to read the rest of the doc. It should be 3 paragraphs max.

* Context

A description of the problem at hand, why this project is necessary, what people need to know to assess this project, and how it fits into the technical strategy, product strategy, or the team’s quarterly goals.


* Goals and Non-Goals

describe the user-driven impact of your project — where your user might be another engineering team or even another technical system
specify how to measure success using metrics — bonus points if you can link to a dashboard that tracks those metrics

* Milestones, so your PM and your manager’s manager can skim it and know roughly when different parts of the project will be done

* Current Solution
In addition to describing the current implementation, you should also walk through a high level example flow to illustrate how users interact with this system and/or how data flow through it.

A user story is a great way to frame this. Keep in mind that your system might have different types of users with different use cases.

* Proposed Solution

Some people call this the Technical Architecture section. Again, try to walk through a user story to concretize this. Feel free to include many sub-sections and diagrams.

Provide a big picture first, then fill in lots of details. Aim for a world where you can write this, then take a vacation on some deserted island, and another engineer on the team can just read it and implement the solution as you described.

* Alternative Solutions

* Monitoring and Alerting

* Cross-Team Impact

* Discussion

* Detailed Scoping and Timeline

This section is mostly going to be read only by the engineers working on this project, their tech leads, and their managers. Hence this section is at the end of the doc.

Secondly, the design process doesn’t mean you staring at the whiteboard theorizing ideas. Feel free to get your hands dirty and prototype potential solutions

Then, after you’ve written a rough draft of your design doc, get the same reviewer to read through it again, and rubber stamp it by adding their name as the reviewer in the Title and People section of the design doc.

On that note, consider adding specialized reviewers (such as SREs and security engineers) for specific aspects of the design.

Whenever a discussion thread is more than 5 comments long, moving to an in-person discussion tends to be far more efficient. Keep in mind that you are still responsible for making the final call, even if everyone can’t come to a consensus.



### what actually goes in?

A high-level description of your solution, including design decisions and data structures
Declarations for all new classes, procedures, and global/class variables
Descriptions of all new procedures (unless you can tell exactly what it does from the name), including the purpose of the procedure, and an explanation of how it works and/or pseudocode

Your pseudocode has to be precise. For instance, in describing your solution for the Communicator class, it is not enough to say if anybody's waiting, then signal cv 
You need to say how you determine if anybody's waiting, e.g. by saying if (waitingReceivers>0 or waitingSenders>0) then signal cv

a design document needs to include the correctness invariants and testing strategy. The testing strategy includes a clear plan of the testing methodology and may include a description of test cases that will be used to test correctness invariants. Focus on the testing strategy. If you want, you may itemize things that will need testing.

Your design document should contain very little actual code, if any at all. Include psuedocode for all complex procedures, but do not include Java code.

### scoping

[source](https://medium.freecodecamp.org/how-to-effectively-scope-your-software-projects-from-planning-to-execution-e96cbcac54b9)

In fact, to scope a project accurately, you need to pay attention throughout the project

Minimize the batch size of the project by (1) setting up clear milestones and checkpoints for the project, and (2) making it easy to launch only part of the project. Not only does this help break down the project, but it will also allow the team to pause or cut the project early if another, higher priority task comes up.

De-risk the project as soon as possible. Two common ways of de-risking a project include (1) working on the riskiest parts upfront, and (2) prototyping the riskiest parts using dummy data and/or scaffolding. Whenever a new open-source system or external service is used, that usually represents a big risk.

Don’t optimize for total amount of work done. Instead, optimize for total amount of impact over time. Once you’ve gotten the riskiest part out of the way, prioritize working on the part of the project that would result in the highest amount of impact immediately.

Only the engineers writing the code should be the ones scoping the tasks. Not their managers, not the PM, or the key stakeholders in the company.

Resist the temptation to under-scope. Be honest about how long tasks will take, not how long you or someone else (such as your manager or the Go To Market team) wants them to take.

Divide the project into small tasks, each taking two days or less. When you have tasks that are scoped to “roughly 1 week,” they often end up taking longer because you didn’t enumerate all the subtasks that you might need to do.

Define measurable milestones to get to the project goal. Schedule each with a specific calendar date representing when you expect this milestone to be reached. Then, establish some sort of external accountability on these milestones by, for example, committing them to your manager and setting up milestone checkins.

Add buffer to account for: (1) Dev time != calendar time, due to meetings, interviews, and holidays. I usually multiply the dev time by 1.5 to get to the calendar time. (2) Unexpected project tasks time, since there are always tasks that you didn’t realize you need to do until much later, such as refactoring old code, debugging seemingly unexplainable behaviors, adding tests. The more experienced you are at scoping, the smaller this multiplier would get.

Consider timeboxing open-ended parts of the project. Instead of “find the best stream processing framework for this system,” which can take months of research and prototyping, timebox it to “find a suitable streaming processing framework in a week.” Use your judgement here to balance this against incurring long term operational overhead.

Re-scope regularly during the project execution. For each task, track how much time you estimated the task would take, then how long it actually took you to complete it. Do this for every measurable milestone. If your scoping is off by 50% for the first parts of the project, odds are your scoping will also be off by 50% for the rest of the project.

Use milestones to answer “how’s the project going?” As engineers, it’s tempting to answer “it’ll be done by next week” or “until end of this month.” But these types of vague answers tend to create projects that are always 2 weeks away from being finished. Instead, use the (re-scoped) milestones to give a concrete answer based on how much work is left.

If the project slips, make sure everyone understands why the project has slipped. Then, develop a realistic and revised version of the project plan. Dropping the project or cutting it short is a potential option that should be considered
