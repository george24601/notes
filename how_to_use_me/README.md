# Project: How To Use Me (George's Operating System)

> A personal working-style guide and decision-making framework designed to align expectations, empower decentralized tie-breaking, and provide an interactive persona context for AI assistants.

---

## 🎯 Purpose & Motivation

Trade-offs often have multiple valid answers. This project establishes an objective, prescriptive framework so collaborators can:
- **Break ties locally** without contradicting strategic intent.
- **Align on expectations** across communication, project ownership, design reviews, and meetings.
- **Feed directly into an LLM** to test proposals, prepare 1:1 agendas, and simulate George's review feedback.

---

## 🤖 Feeding this Project into an LLM

You can provide this context to any LLM (ChatGPT, Claude, Cursor, Antigravity, NotebookLM, Gemini) to simulate George's review or pressure-test technical proposals.

### Option A: Upload the Compiled Guide
Upload or copy-paste [`FULL_GUIDE.md`](FULL_GUIDE.md) (contains the entire operating framework in one document).

### Option B: Prompt Templates for Collaborators

#### 🔍 1. Pre-Review a Proposal / Architecture Doc
```text
You are acting as George, a senior engineering leader with the operating heuristics in `FULL_GUIDE.md`. 
I am going to share a proposal / design document with you. 

Critique my proposal based on your decision framework:
1. What missing assumptions, prior probabilities, or non-goals would George push on?
2. Is this proposal leaning into premature abstraction/scaling, or choosing an unpaved road without an off-ramp?
3. What is the cheapest experiment or 80/20 paved-road alternative George would suggest?
4. What questions will George ask in our design review?

Here is my proposal:
[INSERT PROPOSAL HERE]
```

#### ⏱️ 2. Prepare a 15-Minute 1:1 Agenda
```text
Based on George's operating manual in `FULL_GUIDE.md`, help me organize my thoughts for an upcoming 15-minute sync with George.
Here is the current situation / dilemma I am facing:
[INSERT SITUATION HERE]

Help me:
1. Frame the trade-offs objectively (speed vs scalability, reversible vs one-way-door, blast radius).
2. Formulate 2-3 specific, high-leverage decision questions to resolve during our meeting.
```

#### 🛡️ 3. Self-Assess Reversible Changes & Blast Radius
```text
Based on George's criteria for reversible changes (< 1 week to undo, no SEV-2 risk, internal blast radius only):
Evaluate whether the following change requires full stakeholder sign-off or if I should feel empowered to proceed immediately:
[INSERT CHANGE DETAILS HERE]
```

---

## 📑 Modular Sections

If you prefer to read or ingest individual topic files:

| Section | Focus |
| :--- | :--- |
| [`work_and_decisions.md`](work_and_decisions.md) | Scenario-based trade-offs, speed vs. scalability, build vs. buy, estimates as distributions, reversible changes, and blast radius. |
| [`decision_making.md`](decision_making.md) | Decision hierarchy, project roles (Consulting, Sponsoring, Owning), RFD/ERD standards, and technical debate facilitation. |
| [`communication.md`](communication.md) | Channel routing, message SLAs, positive framing, and "first-guess" questioning style. |
| [`collaboration.md`](collaboration.md) | Working hours, 30-min meeting rules, PR review guidelines (<200 lines, >80% test coverage), and radical candor. |
| [`technology_philosophy.md`](technology_philosophy.md) | Tech debt taxonomy (Type 1 repayment plans, Type 2/3 RCA triggers), paved roads, and stack preferences. |
| [`rca_and_quality.md`](rca_and_quality.md) | Blameless post-mortem philosophy, 3-day turnaround, and >=50% long-term systemic action items. |
| [`llms.md`](llms.md) | Practical stance on LLMs: workflows over complex agents, evals over SFT, and design-doc accountability. |
| [`building_trust.md`](building_trust.md) | How George builds trust across engineering, product, and management partners over time. |
