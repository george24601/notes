### Step-back prompting

 prompting the LLM to first consider a general question related to the specific task at hand, and then feeding the answer to that general question into a subsequent prompt for the specific task. This ‘step back’ allows the LLM to activate relevant background knowledge and reasoning processes before attempting to solve the specific problem.

```
Based on popular first-person shooter action games, what are
5 fictional key settings that contribute to a challenging and
engaging level storyline in a first-person shooter video game?
```

```
Context: 5 engaging themes for a first person shooter video game:
...

Take one of the themes and write a one paragraph storyline for a new level of a first-person shooter video game that is challenging and engaging.

```

#### Use Instructions over Constraints

Growing research suggests that focusing on positive instructions in prompting can be more effective than relying heavily on constraints. This approach aligns with how humans prefer positive instructions over lists of what not to do.

DO:
Generate a 1 paragraph blog post about the top 5 video game consoles.
Only discuss the console, the company who made it, the year, and total
sales.
DO NOT:
Generate a 1 paragraph blog post about the top 5 video game consoles.
Do not list video game names.

As a best practice, start by prioritizing instructions, clearly stating what you want the model to do and only use constraints when necessary for safety, clarity or specific requirements.

