80% of requirements release in 2 weeks
80% of requirement dev can be done in a week
80% of of release can be done 1 hour after the submit

From Principles of Product Development Flow: key to the problem is almost always blocked requirment instead of blocked resources

Kanban stages

choose, design, to review, to dev, dev design, dev (req, front end, backend, test, dependency, complete), to test, test, to release

separate req tickets with dev/resource tickets, put resource/work ticket same lane as its requirement ticket, requirement ticket in its requriment column in the dev column group

when it enters to dev: 
dev, test, busis clarify on requirment, and agree on the interactive process and test standard
big reg to smaller task within 2 weeks
confirm  plan with related business 
recognize tech resk and define solution
assign a coordintor for progress coordniate if >= 3 people involved

* There are no pre-defined roles for a team. Although there may still be a Project Manager, the team is encouraged to collaborate and chip in when any one person becomes overwhelmed.

* Allows for changes to be made to a project mid-stream, allowing for iterations and continuous improvement prior to the completion of a project
* Best for projects with widely-varying priorities
* If your team has a continuous stream of work requests, kanban may be right for you. no regular fixed length sprints, key metrics is cycle time - change can happen at any time
* Kanban is great for teams that have lots of incoming requests that vary in priority and scope.
* The best part of Kanban is making custom columns for how your team works.
* In theory, kanban does not prescribe a fixed time to deliver a task. If the task gets completed earlier (or later), it can be released as needed without having to wait for a preset release milestone, as in the case of scrum.
* unlike scrum, there is no single “kanban master” who keeps everything running smoothly. It’s the collective responsibility of the entire team to collaborate and deliver the tasks on the board.
* Cycle time is an important metric for kanban teams. It is the average amount of time that it takes for a task to move from the start to finish line. Improving cycle times indicates the success of kanban teams.
* A Kanban team is not required to be cross-functional since the Kanban work flow is intended to be used by any and all teams involved in the project. Therefore, a team of specialists and a separate team of generalists may be working on different aspects of the same Kanban project from the same board, and that’s ok.
* Since each column has a limited number of allowed stories and there are no required time boxes (such as sprint length), there is no reason to reset the Kanban board as work progresses.
* Need to define clear definition of moving to the next stage

Scrum
* Each team member has a predefined role, where the Scrum master dictates timelines, Product owner defines goals and objectives and team members execute the work.
* Deliverables are determined by sprints, or set periods of time in which a set of work must be completed and ready for review.
* Also uses a “pull system” however an entire batch is pulled for each iteration.
* Changes during the sprint are strongly discouraged.
* Best for teams with stable priorities that may not change as much over time.
* Scrum status updates and prioritization meetings are led by Scrum Masters. A Scrum Master is a person on a Scrum team who is responsible for ensuring the team live by the standards set by Scrum.
* Scrum teams commit to ship working software at the end of set intervals, called sprints. If you need to ship value to customers on a regular basis, scrum is the way.
* Scrum teams sometimes get feedback and learn that what they’re working on isn’t as valuable to the customer as they thought. In such cases, the scope of the sprint should change to reflect the importance of shipping value to the customer first and foremost.


Columns from left to right:

Backlog – Ideas that we may or may not implement.

Requested / Business Requirements – Ideas that are going to be developed. The business need of the work item is listed inside the card.

Requested / Ready for Tech Design – Things that have been clarified and agreed to get to In Progress.

In Progress / Tech Design / Tech Design – The assignee of any card that is started writes in the technical design of what they’re about to start developing.

In Progress / Tech Design/ Ready for Review – The card is wating to be reviewed.

In Progress / Tech Design/ Tech Design Review – A fellow team member reviews the tech design and suggest changes (if necesarry).

In Progress / Tech Design/ Ready for Coding – After the tech design is finalized, the card remains here untill the assignee can start coding.

In Progress / Development / Coding – Code is written.

In Progress / Development / Ready for Code Review – Cards are waiting for code review.

In Progress / Development / Code Review – The actual review stage where the code is checked.

In Progress / Ready for Production – Cards ready to be deployed on production.

Production / To be Tested on Production – Cards deployed on to production, pending a final verification by the QA team.

Done / Possible to Return – For special features requested by customer that may be returned for rework.

Done – Done pile for non-production related items like research, meetings, etc.

Swimlanes from top to bottom:

Expedite – Super urgent cards. Everyone helps to get the item expedited. Usually a critical customer defect, security-related issues, etc.

Customer Issues – Defects reported by customers. The customer is always first, remember?

Bugs – Internal bugs found by somebody on the team

Technical Debt – Things that we should have done :-/

Customer / Business Features – New features to be introduced in Kanbanize

Technical Features – Usually DevOps tasks, deployment-related activities, database schema changes, etc.

As a matter of fact, technical features may often make it to the expedite swimlane, if we have an automation piece that blocks the release.

The main purpose of this swimlane is to visually separate technical features from business features and to allow better tracking of the given work type.
