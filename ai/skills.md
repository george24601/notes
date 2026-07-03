description should include "What does this skill do" and "when to use it", and not about summary of the workflow. However, prioritize "why" instead of "how". Need to test when it should trigger but didn't and when it should not trigger but did.

Skill may skip the steps with excuses, and skill should list out and deny these common excuses

List what must and must not done (but also supply the alternatives if possible for better compliance), how to verify it is done, and when to ask human interventions

Business side just registers the business-specific skills

Declare scope and limit so that Agent can check if it falls into the capability domain

Use the raw model to do the same task to compare and contrast before vs after

Eval needs to check to tool call and not only the result

To eval skill, can use a sub proxy to simulate the real user task, and ask it to use the skill, but don't ask it toe review and fix the problem directly. Give the sub proxy original task, orgiinal data, and minimal necessary context, so that it can be used as if it is a real task

Whitelist ont he tools can use, and disallow general purpose tools such as real HTTP call

Use a few natural language varaints to see if skill can be triggered. Test if rouitng is dispacthing, the redline has been obied.

Compare skill vs without skill for 5 times, and compare token amount and the complete quality



