Encourage developers to solve the problem they know needs to be 
  solved now, not the problem that the developer speculates might need to be solved in the future. The future 
  problem should be solved once it arrives and you can see its actual shape and requirements in the physical 
  universe.

  The most important thing to cover in a review is the overall design of the CL

   If you see something nice in the CL, tell the developer, especially when they addressed one of your comments in a great way. Code reviews often just focus on mistakes, but they should offer encouragement and appreciation for good practices, as well. It’s sometimes even more valuable, in terms of mentoring, to tell a developer what they did right than to tell them what they did wrong.

Review code in this order: protocol buffers, unit tests, headers, implementation. It's common for a new employee to be an expert on C++ or Java or whatever languages but it's very uncommon to meet anyone who knows how to define a decent protocol message. The tests should give the reviewer a very clear idea of what's happening in the code (and this should be congruent with the description of the change), if not send back to author at this point. The headers should contain clear interfaces, types, and comments and should not contain anything that's not part of the API (when this is technically possible). Finally look in the CC file; at this point the reviewer should see things they were already expecting and no funny business.

Any claims about speed, efficiency, or performance whether in comments or during the review must have accompanying microbenchmarks or they should be deleted. Wrong ideas about software performance abound, and even correct beliefs become incorrect with time, in which case the microbenchmarks are critical to evaluating the continued value of the code.

In general, reviewers should favor approving a CL once it is in a state where it definitely improves the overall code health of the system being worked on, even if the CL isn’t perfect.

Also, if a reviewer makes it very difficult for any change to go in, then developers are disincentivized to make improvements in the future.

Also, a reviewer has ownership and responsibility over the code they are reviewing.

A key point here is that there is no such thing as “perfect” code—there is only better code. Reviewers should not require the author to polish every tiny piece of a CL before granting approval.

Reviewers should always feel free to leave comments expressing that something could be better, but if it’s not very important, prefix it with something like “Nit: “ to let the author know that it’s just a point of polish that they could choose to ignore.

Just keep in mind that if your comment is purely educational, but not critical to meeting the standards described in this document, prefix it with “Nit: “ or otherwise indicate that it’s not mandatory for the author to resolve it in this CL.

 Any purely style point (whitespace, etc.) that is not in the style guide is a matter of personal preference. The style should be consistent with what is there. If there is no previous style, accept the author’s.

  If the author can demonstrate (either through data or based on solid engineering principles) that several approaches are equally valid, then the reviewer should accept the preference of the author.

  If you see some major design problems with this part of the CL, you should send those comments immediately, even if you don’t have time to review the rest of the CL right now.

  we optimize for the speed at which a team of developers can produce a product together,

   If a reviewer only responds every few days, but requests major changes to the CL each time, that can be frustrating and difficult for developers. Often, this is expressed as complaints about how “strict” the reviewer is being. If the reviewer requests the same substantial changes (changes which really do improve code health) but responds quickly every time the developer makes an update, the complaints tend to disappear. Most complaints about the code review process are actually resolved by making the process faster.

If you are not in the middle of a focused task, you should do a code review shortly after it comes in.

One business day is the maximum time it should take to respond to a code review request (i.e. first thing the next morning).

However, after the emergency is resolved you should look over the emergency CLs again and give them a more thorough review.

Wanting to launch this week rather than next week (unless there is some actual hard deadline for launch such as a partner agreement).

A manager says that this review has to be complete and the CL checked in today because of a soft (not hard) deadline.

A hard deadline is one where something disastrous would happen if you miss it. For example:

Submitting your CL by a certain date is necessary for a contractual obligation.
Your product will completely fail in the marketplace if not released by a certain date.
Some hardware manufacturers only ship new hardware once a year. If you miss the deadline to submit code to them, that could be disastrous, depending on what type of code you’re trying to ship.
Delaying a release for a week is not disastrous. Missing an important conference might be disastrous, but often is not.

Most deadlines are soft deadlines, not hard deadlines. They represent a desire for a feature to be done by a certain time. They are important, but you shouldn’t be sacrificing code health to make them.

If you have a long release cycle (several weeks) it can be tempting to sacrifice code review quality to get a feature in before the next cycle. However, this pattern, if repeated, is a common way for projects to build up overwhelming technical debt. If developers are routinely submitting CLs near the end of the cycle that “must get in” with only superficial review, then the team should modify its process so that large feature changes happen early in the cycle and have enough time for good review

If you previously had fairly lax code reviews and you switch to having strict reviews, some developers will complain very loudly. Improving the speed of your code reviews usually causes these complaints to fade away.

Note that reviewers have discretion to reject your change outright for the sole reason of it being too large. Usually they will thank you for your contribution but request that you somehow make it into a series of smaller changes. It can be a lot of work to split up a change after you’ve already written it, or require lots of time arguing about why the reviewer should accept your large change. It’s easier to just write small CLs in the first place.

In general it’s better to err on the side of writing CLs that are too small vs. CLs that are too large. Work with your reviewer to find out what an acceptable size is.

It’s usually best to do refactorings in a separate CL from feature changes or bug fixes. For example, moving and renaming a class should be in a different CL from fixing a bug in that class. It is much easier for reviewers to understand the changes introduced by each CL when they are separate.

Small cleanups such as fixing a local variable name can be included inside of a feature change or bug fix CL,

Before writing a large CL, consider whether preceding it with a refactoring-only CL could pave the way for a cleaner implementation. Talk to your teammates and see if anybody has thoughts on how to implement the functionality in small CLs instead.

In general, if a reviewer isn’t providing feedback in a way that’s constructive and polite, explain this to them in person. If you can’t talk to them in person or on a video call, then send them a private email. Explain to them in a kind way what you don’t like and what you’d like them to do differently.
  
