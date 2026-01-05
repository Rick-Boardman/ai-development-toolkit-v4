# AI Development Toolkit

A lightweight context management system for GitHub Copilot that helps AI agents and human developers work together effectively. Provides task queue management, decision tracking, and multi-agent coordination through simple markdown files.

## What This Does

- **Task Queue Management** with health monitoring and AI proposal generation
- **Decision Documentation** with rationale and alternatives
- **Session Tracking** for team handoffs and project continuity
- **Multi-Agent Coordination** that scales naturally from 1 to N agents
- **Development Status** tracking in simple markdown files

## Philosophy

Work with GitHub Copilot's native capabilities:

- Copilot reads markdown files naturally
- Context updates are just file edits
- No complex orchestration or setup required
- Everything visible in version control

## Quick Start

See [INTEGRATION-GUIDE.md](.adt/INTEGRATION-GUIDE.md) for complete installation instructions.

### 3-Step Installation

1. **Copy to your project**:

   ```bash
   cp -r . your-project/.adt
   ```

2. **Add one line** to your `.github/copilot-instructions.md`:

   ```markdown
   > **Context System**: See `.adt/INSTRUCTIONS.md` for context management workflows.
   ```

3. **Initialize context files**:
   ```bash
   cd .adt/project-context
   code README.md tasks.md status.md
   ```

The system is self-contained in `.adt/` and integrates via a single reference line.

## Core Features

### 📊 Queue Health Monitoring

The task queue in `.adt/project-context/tasks.md` maintains a healthy backlog of work:

```powershell
# Check queue health
pwsh .adt/project-context/check-queue.ps1

# Check with details
pwsh .adt/project-context/check-queue.ps1 -Detailed
```

**Queue Health Levels:**

- **HEALTHY**: 7+ actionable tasks
- **LOW**: 4-6 tasks
- **CRITICAL**: 1-3 tasks
- **DEPLETED**: 0 tasks

### 🤖 AI Task Proposal System

When queue runs low, AI generates contextual task proposals:

```powershell
# Generate proposal template
pwsh .adt/project-context/propose-tasks.ps1
```

AI then fills in proposals based on:

- Current project context
- Recent work patterns
- Upcoming milestones
- Technical debt opportunities

Human reviews and approves proposals before adding to queue.

### 📝 Decision Documentation

Technical decisions are documented in `.adt/project-context/decisions.md` with:

- **Context**: Why the decision was needed
- **Decision**: What was decided
- **Rationale**: Why this approach
- **Alternatives**: What else was considered
- **Consequences**: Trade-offs and impacts

This helps future developers (and AI) understand **why** things are the way they are.

### 📖 Session Logs

Development sessions are tracked in `.adt/project-context/session-log.md` for:

- Team handoffs between developers
- Understanding what happened when
- Tracking progress and blockers
- Providing context for code reviews

## File Structure

```text
your-project/
├── .github/
│   └── copilot-instructions.md    # Your project rules + reference to .adt
│
└── .adt/                           # Self-contained context system
    ├── INSTRUCTIONS.md             # Copilot workflow instructions
    └── project-context/
        ├── README.md               # Project overview
        ├── status.md               # Current state
        ├── tasks.md                # Priority queue with agent claiming
        ├── decisions.md            # Technical decisions
        ├── session-log.md          # Session history
        ├── active-agents.md        # Agent registry (multi-agent coordination)
        ├── work-partitions.md      # Work area assignments (multi-agent coordination)
        ├── check-queue.ps1         # Queue health checker
        ├── propose-tasks.ps1       # Proposal generator
        └── queue-proposals/        # AI-generated proposals
            ├── README.md
            ├── example-proposals.md
            └── [dated-proposals].md
```

## How It Works With Copilot

### Copilot Reads Instructions

GitHub Copilot automatically reads `.github/copilot-instructions.md` and understands:

- Project context file locations
- Development workflow expectations
- Queue management system
- Multi-agent coordination protocol
- Quality standards and conventions

### AI-Human Collaboration Pattern

**AI Responsibilities:**

- Register in `.adt/project-context/active-agents.md` when starting work
- Read context files before starting work
- Claim tasks before working on them
- Update progress in context files
- Check work partitions for conflicts
- Generate task proposals when queue is low
- Document decisions with rationale

**Human Responsibilities:**

- Review and approve AI task proposals
- Provide strategic direction
- Update context when priorities change
- Review and merge AI contributions
- Resolve conflicts if multiple agents overlap

### Multi-Agent Coordination

**The system scales naturally from 1 to N agents:**

**Solo Agent (N=1):**

- Self-registration tracks your own session state
- Task claiming shows current focus
- Partitions help maintain work boundaries
- Status tracking across sessions

**Multiple Agents (N>1):**

