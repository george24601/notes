# Personal Knowledge Base (PKB)

> A high-signal personal knowledge base and second brain capturing engineering mental models, agent systems architecture, practical data-mesh patterns, BJT preparation, and personal operating heuristics.

---

## 🧭 Overview & Design Philosophy

This repository is organized as an **AI-native Personal Knowledge Base (PKB)** focused strictly on **high-leverage, proprietary context** that general-purpose foundation models lack:
1. **Operating Heuristics & Work Style**: George's mental models, trade-off evaluation matrices, decision-making frameworks, and collaboration expectations.
2. **AI & Agent Systems**: Agent orchestration paradigms, evaluation harness patterns, RAG pipelines, and agent skill engineering.
3. **Data Mesh**: Practical discovery, interoperability, governance, and in-place consumption patterns.
4. **Business Japanese / BJT**: Readiness-based preparation for BJT 400 and the associated 10 Highly Skilled Professional points, with workplace comprehension as a secondary benefit.

---

## 🗂️ Knowledge Taxonomy

| Domain | Directory | Focus & Key Contents |
| :--- | :--- | :--- |
| **🧠 Operating Heuristics** | [`how_to_use_me/`](how_to_use_me/) | Working style, trade-off evaluation, decision-making frameworks, communication, LLM philosophy, RCA expectations, and trust building. |
| **🤖 AI & Agent Systems** | [`ai/`](ai/) | Agent orchestration patterns, evaluation frameworks, harness design, RAG pipelines, and agent skills. |
| **🏛️ Data Mesh** | [`arch/data_mesh.md`](arch/data_mesh.md) | Data-product discovery, metadata, governance, quality, and in-place access controls. |
| **🇯🇵 Business Japanese / BJT** | [`specific/pj-bento/`](specific/pj-bento/) | BJT 400 as the immigration-points north star, supported by adaptive listening, listening-reading, and reading practice. |

---

## 🤖 Interacting with AI Agents

When using this knowledge base with LLMs and AI coding assistants:

### 1. Proposal & Decision Evaluation
Feed the relevant sections from [`how_to_use_me/`](how_to_use_me/) alongside your technical proposal and ask:
```text
"Based on George's operating heuristics in how_to_use_me/, what questions, trade-off challenges, or risks would George likely raise regarding this proposal?"
```

### 2. Architecture & Systems Grounding
When designing data-product discovery, governance, or cross-domain consumption, query [`arch/data_mesh.md`](arch/data_mesh.md). For BJT preparation and Japanese workplace-language practice, query [`specific/pj-bento/`](specific/pj-bento/).

### 3. Agent Navigation Guidelines
See [`AGENTS.md`](AGENTS.md) at the repository root for explicit subagent loading strategies, editing rules, and topic boundaries.

---

## 📝 Maintenance & Contribution Heuristics

- **High-Signal Context Only**: Focus on personal heuristics, nuanced trade-offs, and operational lessons. Avoid storing generic textbook definitions that pre-trained LLMs already know.
- **Preserve Operating Intent**: When refining notes, maintain concrete heuristics, failure modes, and real-world trade-offs rather than abstract summaries.
- **Cross-Link Freely**: Link related notes across architecture and specific technologies to build an interconnected knowledge graph.
