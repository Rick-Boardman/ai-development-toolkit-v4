# ADT v3 → v4 Migration Guide

This guide helps you migrate a repository from **ADT v3** (toolkit under `.adt/` with project memory in `.adt/project-context/`) to **ADT v4** (toolkit under `.adt/` with project memory in `.adt-context/`).

It’s written to be **repo-agnostic** so it can be added to the ADT v4 toolkit.

---

## Quick Summary

- **ADT v3**: project “memory” lived in `.adt/project-context/` (often `tasks.md`, `status.md`, `decisions.md`, `session-log.md`, etc.)
- **ADT v4**: project “memory” lives in `.adt-context/` (notably `now.md`, `backlog.md`, `decisions.md`, `log.md`, `attempts.md`, `common-pitfalls.md`, `interrupt.md`)

The migration is primarily:

1. Install/enable the ADT v4 toolkit under `.adt/`
2. Create `.adt-context/` from the v4 template
3. Move any real “memory” content from v3 files into the v4 equivalents
4. Update any assistant instructions to reference `.adt-context/`
5. Archive or remove the old v3 toolkit folder

---

## Before You Start

- Decide whether you want to **keep v3 history** (archive) or **delete it** after migration.
- If your repo already has an active “assistant instructions” file (often `.github/copilot-instructions.md`), plan to update it.

---

## Step-by-step Migration

### 1) Archive the v3 toolkit folder

If your repo currently has ADT v3 in `.adt/`, rename it so you can safely install v4.

Example (PowerShell):

```powershell
# from repo root
Rename-Item -Path .adt -NewName .old-adt
```

Notes:

- Using `.old-adt/` is just a convention; any name is fine.
- If you already did this, skip to the next step.

### 2) Install ADT v4 under `.adt/`

Install the ADT v4 toolkit so the repo contains:

- `.adt/INSTRUCTIONS.md`
- `.adt/START-HERE.md`
- `.adt/README.md`
- `.adt/context-template/…`

How you install it depends on your workflow:

- **Option A (recommended for reuse):** add ADT v4 as a **git submodule** at `.adt/`
- **Option B:** vendor/copy the toolkit into `.adt/`

If you already installed v4 at `.adt/`, continue.

### 3) Create `.adt-context/` (v4 project memory)

ADT v4 expects a committed context directory at repo root:

- `.adt-context/interrupt.md`
- `.adt-context/README.md`
- `.adt-context/now.md`
- `.adt-context/common-pitfalls.md`
- `.adt-context/backlog.md`
- `.adt-context/decisions.md`
- `.adt-context/log.md`
- `.adt-context/attempts.md`

Create it by copying the v4 template directory:

```text
.adt/context-template/  →  .adt-context/
```

If `.adt-context/` already exists, keep it and only fill missing files.

### 4) Migrate content (v3 → v4 mapping)

If ADT v3 had **real content** (not just empty templates), migrate it into the v4 files.

Common file mapping:

| ADT v3 file (old) | ADT v4 destination (new) | What to do |
|---|---|---|
| `.adt/project-context/README.md` | `.adt-context/README.md` | Merge project-specific content (goal, constraints, commands, links) into the v4 README structure; don’t overwrite the v4 template wholesale. |
| `.adt/project-context/tasks.md` | `.adt-context/now.md` + `.adt-context/backlog.md` | Move “active” items into `now.md`; move the rest into `backlog.md`. |
| `.adt/project-context/status.md` | `.adt-context/now.md` | Summarize the current focus and blockers in the single `now.md` task. |
| `.adt/project-context/decisions.md` | `.adt-context/decisions.md` | Copy decision history as-is (or summarize if long). |
| `.adt/project-context/session-log.md` | `.adt-context/log.md` | Append notable events and completions into `log.md`. |
| `.adt/project-context/queue-proposals/` | (optional) `.adt-context/` or delete | If you used it, keep it; otherwise delete/ignore. |

**If v3 was not actually used** (only templates, no meaningful entries):

- Keep the v4 `.adt-context/` templates as-is
- Do **not** copy the v3 templates into `.adt-context/` (to keep memory high-signal)
- Optionally delete/archive the old v3 folder after confirming migration

#### AI agent prompt (Step 4)

Copy/paste this prompt to your AI coding agent to perform Step 4.

