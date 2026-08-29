# AI & Agent Systems

> Engineering mental models, architectural patterns, evaluation frameworks, and operational heuristics for LLM-powered applications and agentic systems.

---

## 📑 Domain Index

| Topic | Document | Summary |
| :--- | :--- | :--- |
| **Agent Orchestration** | [`agent.md`](agent.md) | Agent loops vs. deterministic workflows, orchestrator-worker patterns, evaluator-optimizer loops, and agent lifecycle hooks (`PreReasoning`, `PreToolCall`, `PostToolCall`, etc.). |
| **Agent Skills & Tools** | [`skills.md`](skills.md) | Designing agent skills, triggering heuristics, scope definition, excuse-denial techniques, tool whitelisting, and comparative token/quality evaluation. |
| **Evaluation Frameworks** | [`eval.md`](eval.md) | LLM and agent evaluation strategies, assertion design, deterministic vs. model-graded evaluators, and benchmark curation. |
| **Evaluation Harness** | [`harness.md`](harness.md) | Test harnesses, test runners, execution environments, and replay mechanisms for agent verification. |
| **RAG & Retrieval** | [`rag.md`](rag.md) | Retrieval-Augmented Generation architectures, chunking strategies, embedding retrieval, and context synthesis. |
| **Metadata & Telemetry** | [`metadata.md`](metadata.md) | Tracking state, token consumption, provenance, and structured metadata across LLM interactions. |
| **Miscellaneous AI Notes** | [`misc.md`](misc.md) | General observations, emergent agent behaviors, and quick references. |

---

## 💡 Key Heuristics

- **Workflows vs. Agents**: Default to deterministic workflows (`orchestrator-workers`, `evaluator-optimizer`) for predictable tasks; escalate to autonomous agent loops only when dynamic planning and model-driven tool dispatching are strictly required.
- **Skill Design**: Focus on the *why* and *when to trigger* rather than redundant step-by-step regurgitation. Explicitly specify forbidden patterns and denial of agent excuses.
- **Tool Scoping**: Enforce minimal tool whitelisting; avoid giving general-purpose execution tools (e.g. unconstrained HTTP clients) when specialized, scoped interfaces suffice.
- **Team Operating Context**: See [`how_to_use_me/llms.md`](../how_to_use_me/llms.md) for George's organizational stance on fine-tuning vs. RAG, internal design docs for LLMs, and code accountability.
