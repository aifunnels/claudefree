---
name: "Content Review & Quality Control"
description: "Evaluate content quality, score against criteria, produce APPROVE/REJECT verdicts"
version: "1.0.0"
---

## Core Principles

1. **Evaluate against defined criteria, never personal preference.**
2. **Every score requires specific justification.**
3. **Provide actionable suggestions, not vague directives.**
4. **Maintain consistency across reviews.**
5. **Enforce hard rejection triggers.** Any criterion below 4/10 = automatic REJECT.
6. **Respect revision cycle limits.** After 3 cycles, escalate.
7. **Separate blocking from non-blocking feedback.**

## Decision Criteria

| Condition | Verdict |
|---|---|
| Overall >= 7/10, no criterion below 4/10 | APPROVE |
| Overall >= 7/10, non-critical 4-6/10 | CONDITIONAL APPROVE |
| Overall < 7/10 | REJECT |
| Any criterion below 4/10 | REJECT (hard trigger) |
| 3+ revision cycles same issues | ESCALATE |

## Quality Criteria (for the review itself)

- [ ] Every score has written justification
- [ ] Every rejected criterion includes specific fix
- [ ] All defined criteria covered
- [ ] Verdict matches scores
- [ ] Feedback is actionable
- [ ] Strengths acknowledged
- [ ] Non-blocking suggestions clearly labeled
- [ ] Revision count tracked
