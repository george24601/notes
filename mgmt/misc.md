### influcence without authority

My career lesson is that being right isn't the hard part of being a senior staff engineer. Being right isn't enough. It's building alignment across the entire org towards the right solution. That's the hard valuable problem that I'm paid to solve.

The biggest challenge for DX teams remains figuring out how to (a) communicate but more importantly (b) align their work with the key priorities of the business. I got to be okay at (a) but never particularly succeeded at (b) in my time at LinkedIn.

Positively trivial compared to py2 to 3. But management just were not up for it at all. Even with research done showing we could expect literally a baseline of 10% improvement in performance (so you do the math on that vs the 50M of spend), they just did not want to "waste time on version upgrades." The staff engineer was told they were being unreasonable in pushing so hard. Their manager tried to ditch them, but again, they're good at the staff eng game, so they switched teams due to being in the good graces (due to an excellent track record) with a middle manager above them. They decided, hey fuck you, I'm going to one man army this effort. They did, they had preview versions ready in less than a month and had migrated some of the bigger-win jobs within 2, saving their annual comp (which was prodigious) several times over just in that. Suddenly everyone was keen on moving their stuff over now that the startup cost (both political and eng-time) was paid.

Because again being right -and getting buy in- is the important part. Not later giving everyone an 'I told you so'.

5 year plan is sounding really bad, though

Sometimes it is not about saying yes and no to them but listening to what they are trying to say. Sometimes if you ask a few questions they learned something about the business that makes their case come apart. Sometimes if you listen to them you find a good idea and it opens up a whole new area of the product. So I think it’s a false dichotomy and you have to be good at listening and asking the right questions to get your point across.



### away team

When someone shows up at your cube and asks for a new feature in the service you are offering or to fix a bug or to optimize performance, what do you do? Do you let them have access to your source code? If a new feature is popular with users or customers, do you keep it for your team or give it to the team where it may more naturally belong? If your team could add a capability that would help other teams make more money, should you do that before what is on your approved roadmap?

once a team is the only remaining user of an API, they become owners of that service, even if they didn’t initially develop it.

The "value to the customer" is part of the mission for each team. This codified using content such as mock press releases to ensure developers keep end user needs in mind.

Decreasing technical debt is not considered a good reason to do anything unless it has an impact on reaching the goals of the team.

Changes to one team’s service may be implemented by another team who needs the enhanced capability by what is called an Away Team. This team works on the Home Team’s code to add what it needs according to established engineering standards and then leaves that code in good order to be maintained by the Home Team who owns the service, with help when needed.

When an Away Team is not an option because the requestor doesn’t have the ability to implement improvements to the service, this does lead to a management discussion about how to optimize the big picture roadmap. Usually roadmaps are bursting, so accommodating a new request means reshuffling the existing roadmap.

If extending a service using an Away Team doesn’t work out for some reason, it is perfectly fine to duplicate and create whatever you need to accelerate your progress. There is no concern about duplication across the platform as long as you have a need that will help you move forward.

It is possible to go against the recommendation of a bar raiser, but such a move is noted and made visible to higher levels of management.

MIT professor Eric Von Hippel’s research into user-driven innovation shows that when the user is given direct access to the means for creating a solution, potentially at least, tremendous innovation can result. The "sticky information" that otherwise must be rendered into requirements documents or transferred from user to builder is difficult and never complete. When this step doesn’t have to take place because user and builder are the same person or same team, the outcome is much better. 

The policy is to do whatever it takes to provide value to the customer and not worry about duplication or deviating from standards. There is no waiting while the perfect shared service is being developed. There is no friction from having to use the perfect shared service.

 A common motto is “two is better than none,” meaning do what you need to do. Another balancing motto is “none is better than five,” so don’t get carried away and create a new service each time something doesn’t exactly fit.

Weak code ownership: Developers are allowed to change modules owned by other people. Module owners are expected to take responsibility for the modules they own and keep an eye on changes made by other people