```text
You are a coding agent in a repo migrating from ADT v3 to ADT v4.

Goal:
- Migrate any *real* content from ADT v3 project memory into ADT v4 project memory.
- Do NOT copy empty templates; keep .adt-context/ high-signal.

Context:
- ADT v4 toolkit lives in .adt/
- ADT v4 project memory lives in .adt-context/
- ADT v3 toolkit/memory was archived (commonly as .old-adt/), with v3 memory previously under .adt/project-context/ (now likely .old-adt/project-context/).

Hard requirements:
1) Before changing anything, read (in this order):
  - .adt/INSTRUCTIONS.md
  - .adt-context/interrupt.md (if it contains a non-empty instruction, STOP and ask the human)
  - .adt-context/README.md
  - .adt-context/now.md
  - .adt-context/common-pitfalls.md
2) Inspect the archived v3 memory folder (for example .old-adt/project-context/). Determine whether it contains real content or only boilerplate templates.
3) If it is only templates / placeholders:
  - Do not copy them into .adt-context/
  - Add a short entry to .adt-context/log.md noting that v3 memory was unused and no content migration was needed.
4) If there is real content, migrate it using this mapping:
  - v3 README.md → v4 README.md (.adt-context/README.md): merge project-specific details (goal, focus, constraints, commands, links) into the v4 structure
  - v3 tasks.md → v4 now.md + backlog.md (active items → now.md; future items → backlog.md)
  - v3 status.md → v4 now.md (current focus, blockers)
  - v3 decisions.md → v4 decisions.md
  - v3 session-log.md → v4 log.md (append-only; newest first if that is the local convention)
  - v3 queue-proposals/ → keep only if used and non-empty; otherwise ignore
5) Be conservative:
  - Prefer summarizing long/verbose v3 content rather than copying entire low-signal sections.
  - Do not invent project facts; if something is unknown, leave placeholders or omit.
  - When migrating README content, preserve the v4 README headings; populate the “Snapshot / Handy Links / Commands” fields rather than pasting an entire v3 README template.
6) After migration:
  - Run a repo-wide search for references to .adt/project-context and update them to .adt-context (only where appropriate; don’t break docs that intentionally describe v3).
  - Add a brief “migration performed” note to .adt-context/log.md.
7) If any command fails, record it in .adt-context/attempts.md and change at least one variable before retrying.

Output:
- Provide a short summary of what you migrated (which files changed, and why).
```

### 5) Update assistant instructions

Update any repo-level assistant instructions so the agent uses ADT v4.

Typical changes:

- Replace references to `.adt/project-context/…` with `.adt-context/…`
- Ensure the “required reads” mention:
  - `.adt/INSTRUCTIONS.md`
  - `.adt-context/interrupt.md`
  - `.adt-context/README.md`
  - `.adt-context/now.md`
  - `.adt-context/common-pitfalls.md`
- Ensure your instructions include the v4 rule: **if `interrupt.md` contains an instruction, stop and ask.**

### 6) Final cleanup

- Confirm `.adt-context/` is committed and present in the repo.
- Confirm the toolkit folder `.adt/` is present (submodule or vendored).
- Decide what to do with the archived v3 folder:
  - Keep `.old-adt/` for history, or
  - Remove it once you’re confident everything important moved

---

## Worked Example (Steps You May Have Already Done)

If you already:

1. Renamed `.adt/` (v3) → `.old-adt/`
2. Added ADT v4 as a git submodule at `.adt/`

Then the remaining work is usually just:

- Create `.adt-context/` from the v4 template
- Migrate any real v3 content into v4 files (or skip if v3 wasn’t used)
- Update assistant instructions to point at `.adt-context/`

---

## Validation Checklist

- [ ] `.adt/INSTRUCTIONS.md` exists and describes ADT v4 workflow
- [ ] `.adt-context/interrupt.md` exists (and is empty by default)
- [ ] `.adt-context/now.md` has the current working set (1–5 items)
- [ ] `.adt-context/attempts.md` exists for logging repeated failures
- [ ] Any repo docs or assistant instructions reference `.adt-context/` (not `.adt/project-context/`)

---

## Notes

- Keep `.adt-context/` **small and current**; avoid dumping large historical templates there.
- If you want to preserve old templates for reference, archive them outside `.adt-context/` (or delete them).