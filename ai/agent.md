
MCP Host — LLM application (such as Cursor) that manages connections

MCP Client — Maintains 1:1 connections with MCP servers

The MCP Host (together with the client) would first call the MCP Server to ask which tools are available.

Reflexion is a technique that uses verbal reinforcement to help agents learn from prior failures

SELF-REFINE, where actions of refining output and generating feedback are repeated

### A practical guide for building agents


#### Best practices for agent instructions

Every orchestration approach needs the concept of a ‘run’, typically implemented as a loop that lets agents operate until an exit condition is reached. Common exit conditions include tool calls, a certain structured output, errors, or reaching a maximum number of turns.


### Guardrails

Agent first task is planning. It will breakdown complex task into steps. 
Agent allows models to use tools and external data. 


When more complexity is warranted, workflows offer predictability and consistency for well-defined tasks, whereas agents are the better option when flexibility and model-driven decision-making are needed at scale. 

#### Workflow: Prompt chaining

You can add programmatic checks (see "gate” in the diagram below) on any intermediate steps to ensure that the process is still on track.



#### Workflow: Orchestrator-workers

a central LLM dynamically breaks down tasks, delegates them to worker LLMs, and synthesizes their results.

#### Workflow: Evaluator-optimizer

The two signs of good fit are, first, that LLM responses can be demonstrably improved when a human articulates their feedback; and second, that the LLM can provide such feedback. 


