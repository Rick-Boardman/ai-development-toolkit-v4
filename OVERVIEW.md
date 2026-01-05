# System Overview

## What's Included

```text
.adt/                                        Self-contained context system
│
├── 📄 README.md                            Start here - complete guide
├── 📄 INTEGRATION-GUIDE.md                 How to add to your project
├── 📄 OVERVIEW.md                          This document
├── 📄 START-HERE.md                        Quick start
│
├── 📄 INSTRUCTIONS.md                      Copilot workflow instructions
│                                           (Referenced from your copilot-instructions.md)
│
└── 📁 project-context/
    │
    ├── 📄 README.md                        Project overview (template)
    ├── 📄 status.md                        Current state (template)
    ├── 📄 tasks.md                         Priority queue (template)
    ├── 📄 decisions.md                     Decision log (template)
    ├── 📄 session-log.md                   Session history (template)
    │
    ├── 🔧 check-queue.ps1                  Queue health checker
    ├── 🔧 propose-tasks.ps1                Proposal generator
    │
    └── 📁 queue-proposals/
        ├── 📄 README.md                    Proposal system guide
        └── 📄 example-proposals.md         Example format
```

## What Each File Does

### Documentation Files (Root)

**.adt/README.md** (Main guide)

- What the system is
- Quick start instructions
- Feature overview
- Usage examples
- Philosophy and approach

**.adt/INTEGRATION-GUIDE.md** (Setup guide)

- Installation instructions
- Integration with existing projects
- Configuration options
- Examples and tips

**.adt/START-HERE.md** (Quick start)

- Navigation hub
- 30-second overview
- Getting started path
- Documentation map

### Copilot Instructions

**.adt/INSTRUCTIONS.md** (Referenced from your project)

- Defines development workflow
- Code quality standards
- Queue management process
- Multi-agent coordination
- Communication style

**What it tells Copilot:**

- ✅ Register as active agent
- ✅ Check context files and claim tasks
- ✅ Follow queue-based workflow
- ✅ Document decisions with rationale
- ✅ Generate proposals when queue is low
- ✅ Update context continuously

### Context Files

**.adt/project-context/README.md** (Project overview)

- What you're building
- Technology stack
- Setup instructions
- Architecture overview
- Common commands

**.adt/project-context/status.md** (Current state)

- Active work and focus
- What's working vs broken
- Known issues and blockers
- Recent changes
- Environment status

**.adt/project-context/tasks.md** (Priority queue)

- 🔥 Critical tasks
- ⚡ High priority tasks
- 📋 Medium priority tasks
- 💭 Low priority tasks
- Queue health indicator
- Completion history

**.adt/project-context/decisions.md** (Decision log)

- Technical decisions
- Context and rationale
- Alternatives considered
- Consequences and trade-offs
- Superseded decisions

**.adt/project-context/session-log.md** (Session history)

- Development sessions
- Accomplishments
- Decisions made
- Files modified
- Handoff notes

### Automation Scripts

**.adt/project-context/check-queue.ps1** (Health checker)

```powershell
# Usage
pwsh .adt/project-context/check-queue.ps1          # Quick check
pwsh .adt/project-context/check-queue.ps1 -Detailed # Full breakdown
```

- Counts tasks by priority
- Calculates health status
- Provides recommendations
- Returns exit code

**.adt/project-context/propose-tasks.ps1** (Proposal generator)

```powershell
# Usage
pwsh .adt/project-context/propose-tasks.ps1
```

- Creates dated proposal file
- Opens for editing
- Guides AI through process

### Proposal System

**.adt/project-context/queue-proposals/README.md** (Guide)

- Proposal workflow explanation
- Template structure
- Review guidelines
- Quality criteria

**.adt/project-context/queue-proposals/example-proposals.md** (Examples)

- 5 example proposals
- Different priority levels
- Shows proper format
- Demonstrates rationale

## How It All Works Together

### 1. Initial Setup

```
Copy files to project → Customize templates → Commit to Git
```

### 2. Copilot Integration

```
Copilot reads instructions → Understands workflow → Follows patterns
```

### 3. Daily Workflow

```
Check status/tasks → Pick work → Update as you go → Log session
```

### 4. Queue Management

```
Check queue health → Low? Generate proposals → Human reviews → Add approved
```

### 5. Decision Tracking

```
Make decision → Document in decisions.md → Include rationale → Future reference
```

## Quick Reference

### For Developers

**Starting work:**

1. Read `.adt/project-context/status.md` and `tasks.md`
2. Pick a task
3. Start coding

**During work:**

- Update progress in context files
- Document decisions
- Mark completed tasks

**Ending work:**

- Log session in `session-log.md`
- Update status
- Create handoff notes

### For AI (Copilot)

**You're instructed to:**

- Read context files automatically
- Generate proposals when queue is low
- Document decisions with rationale
- Update context continuously
- Follow project patterns

### For Team Leads

**System health:**

```powershell
pwsh .adt/project-context/check-queue.ps1 -Detailed
```

**Review proposals:**

- Check `.adt/project-context/queue-proposals/[date]-proposals.md`
- Approve, modify, or reject
- Add approved to `tasks.md`

**Monitor context:**

- Ensure `status.md` stays current
- Review decision quality
- Check session logs for patterns

## System Size

```text
16 files total
150 lines of PowerShell
7 core context documents
2 automation scripts
Simple, maintainable workflows
```

## What Makes It Special

### Queue Health Management

**Problem:** Teams run out of prioritized work, development stalls

**Solution:**

1. Monitor queue health automatically
2. AI generates contextual proposals
3. Human reviews and approves
4. Queue stays healthy

**Why it matters:** Prevents work stalling, keeps development flowing

### Multi-Agent Coordination

**Design:** One system that works for 1 to N agents

- Solo developer: Track your own state
- Small team: Simple markdown coordination
- Multiple AI agents: Full coordination without configuration

**Why it matters:** Scales naturally as your team grows

### Works With Copilot

- Copilot reads markdown naturally
- Simple file-based workflows
- Everything in version control
- No complex setup required

## Get Started

**Immediate action:**

1. Read `.adt/README.md` for full overview
2. Follow `.adt/INTEGRATION-GUIDE.md` to set up
3. Customize templates for your project
4. Start using with your team

**Within first week:**

- Establish workflow rhythm
- Monitor queue health
- Generate first proposals
- Document key decisions

**Long term:**

- System becomes second nature
- Context stays current
- Team coordination improves
- Queue never depletes

---

## Get Started

1. Read [INTEGRATION-GUIDE.md](.adt/INTEGRATION-GUIDE.md) for installation
2. Customize context files for your project
3. Start tracking tasks and decisions
4. Let the queue management system keep work flowing
