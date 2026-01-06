# Copilot Instructions Snippet (Recommended)

Copy/paste the following into your project’s `.github/copilot-instructions.md`.

Place it near the top so it has high priority.

```markdown
> **ADT v4 (Required)**:
> 1) Before making changes, read `.adt/INSTRUCTIONS.md`.
> 2) Treat `.adt-context/` as the project’s committed memory and read it first.
> 3) Check `.adt-context/interrupt.md` at checkpoints; if it contains instructions, stop and ask.
> 4) Log repeated command failures in `.adt-context/attempts.md` and don’t repeat the same command without changing something.
> 5) Put temporary scripts/debug helpers in `.scratchpad/` (gitignored).
```

Optional (if you want to make it even harder to ignore): add a short “Stop Condition” line right under it:

```markdown
> **Stop Condition**: If you have not read `.adt-context/now.md`, stop and read it before proceeding.
```
