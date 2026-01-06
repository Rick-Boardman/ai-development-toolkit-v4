# Session Notes — ADT v4 Kickoff

**Date**: 2026-01-05

## Context

This session started from the existing ADT v3 repo and evolved into creating and publishing a new ADT v4 repo.

Key themes:

- v1/v2 concepts are less necessary as models improved, but structured project memory is still valuable.
- v3 worked well but required too much manual prompting ("review/update the ADT") and had friction in where project context lived.
- The toolkit is primarily for AI-human (and AI-AI) collaboration: it should reduce repeated mistakes within a long session and provide a clear bridge between human intent and agent execution.

---

## Major Decisions

### 1) Split the toolkit from project memory

**Decision**: The toolkit should not contain project-specific state. Instead:

- `.adt/` = the toolkit (protocol + templates), installed as a **git submodule**.
- `.adt-context/` = the consuming project’s **committed memory**, copied from a template.

**Rationale**:

- Project context should live with the project and be committed.
- The toolkit should be updateable independently (submodule pointer updates).
- This reduces the “update pain” and prevents accidental overwrites of project-specific context.

### 2) Remove queue-health thresholds and PowerShell scripts

**Decision**: Remove the v3 “queue health” concept and the `.ps1` automation scripts.

**Rationale**:

- Numeric backlog thresholds tend to incentivize filler tasks.
- The approach created more overhead than value.
- Cross-platform and execution-policy friction is avoidable.
- Modern models can follow a protocol without a script enforcing it.

### 3) Introduce a Now / Backlog / Log model

**Decision**: Replace the v3 tasks/status heavy approach with a simpler “working set + backlog + append-only history” model.

**Rationale**:

- Status/tasks were getting too large and noisy.
- The working set should stay tiny and actionable.
- Completed items should age out of the working set into a log.

### 4) Add an attempt ledger to prevent repeated command errors

**Decision**: Add a first-class attempts log (`attempts.md`).

**Rationale**:

- A common failure mode is repeating the same terminal mistakes within one session.
- Logging the exact command + error + hypothesis reduces repeated “trial-and-error loops”.
- This is distinct from an issue tracker; it’s session-level execution memory.

### 5) Add a human “pause button” via `interrupt.md`

**Decision**: Add `interrupt.md` and require agents to check it at defined checkpoints.

**Rationale**:

- Long vibe-coding sessions can run too far without human input.
- VS Code’s historical pause UX was useful; this recreates that control with a file-based protocol.
- The model can’t truly “watch” files continuously, so checkpoints are required.

### 6) Add a `.scratchpad/` convention

**Decision**: Encourage temporary scripts/debug helpers to go in `.scratchpad/` (gitignored in consuming projects).

**Rationale**:

- AI sessions often generate run-once scripts and probes.
- Without a convention, repos get cluttered.
- `.scratchpad/` provides a clear, disposable place for ephemeral artifacts.

### 7) Make activation energy lower with a strong Copilot snippet

**Decision**: Provide a ready-to-paste snippet for `.github/copilot-instructions.md` that forces the agent to read `.adt/INSTRUCTIONS.md` and `.adt-context/`.

**Rationale**:

- Even good protocols get skipped unless the entrypoint is explicit and prominent.
- A consistent snippet increases adoption quality.

### 8) Feedback loop to upstream (toolkit / GitHub)

**Decision**: Project-specific mistakes should live in `.adt-context/common-pitfalls.md`. Generalizable improvements should be proposed upstream.

**Rationale**:

- Local fixes reduce repetition immediately.
- Generalizable fixes keep the toolkit relevant over time (v4 → v5 etc.).
- With explicit user consent, the agent can draft (and later potentially create) GitHub issues with examples.

---

## Implementation Outcomes (What We Built in v4)

### New repo created + published

- Created a new repo with **fresh history**: `Rick-Boardman/ai-development-toolkit-v4`
- Used GitHub CLI (`gh`) and your authenticated credentials.

### New structure

Toolkit now contains:

- `INSTRUCTIONS.md` — v4 protocol emphasizing:
  - required reads from `.adt-context/`
  - interrupt checkpoints
  - attempts logging (“don’t repeat errors” rule)
  - scratchpad convention
- `context-template/` — template copied into consuming projects as `.adt-context/`:
  - `README.md` (context snapshot)
  - `now.md` (1–5 current tasks)
  - `backlog.md` (future work)
  - `log.md` (append-only done/events)
  - `attempts.md` (commands tried + outcomes)
  - `common-pitfalls.md` (sticky gotchas)
  - `interrupt.md` (pause button)
  - `decisions.md` (decisions w/ rationale)
  - `agents.md` and `work-partitions.md` (optional multi-agent coordination)

Removed from v4:

- The entire v3 `project-context/` directory
- Queue-health thresholds and proposal workflow
- PowerShell scripts (`check-queue.ps1`, `propose-tasks.ps1`)

### Updated docs

- `README.md`, `START-HERE.md`, `OVERVIEW.md`, `INTEGRATION-GUIDE.md` were rewritten to reflect:
  - submodule install
  - copying `context-template/` into committed `.adt-context/`
  - “Now/Backlog/Log” model
  - attempts + interrupt
  - scratchpad

### Copilot snippet

- Added `COPILOT-INSTRUCTIONS-SNIPPET.md` for consistent, high-attention integration in consuming projects.

---

## Notes / Open Items

- The toolkit itself does not create GitHub issues automatically; issues should be drafted and created only with explicit user consent.
- `.scratchpad/` is a consuming-project convention; the toolkit recommends it, but the consuming repo should own its `.gitignore`.
- If needed, provide two Copilot snippet variants later:
  - “Solo dev” minimal
  - “Multi-agent” with agents/partitions emphasis
