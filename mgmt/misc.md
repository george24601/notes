
### away team

once a team is the only remaining user of an API, they become owners of that service, even if they didn’t initially develop it.

Decreasing technical debt is not considered a good reason to do anything unless it has an impact on reaching the goals of the team.

Changes to one team’s service may be implemented by another team who needs the enhanced capability by what is called an Away Team. This team works on the Home Team’s code to add what it needs according to established engineering standards and then leaves that code in good order to be maintained by the Home Team who owns the service, with help when needed.

When an Away Team is not an option because the requestor doesn’t have the ability to implement improvements to the service, this does lead to a management discussion about how to optimize the big picture roadmap. Usually roadmaps are bursting, so accommodating a new request means reshuffling the existing roadmap.

If extending a service using an Away Team doesn’t work out for some reason, it is perfectly fine to duplicate and create whatever you need to accelerate your progress. There is no concern about duplication across the platform as long as you have a need that will help you move forward.

It is possible to go against the recommendation of a bar raiser, but such a move is noted and made visible to higher levels of management.

The policy is to do whatever it takes to provide value to the customer and not worry about duplication or deviating from standards. There is no waiting while the perfect shared service is being developed. There is no friction from having to use the perfect shared service.

The most efficient, fastest, and safest way to add service features is through their host teams. Therefore, away teams should first try to accommodate their requirements within the host team’s roadmap. If they don’t reach an agreement, the away team should own the process of adding the feature, and the host team cannot block the away team regardless of how important, complex, and sensitive the codebase is.

 However, the away team does not need to wait on the host team to make the code changes, and away teams must not require host teams to commit time to support their project, but if possible, the host team should provide advice, documentation, code review, Etc.

when teams keep requesting a host team to use the away team mechanism. We should ask them to consider improving the service architecture to make it self-service and extensible to avoid the constant inefficiency of using the away team model.

