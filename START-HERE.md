# 🚀 Start Here

## AI Development Toolkit

A lightweight context management system for GitHub Copilot that helps AI agents and human developers work together effectively.

---

## 📖 Quick Navigation

### New to the System?

1. **[OVERVIEW.md](.adt/OVERVIEW.md)** - What's included and how it works
2. **[README.md](.adt/README.md)** - Complete documentation
3. **[INTEGRATION-GUIDE.md](.adt/INTEGRATION-GUIDE.md)** - Add to your project

### Ready to Use It?

1. Copy as `.adt/` to your project (see [INTEGRATION-GUIDE.md](.adt/INTEGRATION-GUIDE.md))
2. Add one reference line to your `.github/copilot-instructions.md`
3. Customize context files in `.adt/project-context/`
4. Start working

---

## ⚡ 30-Second Overview

**What it is:** Context files + automation scripts + workflow instructions for Copilot

**What it does:** Task queue management + Decision tracking + Multi-agent coordination

**What makes it special:** Queue health monitoring with AI proposal generation

**How it works:** Self-contained in `.adt/` directory, integrates with one reference line

---

## 📊 The System

- **16 files total**
- **150 lines** of PowerShell automation
- **7 core context documents**
- **2 helper scripts**
- Works for 1 to N agents naturally

---

## 🎯 Core Features

### Queue Health Management

**Problem:** Teams run out of prioritized work, development stalls

**Solution:**

1. ✅ Monitor queue health automatically
2. 🤖 AI generates contextual proposals
3. 👤 Human reviews and approves
4. ♻️ Queue stays healthy

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
│   └── copilot-instructions.md       ← Your rules + reference to .adt
│
└── .adt/                              ← Self-contained system
    ├── INSTRUCTIONS.md                ← Copilot workflow instructions
    └── project-context/
        ├── README.md                  ← Project overview
        ├── status.md                  ← Current state
        ├── tasks.md                   ← Priority queue with agent claiming
        ├── decisions.md               ← Decision log
        ├── session-log.md             ← Session history
        ├── active-agents.md           ← Agent registry
        ├── work-partitions.md         ← Work area assignments
        ├── check-queue.ps1            ← Health checker
        ├── propose-tasks.ps1          ← Proposal generator
        └── queue-proposals/           ← AI proposals
```---

## 🎓 Documentation Map

| Document                 | Purpose                    | Read When                 |
| ------------------------ | -------------------------- | ------------------------- |
| **.adt/START-HERE.md**        | Navigation hub (this file) | First time                |
| **.adt/OVERVIEW.md**          | System overview            | Want to see what's inside |
| **.adt/README.md**            | Complete documentation     | Ready to use it           |
| **.adt/INTEGRATION-GUIDE.md** | How to add to your project | Ready to install          |
| **.adt/INSTRUCTIONS.md**      | Copilot workflow guide     | Understanding workflows   |

---

## 🚦 Getting Started Path

### Phase 1: Understand (10 minutes)

1. Read this file (.adt/START-HERE.md) ✓ You're here
2. Skim [OVERVIEW.md](.adt/OVERVIEW.md) - See what's included
3. Read [README.md](.adt/README.md) - Complete documentation

### Phase 2: Install (5 minutes)

1. Follow [INTEGRATION-GUIDE.md](.adt/INTEGRATION-GUIDE.md)
2. Copy as `.adt/` to your project
3. Add one reference line to your copilot-instructions.md
4. Customize context files

### Phase 3: Use (Ongoing)

1. Copilot follows your workflow automatically
2. Monitor queue health
3. Generate proposals when needed
4. Document decisions as you make them

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

### Queue Innovation

- Automated health monitoring
- AI-generated proposals
- Human approval workflow
- Never runs out of priorities

---

## 🎯 Perfect For

- Projects using GitHub Copilot in VS Code
- Teams needing lightweight context management
- Multi-agent development workflows
- Anyone wanting queue health management
- Developers valuing simplicity

---

## 📞 Quick Help

**Can't find something?** Check [OVERVIEW.md](.adt/OVERVIEW.md) for system breakdown

**Want full details?** Read [README.md](.adt/README.md) for complete documentation

**Installation help?** See [INTEGRATION-GUIDE.md](.adt/INTEGRATION-GUIDE.md) for step-by-step guide

**Understanding workflows?** Read [INSTRUCTIONS.md](.adt/INSTRUCTIONS.md) for Copilot workflows

---

## ✨ Next Steps

**Right now:**

- Continue to [OVERVIEW.md](.adt/OVERVIEW.md) for system overview
- Or jump to [README.md](.adt/README.md) for full documentation
- Or go straight to [INTEGRATION-GUIDE.md](.adt/INTEGRATION-GUIDE.md) to install

**Within a week:**

- System set up in your project (`.adt/` directory)
- Team using it naturally
- Queue health monitoring active
- First proposals generated

**Long term:**

- Becomes second nature
- Context stays current
- Queue never depletes
- Team coordination improves

---

**You're all set.** Choose your path above and start exploring!

📖 Full docs → [README.md](.adt/README.md)
🎯 System overview → [OVERVIEW.md](.adt/OVERVIEW.md)
⚙️ Install now → [INTEGRATION-GUIDE.md](.adt/INTEGRATION-GUIDE.md)
````
