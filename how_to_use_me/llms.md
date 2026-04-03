# Working with LLMs

### SFT our own LLM model

At this moment I prefer we use SFT only as the last resort, because
* We experienced catastrophic forgetting with SFT model in the past
* Once a new model is out every 6 months, we have to re-do the SFT
* Industry study shows that >70% of LLM quality issue can be mitigated by lower lift options, such as RAG or contextual engineering

At this moment, I feel the priority is to add the company's evals for LLMs

### PMF for LLMs
At this moment, LLM-powered products are best fitted for internal tools and workflows. In most cases, I feel a LLM powered workflow is good enough. An single agent system is likely overkill, and a multi-agent system is almost always an overkill

### Code from LLM
Treat LLM as a genius intern. The engs are still accountable for the LLM generated code, and code should be reviewed as if produced by human, because LLM often gives bad code because of lack of internal context.
For production features, come up with an internal design doc for LLM. This internal design doc should include which components will be added/modified, and which internal libraries could be used in the place of external libraries. This internal design doc should be reviewed and committed first, and then fed into LLM to generate the actual code.
