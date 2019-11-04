Suppose project completion time follows a Pareto (power law) distribution with parameter α. That is, for t > 1, the probability that completion time is bigger than t is t-α. (We start out time at t = 1 because that makes the calculations a little simpler.)

Now suppose we know that a project has lasted until t0 so far. Then the expected finish time is αt0/(α-1) and so the expected additional time is t0/(α-1). Note that both are proportional to t0. So the longer it has taken, the longer it will take. If the project is running late, you can expect the time remaining to be even more than the expected time before the project started. The finish line is moving away from you!

For example, suppose α = 2 (in applications of power laws, α is often between 1 and 3) and you’re measuring time in years. When the project starts at t = 1, it is expected to take one year, until t = 2. Now suppose you’re starting the second year and the project isn’t done. Now it’s expected to finish at t = 4, two more years. When you started, the project was supposed to take a year. One year later, it has taken a year, and should be expected to take two more years.

This phenomenon sometimes occurs regardless of the individual's knowledge that past tasks of a similar nature have taken longer to complete than generally planned.The bias only affects predictions about one's own tasks; when outside observers predict task completion times, they show a pessimistic bias, overestimating the time needed

 At a certain point your learning will plateau, and this is when the second type of work kicks in: executing. This is the act of applying that knowledge to get the job done and create leverage. Eventually, you will create enough leverage to automate the job or grow out of it, and this is when you start the cycle over. Learn. Execute.

 The segmentation effect (?) is defined as the time allocated for a task being significantly smaller than the sum of the time allocated to individual smaller sub-tasks of that task.

deadline is the best driver: so small deadlines

structured procastination - work on something important but not urgent!

the true end of task - complete work and get evaluation

Most work is async by far. People post what they're up to, and other people will go and bother them if they're doing something relevant.

100% on self starters. Micromanagers or workers that require great oversight aren't going to work.

That sounds like how all my best managers have worked, whether on site or remote. Their job is to facilitate your work, not control it.

“International team” where expectation and default cultural bias are major issues.

You need to act like a larger company than you actually are. you need to be stricter about best practices, and you will run into communication problems… a lot of them.

Similarly problematic are satellite offices. The bridge between the offices has 5x communication needs, but people in each office act like co-located teams. Unless the offices can work mostly autonomously, this communication bridge between them will suffer.

If you need a small office, make sure people in it don’t have a critical mass in projects and communicate remote-friendly.

In remote teams, you need to set up in a way people can be as autonomously as they need. Autonomously doesn’t mean “left alone” it means “be able to run alone” (when needed).

Wait for problems before you introduce solutions (esp. processes or infrastructure)

## Bain's rapid model
R – Recommend
A – Agree
P – Perform
I – Input
D – Decide


R = Responsible: A person actually doing the work. You can have multiple “R” entries for a task. This means more than one person does the work.

A = Accountable: The person who will be ultimately held accountable for the work. Should have only one person

C = Consulted: A person who should be consulted for their opinion. These people may be outside of your team.
Those whose opinions are sought, typically subject matter experts; and with whom there is two-way communication
"C" means that the person doesn’t contribute to doing the work. Instead, you just ask for their input and feedback.

I = Informed: A person who should be informed of the outcome or progress of the work, but they don’t really get a say in how the work is done
Those who are kept up-to-date on progress, often only on completion of the task or deliverable; and with whom there is just one-way communication

 Outside of the AR exception, it is generally recommended that each role in the project or process for each task receive, at most, just one of the participation types. 

Support
Resources allocated to responsible. Unlike consulted, who may provide input to the task, support helps complete the task. Resources which play a supporting role in implementation.

Quality Review
Those who check whether the product meets the quality requirements.

Out of the loop (or omitted)
Designating individuals or groups who are specifically not part of the task. Specifying that a resource does not participate can be as beneficial to a task's completion as specifying those who do participate.

 

PACSI
This is a version very useful to organizations where the output of activities under the accountability of a single person/function can be reviewed and vetoed by multiple stakeholders, due to the collaborative nature of the culture.
Perform
The person/function carrying out the activity.
Accountable
The person/function ultimately answerable for the correct and thorough completion of the deliverable or task, and often the one who delegates the work to the performer.
Control
The person/function reviewing the result of the activity. He or she has a right of veto; his or her advice is binding.
Suggest
The person/function consulted to give advice based upon recognized expertise. The advice is non-binding.
Informed
The person/function who must be informed of the result of the activity.


### Chapter 18. Propositions of The Mythical Man-Month: True or False?
15.5 Most documentation fails in giving too little overview. Stand way back and zoom in slowly.

Moving down across the horizontal boundary, a program becomes a programming product. This is a program that can be run, tested, repaired, and extended by anybody. It is usable in many operating environments, for many sets of data.
 In particular the range and form of inputs must be generalized as much as the basic algorithm will reasonably allow. Then the program must be thoroughly tested, so that it can be depended upon. This means that a substantial bank of test cases, exploring the input range and probing its boundaries, must be prepared, run, and recorded. Finally, promotion of a program to a programming product requires its thorough documentation, so that anyone may use it, fix it, and extend it. As a rule of thumb, I estimate that a programming product costs at least three times as much as a debugged program with the same function.

Moving across the vertical boundary, a program becomes a component in a programming system. This is a collection of interacting programs, coordinated in function and disciplined in format, so that the assemblage constitutes an entire facility for large tasks. To become a programming system component, a program must be written so that every input and output conforms in syntax and semantics with precisely defined interfaces. The program must also be designed so that it uses only a prescribed budget of resources—memory space, input-output devices, computer time. Finally, the program must be tested with other system components, in all expected combinations. This testing must be extensive, for the number of cases grows combinatorially. It is time-consuming, for subtle bugs arise from unexpected interactions of debugged components. A programming system component costs at least three times as much as a stand-alone program of the same function.

 It is complete in itself, ready to be run by the author on the system on which it was developed. That is the thing commonly produced in garages, and that is the object the individual programmer uses in estimating productivity.

Underestimates do not change significantly during the activity until about three weeks before the scheduled completion

When estimating project times, it should be remembered that programming products (which can be sold to paying customers) and programming systems are both three times as hard to write as simple independent in-house programs.

The preparation of a PERT chart is the most valuable part of its use. Laying out the network, identifying the dependencies, and estimating the legs all force a great deal of very specific planning very early in a project. The first chart is always terrible, and one invents and invents in making the second one.

Work complicates to fill the available time.

The demand upon a resource tends to expand to match the supply of the resource (If the price is zero). The reverse is not true.

This phenomenon sometimes occurs regardless of the individual's knowledge that past tasks of a similar nature have taken longer to complete than generally planned.[3][4][5] The bias only affects predictions about one's own tasks; when outside observers predict task completion times, they show a pessimistic bias, overestimating the time needed.[6][7] The planning fallacy requires that predictions of current tasks' completion times are more optimistic than the beliefs about past completion times for similar projects and that predictions of the current tasks' completion times are more optimistic than the actual time needed to complete the tasks.

A survey of Canadian tax payers, published in 1997, found that they mailed in their tax forms about a week later than they predicted. They had no misconceptions about their past record of getting forms mailed in, but expected that they would get it done more quickly next time.[10] This illustrates a defining feature of the planning fallacy; that people recognize that their past predictions have been over-optimistic, while insisting that their current predictions are realistic

The segmentation effect is defined as the time allocated for a task being significantly smaller than the sum of the time allocated to individual smaller sub-tasks of that task. 
