# GitHub Copilot Protocol (ADT v4)

This project uses a small, committed context directory (`.adt-context/`) as the source of truth during the session.

Your goal is to work quickly **without repeating mistakes** and **without cluttering the repo**.

---

## Bootstrap / Initialization (First Run)

If any of the following are missing:

- `.adt-context/`
- `.adt-context/adt-state.json`

Then perform a **one-time bootstrap** (and record it in `.adt-context/adt-state.json`) so the human does not need to do manual setup.

Bootstrap steps:

1. Create `.adt-context/` if it doesn’t exist.
2. Copy the toolkit template `.adt/context-template/` into `.adt-context/` **without overwriting existing project-specific content** (fill missing files only).
3. Create `.scratchpad/` if it doesn’t exist.
4. Create `.gitignore` if it doesn’t exist.
5. Ensure `.scratchpad/` is listed in `.gitignore`.
6. Create `.github/` if it doesn’t exist.
7. Create `.github/copilot-instructions.md` if it doesn’t exist.
8. Ensure `.github/copilot-instructions.md` contains **ADT v4 Option A** from `.adt/COPILOT-INSTRUCTIONS-SNIPPET.md` and the **Stop Condition** line.
9. If `.old-adt/` exists, follow `.adt/ADT-V3-TO-V4-MIGRATION.md` and migrate real project memory into `.adt-context/`.
10. Review the repo and update `.adt-context/README.md` so it contains real project info (goal, constraints, commands, links).
11. Update `.adt-context/adt-state.json`:
  - `bootstrapCompleted: true`
  - `migration.required` / `migration.completed`
  - `contextReadmeCustomized: true` once `.adt-context/README.md` is populated

If you can execute scripts, prefer running the toolkit initializer:

- Windows PowerShell (from project root): `powershell -ExecutionPolicy Bypass -File .adt/scripts/adt-init.ps1`

---

## Required Reads

Before making changes, read:

1. `.adt-context/interrupt.md`
2. `.adt-context/README.md`
3. `.adt-context/now.md`
4. `.adt-context/common-pitfalls.md`
5. `.adt-context/reminders.md`

If you hit errors or uncertainty, also read/update:

- `.adt-context/attempts.md` (commands tried + outcomes)
- `.adt-context/decisions.md` (decisions with rationale)

---

## Interrupt / Pause Button

Treat `.adt-context/interrupt.md` as authoritative.

- If it contains a non-empty instruction, **stop** and ask the human to discuss/confirm.
- Check `interrupt.md` at these checkpoints:
  - before starting a multi-step change
  - before running terminal commands that modify state
  - after any error
  - before applying patches / writing many files
  - after each batch of tool calls

---

## Workflow

### Starting Work

1. Read the required files above.
2. Pick **one** item from `now.md` (or ask to add/clarify one).
3. Keep the working set small: if you discover more work, put it in `backlog.md`.

### During Work

- Keep `now.md` updated: owner, next step, checkpoint.
- Record significant choices in `decisions.md`.
- Use `.scratchpad/` for temporary scripts/debug.

### Finishing Work

- Move completed items out of `now.md` and append to `log.md`.
- Summarize key outcomes in the PR/commit message (if applicable).

---

## Attempts Log (Don’t Repeat Errors)

When a command/approach fails:

1. Add an entry to `.adt-context/attempts.md` with:
   - the exact command
   - the working directory
   - the key error/output lines
   - your hypothesis
   - what you will change next
2. Before retrying, re-read the last entry and change at least one variable.

If the same error happens twice, stop and ask for discussion (or consult `common-pitfalls.md`).

---

## Scratchpad Convention

Temporary artifacts must go in `.scratchpad/`:

- one-off scripts
- debug probes
- experimental code
- temporary data dumps

Default: `.scratchpad/` is gitignored.

---

## Reminders (Beyond The Task List)

Use `.adt-context/reminders.md` for reminders that should survive beyond the current task list in `now.md`.

- Treat reminders as actionable items (trigger + owner).
- If a reminder should block work, put it in `interrupt.md` instead.

---

## End Of Session Handoff (Detailed)

If the user is ending the session with work in-flight (leaving / going to bed / switching contexts), write a **high-detail dump** to `.adt-context/handoff.md` before you stop.

Include: what changed, current state, next step, commands run, errors/attempts, and open questions.

---

## Best Practices

- Prefer small, targeted edits.
- Keep code DRY and modular; avoid duplicating logic.
- Don’t leave debug code in production paths.
- Update docs when behavior changes.
- Run the narrowest relevant tests/commands after changes.

---

## Stop Conditions (Ask Before Proceeding)

Pause and ask when:

- requirements are ambiguous
- a change is a major architectural decision
- destructive operations are needed (delete large areas, drop data)
- repeated failures occur without a clear next step
- security/privacy/compliance concerns arise

---

## Upstream Feedback

If you notice repeated agent mistakes or missing best practices:

- Put the project-specific fix in `.adt-context/common-pitfalls.md`.
- Propose a toolkit improvement in `backlog.md`.
- With explicit user consent, draft or create a GitHub issue on the toolkit repo.
