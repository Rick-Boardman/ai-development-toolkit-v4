# AI Development Toolkit (v4)

A lightweight context management system for GitHub Copilot.

v4 is designed around a simple split:

- `.adt/` is the **toolkit** (best-practices + protocol + templates) and is typically installed as a **git submodule**.
- `.adt-context/` is the **project’s committed memory** (small, high-signal files that the AI re-reads during long sessions).

## Why This Exists

Issue trackers are great between commits. v4 focuses on the gap *within* a coding session:

- Keep “what we’re doing now” clear and small
- Prevent repeating the same failed commands/approaches
- Provide a human “pause button” for long vibe-coding stretches
- Preserve the reasoning behind decisions

## Install (Recommended)

On Windows, prefer the **PowerShell** commands below unless you’re using Git Bash or WSL.

1. Add the toolkit as a submodule at `.adt/`:

   ```bash
   git submodule add https://github.com/Rick-Boardman/ai-development-toolkit-v4.git .adt
   ```

2. Copy the template into your repo as `.adt-context/` and commit it:

   **bash:**

   ```bash
   mkdir -p .adt-context
   cp -r .adt/context-template/* .adt-context/
   ```

   **PowerShell (Windows):**

   ```powershell
   New-Item -ItemType Directory -Force .adt-context | Out-Null
   Copy-Item -Recurse -Force .adt\context-template\* .adt-context\
   ```

   Or run the initializer (recommended; creates `.adt-context/`, `.scratchpad/`, `.github/`, `.gitignore`, and a starter copilot instructions block):

   ```powershell
   powershell -ExecutionPolicy Bypass -File .adt\scripts\adt-init.ps1
   ```

3. Add one line to your project’s `.github/copilot-instructions.md`:

   ```markdown
   > **Context System**: Follow `.adt/INSTRUCTIONS.md` and treat `.adt-context/` as the project memory.
   ```

## What’s In `.adt-context/`

Keep these short; prune aggressively.

- `README.md` — context snapshot (goal, constraints, links)
- `now.md` — 1–5 current tasks only
- `reminders.md` — reminders beyond the task list
- `backlog.md` — future work / ideas / rough notes
- `log.md` — append-only “done + notable events”
- `handoff.md` — detailed end-of-session dump when work is in-flight
- `attempts.md` — commands tried, errors, and outcomes (prevents repetition)
- `common-pitfalls.md` — sticky gotchas + repo conventions
- `interrupt.md` — human pause button
- `decisions.md` — decisions with context + rationale

## Scratchpad Convention

Use a `.scratchpad/` directory for temporary scripts, debug probes, and one-off helpers.

- Treat `.scratchpad/` as disposable
- Add it to `.gitignore` by default
- Don’t leave run-once scripts scattered around the repo

## Upstream Feedback

When you notice repeated agent mistakes or missing best practices:

- Record the project-specific fix in `.adt-context/common-pitfalls.md`
- Optionally propose a toolkit improvement (e.g. GitHub issue) with:
  - the problem
  - an example failure
  - the smallest instruction/template change that prevents it
