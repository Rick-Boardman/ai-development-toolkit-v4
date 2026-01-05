# Integration Guide

How to add this context management system to your project.

---

## Installation (3 Steps)

### 1. Copy the System

```bash
# Copy as .adt to your project root (self-contained)
cp -r new/ your-project/.adt
```

The system lives entirely in `.adt/` - it doesn't touch your project files.

### 2. Add One Line to Your Copilot Instructions

**If you already have `.github/copilot-instructions.md`:**

Add this line anywhere (top is best):

```markdown
> **Context System**: See `.adt/INSTRUCTIONS.md` for context management workflows.
```

**If you don't have `.github/copilot-instructions.md` yet:**

Create it:

```markdown
# GitHub Copilot Instructions

> **Context System**: See `.adt/INSTRUCTIONS.md` for context management workflows.

## Your Project Rules

[Add your project-specific rules: tech stack, conventions, deployment, etc.]
```

### 3. Initialize Context Files

```bash
cd .adt/project-context

# Edit to match your project
code README.md      # Project overview
code tasks.md       # Add initial tasks
code status.md      # Current state
```

**Done!** Copilot reads `.adt/INSTRUCTIONS.md` through the reference.

---

## File Structure After Installation

```text
your-project/
├── .github/
│   └── copilot-instructions.md    # Your project rules + reference to .adt
├── .adt/                           # Self-contained context system
│   ├── INSTRUCTIONS.md             # Copilot reads this (context workflows)
│   ├── README.md                   # System documentation
│   └── project-context/
│       ├── README.md               # Your project overview
│       ├── status.md               # Your project status
│       ├── tasks.md                # Your task queue
│       ├── decisions.md            # Your decisions
│       ├── session-log.md          # Your sessions
│       ├── active-agents.md        # Your agents
│       ├── work-partitions.md      # Your partitions
│       ├── check-queue.ps1         # Queue health checker
│       ├── propose-tasks.ps1       # Proposal generator
│       └── queue-proposals/
└── [your project files...]
```

---

## How It Works

1. **Copilot reads** `.github/copilot-instructions.md` (your project rules)
2. **Copilot sees reference** to `.adt/INSTRUCTIONS.md`
3. **Copilot reads** `.adt/INSTRUCTIONS.md` (context workflows)
4. **Copilot follows** both sets of instructions

Your project rules stay in your copilot-instructions.md. Context workflows stay in .adt/.

---

## Examples

### Minimal Integration

Your `.github/copilot-instructions.md`:

```markdown
# Copilot Instructions

> **Context System**: See `.adt/INSTRUCTIONS.md` for context management workflows.

## Project: My API

- Node.js + TypeScript
- PostgreSQL database
- Deploy with `npm run deploy`
```

That's it!

### Full Integration

Your `.github/copilot-instructions.md`:

```markdown
# Copilot Instructions for My Project

> **Context System**: See `.adt/INSTRUCTIONS.md` for context management workflows.

## Technology Stack

- **Runtime**: Node.js 20
- **Language**: TypeScript 5.x
- **Database**: PostgreSQL 16
- **ORM**: Prisma
- **Testing**: Vitest

## Development Guardrails

- Always use UUID7 for identifiers (via `generateId()`)
- Never suppress TypeScript warnings
- Test in dev environment before asking for verification
- No dummy data - use real test fixtures

## Deployment

Deploy with: `npm run deploy:prod`
Always run migrations first: `npm run migrate`

## Code Conventions

- Prefer functional components (React)
- Use async/await over promises
- Document complex business logic
```

The context system (task queue, decisions, sessions, agents) is handled by `.adt/INSTRUCTIONS.md`.

---

## Updating the System

To update to a newer version:

```bash
# Backup your project context
cp -r .adt/project-context .adt-project-backup

# Update system files
cp new/INSTRUCTIONS.md .adt/
cp new/README.md .adt/
cp new/project-context/*.ps1 .adt/project-context/

# Restore your project context
cp -r .adt-project-backup/* .adt/project-context/
```

Your project-specific context (tasks, decisions, sessions) is preserved.

---

## Tips

### Start Minimal

You don't need everything:

1. Start with just `.adt/project-context/tasks.md` (task queue)
2. Add `.adt/project-context/decisions.md` when making important decisions
3. Add `.adt/project-context/session-log.md` for team handoffs
4. Add `.adt/project-context/active-agents.md` when working with multiple agents

### Customize Freely

It's just markdown files:

- Adjust queue thresholds in `.adt/project-context/check-queue.ps1`
- Add custom context files
- Modify workflows in `.adt/INSTRUCTIONS.md`
- Remove features you don't need

### Keep Your Rules Separate

**Your project-specific rules** → `.github/copilot-instructions.md`

- Tech stack
- Conventions
- Deployment
- Security policies

**Context workflows** → `.adt/INSTRUCTIONS.md`

- Task queue
- Decision tracking
- Multi-agent coordination
- Session management

This separation keeps updates clean.

---

## Common Questions

**Q: Do I need to copy `.github/copilot-instructions.md`?**
A: No! Keep yours and just add one reference line to `.adt/INSTRUCTIONS.md`.

**Q: What if I already have a `.adt/` directory?**
A: Backup your existing `.adt/`, then copy this system and migrate your project-specific content.

**Q: Can I rename `.adt/` to something else?**
A: Yes, but update the reference in your `copilot-instructions.md`.

**Q: Does this work with GitHub Copilot Chat?**
A: Yes! Copilot Chat reads `.github/copilot-instructions.md` which references `.adt/INSTRUCTIONS.md`.

**Q: What if my team doesn't want the full system?**
A: Just use the parts you need. Delete unused context files. It's flexible.

**Q: Can I share `.adt/` across multiple projects?**
A: No - each project needs its own `.adt/project-context/` with project-specific tasks and decisions.
