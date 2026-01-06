# Copilot Instructions Snippet (Recommended)

Copy/paste **one** of the following into your project’s `.github/copilot-instructions.md`.

Place it near the top so it has high priority.

## Option A — Solo / Minimal

```markdown
> **ADT v4 (Required)**:
> 1) Before making changes, read `.adt/INSTRUCTIONS.md`.
> 2) Treat `.adt-context/` as the project’s committed memory and read it first.
> 3) Check `.adt-context/interrupt.md` at checkpoints; if it contains instructions, stop and ask.
> 4) Log repeated command failures in `.adt-context/attempts.md` and don’t repeat the same command without changing something.
> 5) Put temporary scripts/debug helpers in `.scratchpad/` (gitignored).
```

## Option B — Multi-Agent / Coordination

Use this when you expect parallel work and conflict risk.

```markdown
> **ADT v4 (Required)**:
> 1) Before making changes, read `.adt/INSTRUCTIONS.md`.
> 2) Treat `.adt-context/` as the project’s committed memory and read it first.
> 3) Check `.adt-context/interrupt.md` at checkpoints; if it contains instructions, stop and ask.
> 4) Keep `.adt-context/now.md` to 1–5 items; move everything else to backlog/log.
> 5) Log repeated command failures in `.adt-context/attempts.md` and don’t repeat the same command without changing something.
> 6) If multiple agents/humans are active, consult `.adt-context/agents.md` and `.adt-context/work-partitions.md` before editing shared areas.
> 7) Put temporary scripts/debug helpers in `.scratchpad/` (gitignored).
```

Optional (if you want to make it even harder to ignore): add a short “Stop Condition” line right under it:

```markdown
> **Stop Condition**: If you have not read `.adt-context/now.md`, stop and read it before proceeding.
```
