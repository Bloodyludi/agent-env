---
name: lean-plan
description: Use to clarify a goal, compare approaches, agree on a specification, and create an actionable plan for software or non-software projects. Uses concise, interactive discovery and planning.
---

# Lean Plan

Shape the _right outcome_ with the user before planning how to achieve it. Use interactive discovery, alternatives, specification approval, and execution handoff; scale the process to the stakes. This skill is **on demand**, not a rule to invoke for every request.

## 0. Choose the depth

- **Clear, small request:** Act or give a short plan. Do not invent questions, alternatives, or approval gates.
- **Uncertain goal or consequential choice:** Discover → compare approaches → agree on a specification → plan.
- **Existing approved specification:** Skip discovery and approach selection; make the plan.
- **User asks to proceed with assumptions:** State only consequential assumptions and proceed; don't force a workshop.
- **Exploratory spike:** If a low-cost example, prototype, outline, or quick investigation would resolve uncertainty, propose it. Keep it disposable; don't treat it as approval for the full project.

Follow the user's requested scope: a request to _plan_ is not permission to execute.

## 1. Discover what matters

1. **Look first.** Review the request, earlier decisions, supplied references, existing materials, and relevant current state. Don't ask questions already answered there.
2. **Reflect the intent.** Briefly summarize the desired outcome, audience or beneficiaries, purpose, and important known constraints; invite correction.
3. **Resolve consequential unknowns, one at a time.** Prefer one specific, open question per turn. Explain its significance when non-obvious. If the user is stuck, offer a few concrete options with a recommendation. Stop asking when reasonable decisions can be made without them.
4. **Explore the relevant dimensions, not a checklist:** what success looks like; non-goals and unwanted outcomes; scope; available people, resources and materials; budget, time, quality, format, policies, risks, dependencies, and existing precedents.
5. **Separate evidence, decisions, and assumptions.** Don't present your own defaults as user-approved decisions. Point out important conflicts or constraints early, and ask for guidance before costly detours.

Keep conversation natural and concise. Avoid lengthy questionnaires, repetitive summaries, and unnecessary research. When outside investigation could materially change the decision, propose a focused lookup rather than broad research by default.

## 2. Compare approaches before choosing one

When there are meaningful alternatives, show **two or three viable approaches** with their principal benefits, costs, risks, and trade-offs. Recommend one based on the stated priorities, then ask the user to choose or adjust it. Do this **before** committing to a specification or detailed tasks.

If one approach is clearly best, say why and continue without manufacturing alternatives. Use small illustrative examples or visual comparisons only when they materially improve understanding.

## 3. Agree on a specification

Play back the intended result in **domain-neutral, testable terms**. Cover only what is relevant:

- **Intent:** Why this is needed; who or what benefits.
- **Outcome and boundaries:** What will be delivered; what is explicitly out of scope or unacceptable.
- **Success criteria:** Observable evidence that the result meets expectations (examples, metrics, review criteria, or tests as appropriate).
- **Constraints:** Time, budget, resources, standards, compatibility, privacy, or other hard limits.
- **Chosen approach:** Important decisions and why; unresolved assumptions and material risks.

For substantial projects, present the specification in **short, reviewable chunks**, asking what is wrong or missing after each meaningful section. For smaller work, one compact specification is enough. Mark user-confirmed decisions separately from recommendations.

**Agreement gate:** Before making a substantial or hard-to-reverse commitment, get explicit approval of the consequential specification or approach. If the user has already approved it, or asked to skip discussion and proceed with reasonable defaults, don't ask for approval twice. Never infer approval from silence.

## 4. Turn the specification into an executable plan

Create a plan a capable person or agent **unfamiliar with the conversation** could follow without guessing about the important decisions. Prefer **3–7 outcome-focused tasks** (fewer for small efforts; phases for larger programs).

For each task, include only what's needed to execute it:

- **Deliverable:** Specific result, not vague activity.
- **Inputs and constraints:** Decisions, references, resources, or exact requirements that cannot be safely invented.
- **Dependencies:** What must precede it; what can proceed in parallel.
- **Verification:** Observable completion check, review criterion, evidence, or test.
- **Owner or timing:** Only when coordination requires it.

**For software features, fixes, behavior changes, and refactoring:** Make the plan test-first. Identify the behavior being added or preserved, the first failing test (or characterization/regression test where appropriate), its expected failure, the minimal implementation, and the test command. Express each software task as **RED → GREEN → REFACTOR → VERIFY**. Don't plan to add all tests after implementing code. Keep tasks outcome-sized, not one task per test step.

