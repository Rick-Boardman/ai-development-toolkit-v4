# 🚀 Start Here (v4)

## AI Development Toolkit

A lightweight context management system for GitHub Copilot that helps AI agents and human developers work together effectively.

---

## 📖 Quick Navigation

### New to the System?

1. **[OVERVIEW.md](OVERVIEW.md)** - What's included and how it works
2. **[README.md](README.md)** - Complete documentation
3. **[INTEGRATION-GUIDE.md](INTEGRATION-GUIDE.md)** - Add to your project

### Ready to Use It?

1. Add this repo to your project as a git submodule at `.adt/` (see [INTEGRATION-GUIDE.md](INTEGRATION-GUIDE.md))
2. Copy `.adt/context-template/` into your project as `.adt-context/` and commit it
3. Add a reference line to your `.github/copilot-instructions.md`
4. Start working

---

## ⚡ 30-Second Overview

**What it is:** A protocol + a small committed context directory (`.adt-context/`)

**What it does:** Session context + decision tracking + lightweight coordination

**What makes it special:** A small committed `.adt-context/` that the AI re-reads during the session (so it doesn't repeat mistakes)

**How it works:** `.adt/` is a submodule (toolkit). `.adt-context/` lives in your repo (project memory).

---

## 📊 The System

- Toolkit (this repo): docs + protocol + templates
- Project memory (your repo): `.adt-context/` committed
- Optional scratch area: `.scratchpad/` gitignored

---

## 🎯 Core Features

### Session Memory

**Problem:** AI repeats the same mistakes during long sessions

**Solution:**

1. ✅ Keep a small, current “Now” list
2. 🧾 Log attempts/errors so the AI stops repeating them
3. ⛔ Provide an `interrupt.md` “pause button”

### Multi-Agent Coordination

- Works for solo developers (track your own state)
- Scales to small teams (simple coordination)
- Supports multiple AI agents (full coordination)
- No configuration changes needed

---

## 📁 What You Get

````text
your-project/
├── .github/
│   └── copilot-instructions.md       ← Your rules + reference to .adt/INSTRUCTIONS.md
│
├── .adt/                              ← Git submodule (toolkit)
│   ├── INSTRUCTIONS.md                ← Protocol the AI must follow
│   └── context-template/              ← Copy once into your project
│
├── .adt-context/                      ← Committed project memory (copy of template)
│   ├── README.md                      ← Context snapshot (keep short)
│   ├── now.md                         ← 1–5 current tasks
│   ├── reminders.md                   ← Reminders beyond the task list
│   ├── backlog.md                     ← Ideas / next work
│   ├── log.md                         ← Append-only “done / notable events”
│   ├── handoff.md                      ← Detailed end-of-session dump
│   ├── attempts.md                    ← Commands tried + errors + outcomes
│   ├── common-pitfalls.md             ← Sticky mistakes & conventions
│   ├── interrupt.md                   ← Pause button for humans
│   └── decisions.md                   ← Technical decisions w/ rationale
│
└── .scratchpad/                       ← Temporary scripts/debug (gitignored)

````

---

## 🎓 Documentation Map

| Document                 | Purpose                    | Read When                 |
| ------------------------ | -------------------------- | ------------------------- |
| **START-HERE.md**        | Navigation hub (this file) | First time                |
| **OVERVIEW.md**          | System overview            | Want to see what's inside |
| **README.md**            | Complete documentation     | Ready to use it           |
| **INTEGRATION-GUIDE.md** | How to add to your project | Ready to install          |
| **INSTRUCTIONS.md**      | Copilot protocol           | Understanding workflows   |

---

## 🚦 Getting Started Path

### Phase 1: Understand (10 minutes)

1. Read this file (START-HERE.md) ✓ You're here
2. Skim [OVERVIEW.md](OVERVIEW.md) - See what's included
3. Read [README.md](README.md) - Complete documentation

### Phase 2: Install (5 minutes)

1. Follow [INTEGRATION-GUIDE.md](INTEGRATION-GUIDE.md)
2. Add `.adt/` as a submodule
3. Run the initializer: `powershell -ExecutionPolicy Bypass -File .adt/scripts/adt-init.ps1`
4. Commit `.adt-context/` and `.github/copilot-instructions.md`

### Phase 3: Use (Ongoing)

1. Keep your working set small in `.adt-context/now.md`
2. Log failed commands/approaches in `.adt-context/attempts.md` to avoid repetition
3. Use `.adt-context/interrupt.md` as a human pause button
4. Record decisions in `.adt-context/decisions.md` when they matter

---

## 💡 Key Concepts

### Works With Copilot

- No need to tell AI to "read files first"
- Copilot reads `.github/copilot-instructions.md` automatically
- Natural markdown editing
- Everything visible in Git

### Human-Focused

- 5 files developers actually need
- Simple task queue
- Decision documentation
- Team handoff support

### Project Memory (Committed)

- `.adt-context/now.md` keeps the active work tiny
- `.adt-context/log.md` is append-only history
- `.adt-context/attempts.md` prevents repeating the same errors

---

## 🎯 Perfect For

- Projects using GitHub Copilot in VS Code
- Teams needing lightweight context management
- Multi-agent development workflows
- Anyone wanting lightweight, committed session memory
- Developers valuing simplicity

---

## 📞 Quick Help

**Can't find something?** Check [OVERVIEW.md](OVERVIEW.md) for system breakdown

**Want full details?** Read [README.md](README.md) for complete documentation

**Installation help?** See [INTEGRATION-GUIDE.md](INTEGRATION-GUIDE.md) for step-by-step guide

**Understanding workflows?** Read [INSTRUCTIONS.md](INSTRUCTIONS.md) for Copilot workflows

---

## ✨ Next Steps

**Right now:**

- Continue to [OVERVIEW.md](OVERVIEW.md) for system overview
- Or jump to [README.md](README.md) for full documentation
- Or go straight to [INTEGRATION-GUIDE.md](INTEGRATION-GUIDE.md) to install

**Within a week:**

- System set up in your project (`.adt/` directory)
- Team using it naturally
- A useful `now.md` / `attempts.md` rhythm established

**Long term:**

- Becomes second nature
- Context stays current
- Fewer repeated mistakes during long sessions
- Team coordination improves

---

**You're all set.** Choose your path above and start exploring!

📖 Full docs → [README.md](README.md)
🎯 System overview → [OVERVIEW.md](OVERVIEW.md)
⚙️ Install now → [INTEGRATION-GUIDE.md](INTEGRATION-GUIDE.md)
````
