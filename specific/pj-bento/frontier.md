---
type: project-current
project: pj-bento
status: active
---

# PJ Bento: Learning Frontier & Operational Hub

This document is the live operational hub for the active learning edge (what is not stable + what to learn & next actions).
- For confirmed stable workplace phrases: see [phrases.md](phrases.md).
- For pattern syntax and usage notes: see [grammar.md](grammar.md).

---

## 🎯 Operating Heuristics & Tutoring Protocol

### Core Heuristics & Register
- **Context & Goal**: Workplace trust and friction reduction at a Japanese tech company. The target register is **Staff-level Architect**: direct, accountable, and collegial—never managerial-pushy or overly ceremonial.
- **Register Ceiling**: Direct assertive N3 (`〜します`、`〜して`、`〜しますので`). Avoid humble corporate loops (`〜したく存じます`、`〜させていただければ幸いです`).
- **Objective Framing**: Avoid personal hesitation (`判断に迷っています`); prefer objective deficiency and recommendation framing (`判断材料が不足しています`、`私としては、この進め方がよいと思います`).
- **Non-Katakana Preference**: Prefer natural Japanese technical wording over katakana defaults when available (e.g., `必要なら上長に相談します` instead of `エスカレーションします`).
- **Alignment Over Authority**: Prefer schedule synchronization and mutual unblocking (`他開発部署と歩調を合わせ、円滑な移行を実現します`) over pushing other teams.

### 20-Minute Chunk Protocol
- **Default Planning Unit**: Run practice in `20-minute` focused blocks:
  - `0:00–3:00` Fast recall from memory (warm-up / rescue set).
  - `3:00–10:00` One narrow target (drilling the live frontier).
  - `10:00–14:00` Contrast / correction loop (targeting hard points).
  - `14:00–18:00` Mini role-play, rapid response, or shadowing.
  - `18:00–20:00` Final output from memory and closing summary.
- **Interaction Style**: Japanese-first. Japanese drives drills, prompts, role-play, and summaries. English is reserved for brief explanations and corrections.
- **Pacing**: Give one task at a time; 3 prompts max at once.
- **Voice-Input Tolerance**: Ignore Mac IME / kanji / okurigana artifacts when the intended spoken utterance is clear. Prioritize spoken grammar, word choice, delivery naturalness, and speed over orthographic perfection.
- **No Katakana Drilling**: Do not drill katakana pronunciation; meaning recognition is sufficient.

---

## 🟡 2. What is Not Stable (現在の課題・要修正)

Recurring corrections from practice. Use this section to seed review drills and catch regression under speaking pressure.

### Particle Errors

| Error | Correct | Note |
| :--- | :--- | :--- |
| `原因を分かっていません` | `原因が分かっていません` | `分かる` takes `が` |
| `設定は原因の可能性があります` | `設定が原因の可能性があります` | `が` marks the possible cause |
| `この内容が誰が担当ですか` | `この内容は誰が担当ですか` | Topic particle `は` |
| `誰が聞けばいいですか` | `誰に聞けばいいですか` | Target takes `に` |
| `合っている方針に` | `既存の方針に合っている` | `合う` takes `に` |
| `技術戦略則り` | `技術戦略に則り` | Keep `に` |

### Verb Form Errors

| Error | Correct | Note |
| :--- | :--- | :--- |
| `終わってたら連絡します` | `終わったら連絡します` | Past conditional (`〜たら`), not progressive |
| `確認してたら返事します` | `確認してから返事します` | Sequence (`〜てから`), not progressive |
| `聞きてみます` | `聞いてみます` | `聞く` → `聞いて` |
| `分かりたら共有します` | `分かったら共有します` | `分かる` → `分かったら` |
| `問題が見つけていません` | `問題は見つかっていません` | `見つかる` is intransitive |

### Structural / Nuance Errors

| Error | Correct | Note |
| :--- | :--- | :--- |
| `相談していいですか` | `相談してもいいですか` | Keep `も` in permission pattern |
| `相談さしてください` | `相談させてください` | Keep `て` before `ください` |
| `進めを相談させてください` | `進め方を相談させてください` | `進め方` = how to proceed (`方` forms the noun) |
| `手戻りが少ない` misread | `手戻りが少ない` = few rework steps | `少ない` = few/little (not a negative verb) |
| Parallel reason break | `影響範囲が小さいことと、後から変更しやすいことです。` | Keep reasons parallel with `〜ことと、〜ことです` |
| `理由が二つあります` | `理由は二つあります` | `は` preferred in recommendation pattern |
| `〜の観点から` misapplied | Objective criterion framing | Use to defend architectural choices, not personal taste |
| `変更しやすい` as noun | `変更しやすいこと` | Nominalize with `こと` |

