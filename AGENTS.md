# AGENTS.md

Welcome to George's **Personal Knowledge Base (PKB)**. This document outlines guidance and operational heuristics for AI assistants and autonomous agents navigating, querying, and updating this repository.

---

## 🎯 Repository Purpose

This repository is an interconnected second brain focused on high-signal personal context, heuristics, and deep operational knowledge:
1. **Operating Heuristics & Work Style** (`how_to_use_me/`)
2. **AI & Agent Architecture Notes** (`ai/`)
3. **Data Mesh Practices** (`arch/data_mesh.md`)
4. **Japanese Workplace Language Practice** (`specific/jp/`)

---

## 🧠 Context Loading & Retrieval Strategy

- **Selective Ingestion**: Do not load the entire repository into context at once. Load only the specific domain notes relevant to the current query or task.
- **Root Index**: Always consult [README.md](README.md) to locate the canonical home for a topic.
- **Operating Decisions**: For any task involving architectural decisions, trade-offs, tech evaluation, or team collaboration, check [how_to_use_me/](how_to_use_me/) first.
- **Technical Deep Dives**:
  - For Japanese workplace-message practice: look in [specific/jp/](specific/jp/). Keep the interaction Japanese-first; do not translate into English unless explicitly asked.
  - For data-product discovery, governance, and cross-domain access: look in [arch/data_mesh.md](arch/data_mesh.md).
  - For agent design, evals, and RAG architectures: look in [ai/](ai/).

---

## ✍️ Editing & Contribution Rules

1. **Preserve Concrete Heuristics**: Do not replace battle-tested, concrete rules or specific trade-offs with generic textbook explanations or corporate buzzwords.
2. **Prioritize the 'Why' & Failure Modes**: Focus on rationale, edge cases, trade-offs, and operational realities.
3. **High Signal Context**: Do not re-introduce generic textbook summaries (e.g., generic language tutorials or basic algorithm explanations) that foundation models already know.
4. **Maintain Topic Boundaries**: Keep notes modular and aligned with the directory structure. When creating or moving documents, update relevant directory indexes or [README.md](README.md).
5. **Markdown & Link Hygiene**: Use standard GitHub-flavored Markdown with valid relative links between documents.