The most efficient, fastest, and safest way to add service features is through their host teams. Therefore, away teams should first try to accommodate their requirements within the host team’s roadmap. If they don’t reach an agreement, the away team should own the process of adding the feature, and the host team cannot block the away team regardless of how important, complex, and sensitive the codebase is.

 However, the away team does not need to wait on the host team to make the code changes, and away teams must not require host teams to commit time to support their project, but if possible, the host team should provide advice, documentation, code review, Etc.

when teams keep requesting a host team to use the away team mechanism. We should ask them to consider improving the service architecture to make it self-service and extensible to avoid the constant inefficiency of using the away team model.

In the single-threaded ownership model, the leader controls all resources required to deliver on the initiative. In this model, reporting structures align with project responsibilities, and each team member reports directly to the leader.

In the single-threaded leadership model, the leader recognizes that maintaining reporting lines within functional disciplines is helpful (e.g., engineers report to engineers, designers to designers), meaning team members benefit from functional leadership and natural career development. The single-threaded leader works across disciplines to drive prioritization and roadmaps and manages all of the associated cross-team communication but does not ultimately control the resources required for delivery.

	Prefer two solutions than none, one is better than two.

Two solutions might create waste, but the increase of velocity will outweigh the duplication effort. Allowing teams to build multiple similar solutions for similar problems enable them to do efficient exploration of the problem space.

 Single-threaded leaders are responsible for (almost) never presenting two functionally identical but distinct solutions that will create confusing and fragmented experiences for customers. 
 

Some men have an irresistible desire to justify their every action. Some like to magnify themselves. Others like to provide an alibi ready for use if needed. Some, perhaps, just don’t think. In any event, they write a letter to some other department or to the boss. The letter first tells how much the writer or his group are doing. Then it puts the finger on others. Just write a few letters like this with plenty of copies sent around, and you’ll dig a grave you’ll never get out of.

We have all been approached at some time or other by the Unwise Citer. He asks us to take some action, or refrain from one, solely because certain other people have done so under supposedly like circumstances. The citer, lacking good arguments, has sought to substitute secondhand opinions. This is unfair. It is not helpful. And it directly assaults our ego. We are not given credit for having brains and judgment of our own. Bad stuff.

A somewhat more subtle form of negation, is refinement of measurement. One man says that a tank weights ninety tons. And for that particular discussion, accuracy is of no consequence. Yet someone’s ego speaks up and says, Ninety-two tons. Maybe he’s right at that. But he’s wrong just the same. This is a favorite husband-and-wife game. Let’s be on guard against it.

Another thing. Don’t beg. People don’t like it. If then we speak up for some better job that’s open, let’s not till our talk with such words as hoping, thanking, eagerly, favor. If we are really worthy of the job, the Company will benefit by giving it to us every bit as much as we will profit by getting it. The thing works both ways. Why then use begging words that suggest we are thinking of ourselves, not of the Company? And why suggest that we’re not too confident in our ability?

When time comes to reward people, it is the gut feeling of whose work is truly remarkable that matters. And what you usually convince yourself of is that the goal is important – but not that achieving it is remarkable. In fact, often someone pursuing what you think are unimportant goals in a way that you admire will impress you more than someone doing "important grunt work" (in your eyes.)

If something is rotten in an org, the root cause is a manager who doesn't value the work needed to fix it. They might value it being fixed, but of course no sane employee gives a shit about that. A sane employee cares whether they are valued.

As a final step to learning internals, I read recent commits relevant to the subsystems I’ve studied and test that I fully understand why the change was made. This is my “doing the problem set in the back of the textbook” portion of learning.

I either view the commit history of the project or the commit history of a specific file or folder relevant to a subsystem I’ve studied. I then either study the solution first (the changes in the commit) or I see the bug it fixed and attempt to fix it myself and see if I arrive to a similar solution.

To “work the problem”, I’ll checkout the repository at the commit just previous to the commit I’m studying. I’ll reproduce the bug it fixes (if it is a bug fix), and then attempt to implement the solution myself. Finally, I’ll compare my work to the commit done by the maintainer or contributor.

The only hint I'll give myself is the change size necessary (the +/- lines on the VCS diff). I recommend avoiding changes that require more than 50 to 100 changed lines to start.

