
MCP Host — LLM application (such as Cursor) that manages connections

MCP Client — Maintains 1:1 connections with MCP servers

The MCP Host (together with the client) would first call the MCP Server to ask which tools are available.

Reflexion is a technique that uses verbal reinforcement to help agents learn from prior failures

SELF-REFINE, where actions of refining output and generating feedback are repeated

### A practical guide for building agents
Consider the example of payment fraud analysis. A traditional rules engine works like a checklist, flagging transactions based on preset criteria. In contrast, an LLM agent functions more like a seasoned investigator, evaluating context, considering subtle patterns, and identifying suspicious activity even when clear-cut rules aren’t violated. This nuanced reasoning capability is exactly what enables agents to manage complex, ambiguous situations effectively

prioritize workflows that have previously resisted automation, especially where traditional methods encounter friction:

* Workflows involving nuanced context-sensitive decisions, for example refund approval in customer service workflows.
* Systems that have become unwieldy due to extensive and intricate rulesets, making updates costly or error-prone, for example performing vendor security reviews.
* Scenarios that involve interpreting natural language, extracting meaning from documents, or interacting with users conversationally, for example processing a home insurance claim.


An approach that works well is to build your agent prototype with the most capable model for every task to establish a performance baseline. From there, try swapping in smaller models to see if they still achieve acceptable results. 

cases arise, you can update variables rather than rewriting entire workflows.

#### Best practices for agent instructions

* Providing smaller, clearer steps from dense resources helps minimize ambiguity and helps the model better follow instructions.
* Make sure every step in your routine corresponds to a specific action or output. For example, a step might instruct the agent to ask the user for their order number or to call an API to retrieve account details. Being explicit about the action (and even the wording of a user-facing message) leaves less room for errors in interpretation.
* Real-world interactions often create decision points such as how to proceed when a user provides incomplete information or asks an unexpected question. A robust routine anticipates common variations and includes instructions on how to handle them with conditional steps or branches such as an alternative step if a required piece of info is missing.

```
You are an expert in writing instructions for an LLM agent. Convert the following help center document into a clear set of instructions, written in a numbered list. The document will be a policy followed by an LLM. Ensure that there is no ambiguity, and that the instructions are written as directions for an agent. The help center document to convert is the following {{help_center_doc}}
```

While it’s tempting to immediately build a fully autonomous agent with complex architecture, customers typically achieve greater success with an incremental approach.

Every orchestration approach needs the concept of a ‘run’, typically implemented as a loop that lets agents operate until an exit condition is reached. Common exit conditions include tool calls, a certain structured output, errors, or reaching a maximum number of turns.

An effective strategy for managing complexity without switching to a multi-agent framework is to use prompt templates. Rather than maintaining numerous individual prompts for distinct use cases, use a single flexible base prompt that accepts policy variables. This template approach adapts easily to various contexts, significantly simplifying maintenance and evaluation. As new use


``` 
You are a call center agent. You are interacting with {{user_first_name}} who has been member for {{user_tenure}}. The user's most common complains are about {{user_complain_categories}}. Answer any questions the user may have
```

### Guardrails

Think of guardrails as a layered defense mechanism. While a single one is unlikely to provide sufficient protection, using multiple, specialized guardrails together creates more resilient agents.

* Ensures agent responses stay within the intended scope by flagging off-topic queries.  For example, “How tall is the Empire State Building?” is an off-topic user input and would be flagged as irrelevant.
* Detects unsafe inputs ( jailbreaks or prompt injections) that attempt to exploit system vulnerabilities. 
* Prevents unnecessary exposure of personally identifiable information (PII) by vetting model output for any potential PII.
* Flags harmful or inappropriate inputs (hate speech, harassment, violence) to maintain safe, respectful interactions.
* Assess the risk of each tool available to your agent by assigning a rating—low, medium, or high—based on factors like read-only vs. write access, reversibility, required account permissions, and financial impact. Use these risk ratings to trigger automated actions, such as pausing for guardrail checks before executing high-risk functions or escalating to a human if needed.
* Simple deterministic measures (blocklists, input length limits, regex filters) to prevent known threats like prohibited terms or SQL injections.
* Ensures responses align with brand values via prompt engineering and content checks, preventing outputs that could harm your brand’s integrity.


The Agents SDK treats guardrails as first-class concepts, relying on optimistic execution by default. Under this approach, the primary agent proactively generates outputs while guardrails run concurrently, triggering exceptions if constraints are breached.




Agent first task is planning. It will breakdown complex task into steps. 
Agent allows models to use tools and external data. 

### Agent use cases

* Analyze log and diagonse
  * analyze user's query and statement
  * use system log, monitoring, and knowledge base to analyze
