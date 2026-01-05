# Integration Guide (v4)

How to add the AI Development Toolkit to a consuming project.

v4 assumes:

- `.adt/` is the toolkit (recommended: git submodule)
- `.adt-context/` is committed project memory (copied from `.adt/context-template/`)
- `.scratchpad/` is a gitignored place for temporary scripts/debug

---

## Install (Recommended)

### 1) Add the toolkit as a submodule

From your project root:

```bash
git submodule add https://github.com/Rick-Boardman/ai-development-toolkit-v4.git .adt
```

### 2) Create and commit `.adt-context/`

Copy the template into your repo (and commit it):

```bash
cp -r .adt/context-template .adt-context
```

### 3) Point Copilot at the protocol

Add a line to your `.github/copilot-instructions.md` (top is best):

```markdown
> **Context System**: Follow `.adt/INSTRUCTIONS.md` and treat `.adt-context/` as the project memory.
```

### 4) Add a scratchpad (recommended)

Add this to your project `.gitignore`:

```gitignore
.scratchpad/
```

---

## Updating the Toolkit

Because `.adt/` is a submodule, updating is straightforward:

```bash
git submodule update --remote --merge
```

If the toolkit template changes, you can selectively copy updates from `.adt/context-template/` into `.adt-context/`.

---

## Notes

- Keep `.adt-context/now.md` small (1–5 items). Move everything else to backlog/log.
- Use `.adt-context/attempts.md` to prevent repeated command mistakes during long sessions.
- Use `.adt-context/interrupt.md` as a human “pause button.”