### Live Execution Hurdles Under Pressure
- **`堅牢性` Pacing & Articulation**: Pronunciation and delivery speed still drop during long sentences (`影響範囲を特定した上で、保守性の観点から、システムの堅牢性を担保します`). Drill inside full sentences.
- **Speed Under Interruption**: Freezing or hesitating when a reply or clarification is needed instantly.
- **Compound Chain Stability**: Maintaining N3 assertive grammar across 3+ clauses without reverting to English scaffolding.
  - Chain A: Trade-off → Alignment → Risk containment → Architectural justification.
  - Chain B: Operational guardrails → Post-mortem remediation → Modernization / deprecation.

### Banned Fallback Habits (Retired Anchors)
Do **not** drill or fall back to these retired patterns. Replace immediately with specific verbs:

| Retired / Banned Pattern | Preferred Replacement |
| :--- | :--- |
| `把握しました` / `現状を認識しております` | `分かりました` / `理解しました` / `〜という理解で合っていますか` |
| 汎用の `進めます` / `対応します` | Specific verbs: `調整します` / `検討します` / `反映します` / `修正します` / `行います` / `見てみます` / `調べてみます` |
| `〇〇の件` / `第一案` / `第二案` | `この進め方` / `この方針` / `一時的な代替案` |
| `〜次第` | `〜たら` / `〜てから` (`分かったら共有します` / `確認してから返事します`) |
| Humble corporate loops (`〜したく存じます` / `〜させていただければ幸いです`) | Assertive N3: `〜します` / `〜させてください` / `ご意見をいただけますか` |

---

## 🔵 3. What to Learn & Next Actions (次の一手・学習対象)

### Immediate Target Sentences (Learning Frontier)
- **Primary Goal**: Produce this strategy-aligned external-product evaluation chain cleanly from memory:
  > `技術戦略に則り、他開発部署と歩調を合わせ、外部製品の導入を検討して、費用対効果を見極めます。`
- **Building blocks**:
  - `技術戦略に則り、`
  - `他開発部署と歩調を合わせ、円滑な移行を実現します。`
  - `外部製品の導入を検討して、`
  - `費用対効果を見極めます。`

### Workplace-Policy Grammar in Flight
Actively promote these patterns from isolated recognition to fluent compound spoken output:
- `〜への`、`〜にかかわらず`、`〜なしで`、`〜のうえ`、`速やかに`、`もしくは`、`〜の中でも`、`〜べき`、`〜であったため`
- **Target Compound Output**:
  > `承認の有無にかかわらず、変更内容を確認のうえ、速やかに関係各所へ共有すべきです。`

### Strategic Decisions & Setup
1. **Choose Dominant Pain Context**: Decide whether to focus drills primarily on **Meetings**, **1:1s**, or **Casual office chat** to specialize future role-play scenarios.
2. **Shadowing Resources**: Select 2–3 transcript-backed listening sources featuring natural-speed Japanese workplace dialogue.

### Concrete Practice Drills for Upcoming Sessions
1. **Policy Grammar Rapid Recall**: Drill short 2-clause sentences combining `〜にかかわらず`, `〜のうえ`, and `速やかに` from memory.
2. **`堅牢性` Full-Sentence Drill**: Repeat `保守性の観点から、システムの堅牢性を担保します` with natural rhythm and speed.
3. **Staff Chain Endurance**: Deliver the full 4-stage chain without pausing or falling back to banned anchors:
   - `私としては、この進め方がよいと思います。理由は二つあります。影響範囲が小さいことと、後から変更しやすいことです。`
   - `関係各所と連携して、工程をすり合わせて、開発の停滞を防ぎます。`
   - `計画に支障をきたす恐れがあります。事前に対策を講じます。影響範囲を特定して、影響を最小限に抑えます。`
   - `影響範囲を特定した上で、保守性の観点から、システムの堅牢性を担保します。`

---

## 🟢 Quick Reference: Emergency Rescue Set

Always available as a safety net during live workplace interactions:
- `もう一度お願いします。` (Could you say that once more?)
- `少しゆっくりお願いします。` (A little slower, please.)
- `ちょっと分かりませんでした。` (I didn't quite catch that.)
- `もう少し詳しくお願いします。` (Could you provide a bit more detail?)
- `確認してもいいですか。` (May I confirm?)
- `〜ということですか。` (Does that mean ~?)
- `〜という理解で合っていますか。` (Is my understanding correct?)
- `私の理解では、〜です。` (In my understanding, ~.)
- Quick reactions: `分かりました`、`なるほど`、`そうですね`、`たしかに`、`失礼します`

*(For the complete categorized active phrase bank, see [phrases.md](phrases.md))*