Specify concrete interfaces, paths, commands, dates, or quantities **only when the domain and known facts warrant them**. Don't turn the plan into a transcript of implementation. Fold setup and documentation into the outcome they enable, unless independently valuable.

Self-check once: Does every requirement map to a deliverable or check? Are dependencies feasible? Would a new executor understand the intended result? Are consequential decisions still unresolved? Fix gaps in place; don't initiate an automatic review loop.

## 5. Software implementation: TDD is mandatory

Apply this section **only when implementing software** (new functionality, bug fixes, behavior changes, or refactoring). For research, writing, operations, events, and other non-software projects, use the domain's appropriate verification instead. Planning a software project must include the TDD steps, but does not authorize implementation.

Follow this **test-driven development** cycle for each independently testable behavior:

1. **RED — write a minimal behavior-focused test first.** Run it and confirm it **fails for the intended missing behavior**, not a syntax error, broken fixture, or unrelated failure. For bugs, reproduce the bug in a failing regression test. For refactoring, establish protection for relevant existing behavior and identify the test-first change before altering production behavior.
2. **GREEN — implement only enough production code to pass.** Run the focused test; fix code rather than weakening a legitimate expectation. Keep the change in scope.
3. **REFACTOR — improve structure only after green.** Rerun tests and keep them passing. Avoid speculative abstractions and unrelated cleanup.
4. **VERIFY — run the relevant broader/project test suite before completion.** Report exact failures and unverified areas. Never claim a test was run when it wasn't.

**No production implementation before a verified failing test.** If code was written prematurely, return to a genuine failing-test-first cycle rather than retrofitting passing tests and calling it TDD. Prefer meaningful tests of observable behavior, not mock interactions or implementation details.

**Exceptions require user approval** for throwaway spikes/prototypes, generated code, or configuration-only changes. If a failing automated test is genuinely infeasible, disclose why and agree on an alternative verification method before implementation. Never silently relax TDD to save time.

These TDD rules are self-contained. Include them explicitly in delegated software implementation tasks; do not apply them to non-software work.

## 6. Handoff, execute, and adapt

- **Present the specification and plan in chat by default.** Save at most one concise handoff artifact when requested or genuinely necessary for durable, cross-session or multi-person execution. Never create mandatory design docs, plan files, status reports, or ceremonial approval artifacts.
- If the user requested **planning only**, stop with the plan and any decision requiring their input. If execution was requested and the significant choices are approved, proceed without another redundant permission request; seek authorization for externally consequential or irreversible actions.
- For delegation (Paseo, OMP, or another environment), assign **only genuinely separable tasks**. Give each worker a short brief: outcome, constraints, relevant context, dependencies, and acceptance evidence. **For software workers, explicitly include the RED → GREEN → REFACTOR → VERIFY requirement and test evidence**, since workers may not inherit this skill. Avoid nested planning and automatic reviewer fleets.
- While executing, provide **brief milestone updates** and flag blockers promptly with a proposed way forward. Ask early when the user's choice is more valuable than further speculative work; continue independent tasks when safe.
- Verify results proportionately to risk (without weakening mandatory software TDD). If new evidence changes a material assumption or the goal, revisit **only the affected part** of the specification and plan.

## Suggested presentation (adapt, don't rigidly fill in blanks)

**Specification:** Goal · Success criteria · Scope and exclusions · Constraints · Chosen approach · Open decisions (if any).

**Plan:** Numbered deliverables with dependencies and how to verify each. Call out parallel tasks only if genuinely independent.

**Next decision:** One specific question **only if needed**; otherwise give the recommended next step.

## Style and efficiency

- Ask **one substantive question at a time** when discussing an ambiguous objective.
- Keep explanations proportional to the decision's importance. Default to concise summaries, not essays.
- Avoid software-specific assumptions: a verification may be a rehearsal, stakeholder sign-off, measured result, factual check, checklist, test, or inspection.
- Software development follows mandatory test-first RED → GREEN → REFACTOR → VERIFY, with explicit exceptions requiring approval. Other domains use appropriate verification. No compulsory Git worktrees, code review fleets, fixed microtasks, separate agents, or saved Markdown files.
- Preserve the user's agency over priorities and trade-offs; recommend clearly rather than delegating every minor choice back to them.
