# GitHub Copilot Protocol (ADT v4)

This project uses a small, committed context directory (`.adt-context/`) as the source of truth during the session.

Your goal is to work quickly **without repeating mistakes** and **without cluttering the repo**.

---

## Required Reads

Before making changes, read:

1. `.adt-context/interrupt.md`
2. `.adt-context/README.md`
3. `.adt-context/now.md`
4. `.adt-context/common-pitfalls.md`

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
