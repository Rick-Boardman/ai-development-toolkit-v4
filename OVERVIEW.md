# System Overview (v4)

v4 is a lightweight context protocol for GitHub Copilot.

Key idea: separate the **toolkit** from the **project’s memory**.

- `.adt/` (toolkit) is typically a git submodule you can update independently.
- `.adt-context/` (project memory) is committed in the consuming repo.

---

## What’s Included (Toolkit)

```text
.adt/
├── README.md
├── START-HERE.md
├── OVERVIEW.md
├── INTEGRATION-GUIDE.md
├── INSTRUCTIONS.md              Protocol for agents
└── context-template/            Copy once into your repo as .adt-context/
    ├── README.md                Context snapshot
    ├── now.md                   1–5 current tasks
    ├── backlog.md               Future work / ideas
    ├── log.md                   Append-only done/events
    ├── attempts.md              Commands tried + outcomes
    ├── common-pitfalls.md       Sticky gotchas
    ├── interrupt.md             Human pause button
    ├── decisions.md             Decisions w/ rationale
    ├── agents.md                Optional: multi-agent status
    └── work-partitions.md       Optional: conflict prevention
```

---

## How It Works

1. Copilot reads your `.github/copilot-instructions.md`.
2. That file points Copilot at `.adt/INSTRUCTIONS.md`.
3. The protocol requires reading `.adt-context/` before making changes and at key checkpoints.

---

## Design Goals

- Keep the working set small (`now.md`)
- Prevent repeating mistakes (`attempts.md`, `common-pitfalls.md`)
- Enable safe human intervention (`interrupt.md`)
- Keep history out of the working set (`log.md`)
- Avoid repo clutter via `.scratchpad/` (gitignored)
