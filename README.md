# Personal Knowledge Base (PKB)

> A high-signal personal knowledge base and second brain capturing engineering mental models, agent systems architecture, practical data-mesh patterns, Japanese workplace-language practice, and personal operating heuristics.

---

## 🧭 Overview & Design Philosophy

This repository is organized as an **AI-native Personal Knowledge Base (PKB)** focused strictly on **high-leverage, proprietary context** that general-purpose foundation models lack:
1. **Operating Heuristics & Work Style**: George's mental models, trade-off evaluation matrices, decision-making frameworks, and collaboration expectations.
2. **AI & Agent Systems**: Agent orchestration paradigms, evaluation harness patterns, RAG pipelines, and agent skill engineering.
3. **Data Mesh**: Practical discovery, interoperability, governance, and in-place consumption patterns.
4. **Japanese Workplace Language**: Japanese-first practice for messages encountered at a Japanese internet company.

---

## 🗂️ Knowledge Taxonomy

| Domain | Directory | Focus & Key Contents |
| :--- | :--- | :--- |
| **🧠 Operating Heuristics** | [`how_to_use_me/`](how_to_use_me/) | Working style, trade-off evaluation, decision-making frameworks, communication, LLM philosophy, RCA expectations, and trust building. |
| **🤖 AI & Agent Systems** | [`ai/`](ai/) | Agent orchestration patterns, evaluation frameworks, harness design, RAG pipelines, and agent skills. |
| **🏛️ Data Mesh** | [`arch/data_mesh.md`](arch/data_mesh.md) | Data-product discovery, metadata, governance, quality, and in-place access controls. |
| **🇯🇵 Japanese Workplace Language** | [`specific/jp/`](specific/jp/) | Japanese-first practice for understanding and replying to workplace messages. |

---

## 🤖 Interacting with AI Agents

When using this knowledge base with LLMs and AI coding assistants:

### 1. Proposal & Decision Evaluation
Feed the relevant sections from [`how_to_use_me/`](how_to_use_me/) alongside your technical proposal and ask:
```text
"Based on George's operating heuristics in how_to_use_me/, what questions, trade-off challenges, or risks would George likely raise regarding this proposal?"
```

### 2. Architecture & Systems Grounding
When designing data-product discovery, governance, or cross-domain consumption, query [`arch/data_mesh.md`](arch/data_mesh.md). For Japanese workplace-message practice, query [`specific/jp/`](specific/jp/).

### 3. Agent Navigation Guidelines
See [`AGENTS.md`](AGENTS.md) at the repository root for explicit subagent loading strategies, editing rules, and topic boundaries.

---

## 📝 Maintenance & Contribution Heuristics

- **High-Signal Context Only**: Focus on personal heuristics, nuanced trade-offs, and operational lessons. Avoid storing generic textbook definitions that pre-trained LLMs already know.
- **Preserve Operating Intent**: When refining notes, maintain concrete heuristics, failure modes, and real-world trade-offs rather than abstract summaries.
- **Cross-Link Freely**: Link related notes across architecture and specific technologies to build an interconnected knowledge graph.
