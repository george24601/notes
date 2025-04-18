prompt engieering is an iterative process
document various prompt attempts
When zero shot does not work, try one shot and few shot prompting, i.e., single example and multiple examples. Rule of thumb is 3-5 examples. A small example in the prompt may confuse the model. Include edge cases if the input could be diverse

```
Parse user's request into JSON

EXAMPLE:

Response:

Now I would like to order...

Response:

```

### System prompting 
sets the overall context and purpose for the language model. It defines the ‘big picture’ of what the model should be doing, like translating a language, classifying a review etc. Defines the model’s fundamental capabilities and overarching purpose.


The
name ‘system prompt’ actually stands for ‘providing an additional task to the system’

```
Classify movie reviews as positive, neutral or negative. Return
valid JSON:
Review: "Her" is a disturbing study revealing the direction
humanity is headed if AI is allowed to keep evolving,
unchecked. It's so disturbing I couldn't watch it.
Schema:
```
MOVIE:
{
"sentiment": String "POSITIVE" | "NEGATIVE" | "NEUTRAL",
"name": String
}
MOVIE REVIEWS:
{
"movie_reviews": [MOVIE]
}
```
JSON Response:
```

by prompting for a JSON format it forces the model to create a structure and limit hallucinations.




### Contextual prompting 
provides specific details or background information relevant to the current conversation or task. It helps the model to understand the nuances of what’s being asked and tailor the response accordingly. Provides immediate, task-specific information to guide the response.

It’s highly specific to the current task or input, which is dynamic

```
Context: You are writing for a blog about retro 80's arcade
video games.
Suggest 3 topics to write an article about with a few lines of
description of what this article should contain.
```

### Role prompting 
assigns a specific character or identity for the language model to adopt.  This helps the model generate responses that are consistent with the assigned role and its associated knowledge and behavior.  Frames the model’s output style and voice. It adds a layer of specificity and personality.

There can be considerable overlap between system, contextual, and role prompting. E.g. a prompt that assigns a role to the system, can also have a context.

```
I want you to act as a travel guide. I will write to you
about my location and you will suggest 3 places to visit near
me. In some cases, I will also give you the type of places I
will visit.
My suggestion: "I am in Amsterdam and I want to visit
only museums."
Travel Suggestions:
```

Once the model has been assigned a role, you can then give it prompts that are specific to that role.

Here are some styles you can choose from
Confrontational, Descriptive, Direct, Formal, Humorous, Influential, Informal,
Inspirational, Persuasive

```
I want you to act as a travel guide. I will write to you about
my location and you will suggest 3 places to visit near me in
a humorous style.
My suggestion: "I am in Manhattan."
Travel Suggestions:
```

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

### CoT

You can combine it with few-shot prompting to get better results on more complex tasks that require reasoning before responding as it’s a challenge with a zero-shot chain of thought.

```
When I was 3 years old, my partner was 3 times my age. Now, I am 20 years old. How old is my partner? Let's think step by step.
```

```

Q: When my brother was 2 years old, I was double his age. Now
I am 40 years old. How old is my brother? Let's think step
by step.
A: When my brother was 2 years, I was 2 * 2 = 4 years old.
That's an age difference of 2 years and I am older. Now I am 40
years old, so my brother is 40 - 2 = 38 years old. The answer
is 38.
Q: When I was 3 years old, my partner was 3 times my age. Now,
I am 20 years old. How old is my partner? Let's think step
by step.
A:
```

Generally, any task that can be solved by ‘talking through is a good candidate for a chain of thought. If you can explain the steps to solve the problem, try chain of thought.

### Self-consistency

1. Generating diverse reasoning paths: The LLM is provided with the same prompt multiple
times. A high temperature setting encourages the model to generate different reasoning
paths and perspectives on the problem.
2. Extract the answer from each generated response.
3. Choose the most common answer.

### ReAct

```python
from langchain.agents import load_tools
from langchain.agents import initialize_agent
from langchain.agents import AgentType
from langchain.llms import VertexAI
prompt = "How many kids do the band members of Metallica have?"
llm = VertexAI(temperature=0.1)
tools = load_tools(["serpapi"], llm=llm)
agent = initialize_agent(tools, llm,
agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION, verbose=True)
agent.run(prompt)
```

### Prompts for explaining code

```
Explain to me the below Bash code:
````
#!/bin/bash
echo "Enter the folder name: "
read folder_name
if [ ! -d "$folder_name" ]; then
echo "Folder does not exist."
exit 1
fi
files=( "$folder_name"/* )
for file in "${files[@]}"; do
new_file_name="draft_$(basename "$file")"
mv "$file" "$new_file_name"
done
echo
```

### Prompts for debugging and reviewing code

```

The below Python code gives an error:
Traceback (most recent call last):
File "/
Users/leeboonstra/Documents/test_folder/rename_files.py", line
7, in <module>
text = toUpperCase(prefix)
NameError: name 'toUpperCase' is not defined
Debug what's wrong and explain how I can improve the code.
````python

```

### Best Practices

The most important best practice is to provide (one shot / few shot) examples within a prompt. 
As a rule of thumb, if it’s already confusing for you it will likely be also confusing for the model. 

#### Be specific about the output

Providing specific details in the prompt (through system or context prompting) can help the model to focus on what’s relevant,

DO:
Generate a 3 paragraph blog post about the top 5 video game consoles.
The blog post should be informative and engaging, and it should be
written in a conversational style.
DO NOT:
Generate a blog post about video game consoles.


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

#### Use variables in prompts

```
VARIABLES
{city} = "Amsterdam"
PROMPT
You are a travel guide. Tell me a fact about {city}

```




