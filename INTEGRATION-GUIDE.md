# Integration Guide (v4)

How to add the AI Development Toolkit to a consuming project.

v4 assumes:

- `.adt/` is the toolkit (recommended: git submodule)
- `.adt-context/` is committed project memory (copied from `.adt/context-template/`)
- `.scratchpad/` is a gitignored place for temporary scripts/debug

---

## Install (Recommended)

All commands below are intended to be run from the **consuming project root** (the repo you’re adding ADT to).

**Windows note**: use the PowerShell blocks unless you’re using Git Bash or WSL.

### 1) Add the toolkit as a submodule

From your project root:

```bash
git submodule add https://github.com/Rick-Boardman/ai-development-toolkit-v4.git .adt
```

If you cloned a repo that already contains the submodule, initialize it:

```bash
git submodule update --init --recursive
```

Or clone with submodules from the start:

```bash
git clone --recurse-submodules <your-repo-url>
```

### 2) Create and commit `.adt-context/`

Recommended: run the initializer script (does the setup below automatically).

**PowerShell (Windows):**

```powershell
# from your project root
powershell -ExecutionPolicy Bypass -File .adt\scripts\adt-init.ps1
```

What it does:

- Creates `.adt-context/` (if missing) and fills missing files from the template
- Creates `.scratchpad/` (if missing)
- Creates/updates `.gitignore` to include `.scratchpad/`
- Creates `.github/` and `.github/copilot-instructions.md` (if missing)
- Ensures `.github/copilot-instructions.md` contains ADT Option A + the Stop Condition
- Writes `.adt-context/adt-state.json` so future sessions can skip bootstrap checks

If you prefer manual setup, copy the template into your repo (and commit it):

Copy the template into your repo (and commit it):

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

### 3) Point Copilot at the protocol

Add a line to your `.github/copilot-instructions.md` (top is best):

If you want the recommended high-attention wording, copy/paste from `COPILOT-INSTRUCTIONS-SNIPPET.md` in this repo.

```markdown
> **Context System**: Follow `.adt/INSTRUCTIONS.md` and treat `.adt-context/` as the project memory.
```

### 4) Add a scratchpad (recommended)

Use `.scratchpad/` for temporary scripts/debug helpers.

Add this to your project `.gitignore`:

```gitignore
.scratchpad/
```

---

## What To Commit (Checklist)

After installing, your consuming repo typically needs these committed:

- `.gitmodules` (created/updated by the submodule add)
- `.adt/` submodule pointer (the gitlink entry)
- `.adt-context/` directory (copied from the template)
- `.github/copilot-instructions.md` change (the line pointing to the protocol)
- `.gitignore` update for `.scratchpad/` (recommended)

Avoid committing `.scratchpad/` contents.

---

## Updating the Toolkit

Because `.adt/` is a submodule, updating is straightforward:

```bash
git submodule update --remote --merge
```

Then commit the submodule pointer update in your consuming repo.

If the toolkit template changes, you can selectively copy updates from `.adt/context-template/` into `.adt-context/`.

---

## Notes

- Keep `.adt-context/now.md` small (1–5 items). Move everything else to backlog/log.
- Use `.adt-context/attempts.md` to prevent repeated command mistakes during long sessions.
- Use `.adt-context/interrupt.md` as a human “pause button.”