When teams try to meet the imaginary timeline produced by the crystal ball, tunnel vision creeps in. Like a Fata Morgana that appears when you’re stuck in the desert, the only thing everyone sees is the looming deadline. The whole discussion reverts to ‘How can we meet that deadline?’ while ‘Is it good enough?’ moves to the backseat, and ‘How can we move faster?’ climbs into the driver’s seat.

Obsessive focus on ‘When will it be done?’ guarantees you will move the delivery of value to the backseat.

### reduce filler

We use these words as a verbal place holder when we are thinking — while communicating. They are a verbal representation of our thinking and an indication to our listener that we are not yet done communicating. They are a signal that what we are saying is getting ahead of what we are thinking.

Additionally, practicing your speech will definitively reduce your use of filler words. When we are prepared for any communications scenario we are more focused and effective in our deliver. 

A better habit than abuse/overuse of filler words is to allow yourself to pause. Doing so will allow you to think about what you will say next without filling the space with words that don’t serve your communication. Pause, then construct what you are going to say internally before you open your mouth.

A pause of silence allows us to think of what we’ll say next, stay centered and focused on the accuracy and effectiveness of our communication.

Speaking at a less hurried pace alongside these other techniques will help minimize your use of these meaningless words. 

With any important speech you should practice and record it at least 3-5 times. After each attempt, review your recording and count how often you used filler words. Note the number of filler words and then run through your speech again with an effort to relax, center yourself, and use pauses or words that serve your communication instead. Remember to slow down and be mindful of your word choice

As you listen to your recorded sessions (audio or video) take note of what filler words you use and their frequency. Knowing your habits is a first step in a rising self-awareness that will bring freedom from these poor habits.

Using filler words is a sign of nervousness and lack of preparation. Audiences are connected to confident speakers, and crutch words may detract from an otherwise excellent speech.

In order to start the process of elimination, you must become aware of your favorite filler words,” Smith says. “Personally, my go-to word was ‘so.’ Once I became aware of that, I realized my pattern of usage. Moving forward, during presentations I would mentally catch myself about to say 'so' and pause to avoid verbalizing it

Forcing yourself to notice other people’s less-than-eloquent speech patterns, too, can make you conscious of how often you slip “like” into daily conversations, say “um” before answering questions at cocktail parties, or lead sentences with an unnecessary “so” during work presentations.

If you’re a person who likes to write out what you plan to say, be sure to eliminate compound sentences, never start with a prepositional phrase, put most of your sentences in subject/predicate order and eliminate any vocabulary that you have difficulty saying without hesitating. The basic idea is to write for the ear, not the eye!

the optimum frequency is about one filler per minute, but the average speaker uses five fillers per minute — or, one every twelve seconds.

As long as the pause isn’t too long (no more than five seconds), the audience won’t hold it against you

 On average, the optimal ratio of preparation to performance is one hour of practice for every minute of presentation, but at the very least, recommends speakers get in at least three full runs before stepping in front of an audience.


### Wallenda factor

Self regard is an intrinsic judgment, while the “Wallenda Factor” is an extrinsic judgment about producing an outcome.  The Wallenda Factor relates to one’s perception of the outcome of an event.

 ‘All karl thought about for three straight months prior to it was falling. It was the first time he’d ever thought about that, and it seemed to me that he put all his energies into not falling rather than walking the tightrope

When his team dropped its first
game after 29 straight home court victories, we called to see how he felt about it. His response
was vintage Wallenda: ‘Great! Now I can start concentrating on winning, not on not losing.’
Meyer helped frame for us what we’re now referring to as the Wallenda factor, the capacity to
embrace positive goals, to pour one’s energies into the task, not into looking behind and
dredging up excuses for past events.


Build self-confidence through high expectations. Successful leaders have high expectations, both of themselves and of their consituents.

the expectation that an employee can perform at a level that he/she does not see himself/herself capable of achieving. Creates a shift in the individual’s confidence that he/she can perform at the higher level—and then does so.

Fear of failure makes you focus on limiting risks instead of focusing on maximizing an opportunity for success
