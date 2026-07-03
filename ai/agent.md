Every orchestration approach needs the concept of a ‘run’, typically implemented as a loop that lets agents operate until an exit condition is reached. Common exit conditions include tool calls, a certain structured output, errors, or reaching a maximum number of turns.

When more complexity is warranted, workflows offer predictability and consistency for well-defined tasks, whereas agents are the better option when flexibility and model-driven decision-making are needed at scale. 

#### Workflow: Orchestrator-workers

a central LLM dynamically breaks down tasks, delegates them to worker LLMs, and synthesizes their results.

#### Workflow: Evaluator-optimizer

The two signs of good fit are, first, that LLM responses can be demonstrably improved when a human articulates their feedback; and second, that the LLM can provide such feedback. 


### Hooks

PreReasoning: inject state, pre-load memory, load long term memory on demand
PreToolCall: verify capability scope, idempotency check, risk analysis
PostToolCall: verify result, update sate, cross check with the real time data
PostReasoning: verify the the result aligns with the real data, if the right tool is called
OnsessionEnd: update the memory and trigger the memory compression