* Generate test data base on dialogs
  * use natural language and knowledge base. 
  * Build atomic tools to cover core promotion, cart, order, fulfillment flows


### Building effective agents

Consistently, the most successful implementations weren't using complex frameworks or specialized libraries. Instead, they were building with simple, composable patterns.

When building applications with LLMs, we recommend finding the simplest solution possible, and only increasing complexity when needed. This might mean not building agentic systems at all. Agentic systems often trade latency and cost for better task performance,
 

When more complexity is warranted, workflows offer predictability and consistency for well-defined tasks, whereas agents are the better option when flexibility and model-driven decision-making are needed at scale. For many applications, however, optimizing single LLM calls with retrieval and in-context examples is usually enough.

We suggest that developers start by using LLM APIs directly: many patterns can be implemented in a few lines of code. If you do use a framework, ensure you understand the underlying code. Incorrect assumptions about what's under the hood are a common source of customer error.

Prioritize transparency by explicitly showing the agent’s planning steps.

Give the model enough tokens to "think" before it writes itself into a corner.
Keep the format close to what the model has seen naturally occurring in text on the internet.
Make sure there's no formatting "overhead" such as having to keep an accurate count of thousands of lines of code, or string-escaping any code it writes.

#### Workflow: Prompt chaining

You can add programmatic checks (see "gate” in the diagram below) on any intermediate steps to ensure that the process is still on track.

The main goal is to trade off latency for higher accuracy, by making each LLM call an easier task.

Examples where prompt chaining is useful:

Generating Marketing copy, then translating it into a different language.
Writing an outline of a document, checking that the outline meets certain criteria, then writing the document based on the outline.

#### Workflow: Routing

Directing different types of customer service queries (general questions, refund requests, technical support) into different downstream processes, prompts, and tools.
Routing easy/common questions to smaller models like Claude 3.5 Haiku and hard/unusual questions to more capable models like Claude 3.5 Sonnet to optimize cost and speed.


#### Workflow: Parallelization

Sectioning:
Implementing guardrails where one model instance processes user queries while another screens them for inappropriate content or requests. This tends to perform better than having the same LLM call handle both guardrails and the core response.
Automating evals for evaluating LLM performance, where each LLM call evaluates a different aspect of the model’s performance on a given prompt.
Voting:
Reviewing a piece of code for vulnerabilities, where several different prompts review and flag the code if they find a problem.
Evaluating whether a given piece of content is inappropriate, with multiple prompts evaluating different aspects or requiring different vote thresholds to balance false positives and negatives.


#### Workflow: Orchestrator-workers

a central LLM dynamically breaks down tasks, delegates them to worker LLMs, and synthesizes their results.

This workflow is well-suited for complex tasks where you can’t predict the subtasks needed (in coding, for example, the number of files that need to be changed and the nature of the change in each file likely depend on the task). Whereas it’s topographically similar, the key difference from parallelization is its flexibility—subtasks aren't pre-defined, but determined by the orchestrator based on the specific input.

Coding products that make complex changes to multiple files each time.
Search tasks that involve gathering and analyzing information from multiple sources for possible relevant information.

#### Workflow: Evaluator-optimizer

The two signs of good fit are, first, that LLM responses can be demonstrably improved when a human articulates their feedback; and second, that the LLM can provide such feedback. 

Literary translation where there are nuances that the translator LLM might not capture initially, but where an evaluator LLM can provide useful critiques.
Complex search tasks that require multiple rounds of searching and analysis to gather comprehensive information, where the evaluator decides whether further searches are warranted.

### Agents

The LLM will potentially operate for many turns, and you must have some level of trust in its decision-making. Agents' autonomy makes them ideal for scaling tasks in trusted environments.

The autonomous nature of agents means higher costs, and the potential for compounding errors. We recommend extensive testing in sandboxed environments, along with the appropriate guardrails.

Examples where agents are useful:
A coding Agent to resolve SWE-bench tasks, which involve edits to many files based on a task description;
Our “computer use” reference implementation, where Claude uses a computer to accomplish tasks.


#### Customer support

 This is a natural fit for more open-ended agents because:

Support interactions naturally follow a conversation flow while requiring access to external information and actions;
Tools can be integrated to pull customer data, order history, and knowledge base articles;
Actions such as issuing refunds or updating tickets can be handled programmatically; and
Success can be clearly measured through user-defined resolutions.

#### Coding agents

Code solutions are verifiable through automated tests;
Agents can iterate on solutions using test results as feedback;
The problem space is well-defined and structured; and
Output quality can be measured objectively.

While building our agent for SWE-bench, we actually spent more time optimizing our tools than the overall prompt. For example, we found that the model would make mistakes with tools using relative filepaths after the agent had moved out of the root directory. To fix this, we changed the tool to always require absolute filepaths—and we found that the model used this method flawlessly.