- Each agent registers in `active-agents.md`
- Task claiming prevents duplicate work
- Partitions prevent file conflicts
- Status shows who's working on what
- Coordination overhead only appears when actually needed

**Key Design Principle**: No configuration changes needed when adding agents. The coordination system is always present but only adds overhead when multiple agents are actually active.

### Continuous Context Updates

Unlike complex systems that try to "augment" AI, this works with Copilot's strengths:

- Copilot reads markdown files naturally
- Context updates are just file edits
- No special commands or workflows needed
- Everything visible in version control
- Coordination happens through file updates (Git handles conflicts)

## Integration with VS Code

### Optional Tasks

You can add VS Code tasks for convenience:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Check Queue Health",
      "type": "shell",
      "command": "pwsh",
      "args": ["-File", ".adt/project-context/check-queue.ps1", "-Detailed"],
      "presentation": { "echo": true, "reveal": "always", "panel": "shared" }
    },
    {
      "label": "Generate Task Proposals",
      "type": "shell",
      "command": "pwsh",
      "args": ["-File", ".adt/project-context/propose-tasks.ps1"],
      "presentation": { "echo": true, "reveal": "always", "panel": "shared" }
    }
  ]
}
```

But these are optional - the system works fine without them.

## Why This Approach

### Self-Contained and Non-Invasive

- Lives entirely in `.adt/` directory
- Doesn't modify your project structure
- Integrates with one reference line
- Easy to add, easy to remove

### Works With Copilot's Strengths

- Copilot reads markdown files naturally
- No special commands or setup required
- Context updates are just file edits
- Everything in version control

### Scales Naturally

- Solo developers: Track your own context and state
- Small teams: Coordinate through simple markdown files
- Multi-agent: Full coordination without configuration changes
- Git handles conflicts automatically

### Maintainable and Transparent

- Plain markdown files (no hidden state)
- Standard text search works
- Changes visible in Git diffs
- Simple scripts for automation

## Usage Examples

### Starting Work

```text
1. GitHub Copilot automatically reads .github/copilot-instructions.md
2. Register in .adt/project-context/active-agents.md
3. Review .adt/project-context/status.md and .adt/project-context/tasks.md
4. Claim an unclaimed task (update Claimed field)
5. Mark task in-progress with [>]
6. Update context files as you work
7. Mark task complete [x] when done
```

### When Queue Runs Low

```bash
# Check queue health
pwsh .adt/project-context/check-queue.ps1

# If low, generate proposals
pwsh .adt/project-context/propose-tasks.ps1

# AI fills in proposals
# Human reviews and approves
# Add approved tasks to tasks.md
```

### Documenting Decisions

When making a significant technical decision, add to `.adt/project-context/decisions.md`:

```markdown
### 2025-11-01 - Use Redis for Rate Limiting

**Context**: Need rate limiting for API endpoints to prevent abuse

**Decision**: Use Redis with sliding window algorithm

**Rationale**:

- Redis is already in our stack
- Sliding window more accurate than fixed window
- Distributed system needs shared state

**Alternatives Considered**:

1. In-memory rate limiting - Doesn't work across multiple servers
2. Database-based - Too slow for rate limiting use case

**Consequences**:

- Adds Redis as critical dependency for auth
- Need to handle Redis failures gracefully

**Status**: Active
```

### Team Handoffs

End your session in `.adt/project-context/session-log.md`:

```markdown
### 2025-11-01 - Implement Rate Limiting

**Developer**: Alice
**Duration**: 4 hours
**Status**: ✅ Completed

**Goal**: Add rate limiting to authentication endpoints

**Accomplishments**:

- Implemented Redis-based rate limiter middleware
- Added tests for rate limiting logic
- Updated API documentation

**Decisions Made**:

- Using Redis with 5 attempts per 15 minutes (see decisions.md)

**Handoff Notes**:

- Rate limiting is working but needs production Redis setup
- TODO: Add monitoring for rate limit hits
- TODO: Document rate limits in API docs
```

## Customization

### Adjust Queue Thresholds

Edit `.adt/project-context/check-queue.ps1` to change thresholds:

```powershell
$criticalStatus = if ($criticalCount -ge 2) { "✅" } else { "⚠️" }  # Was ≥1
$highStatus = if ($highCount -ge 4) { "✅" } else { "⚠️" }          # Was ≥2
```

### Add Your Own Context Files

The system is just markdown files - add whatever makes sense:

```text
.adt/project-context/
├── api-design.md           # API design decisions
├── architecture.md         # System architecture
├── deployment.md           # Deployment procedures
└── troubleshooting.md      # Common issues
```

Reference them in `.adt/INSTRUCTIONS.md` so Copilot knows to read them.

### Modify Instructions

Edit `.adt/INSTRUCTIONS.md` to customize workflows, or add project-specific rules to your `.github/copilot-instructions.md`.

## License

MIT - Use freely in any project.
