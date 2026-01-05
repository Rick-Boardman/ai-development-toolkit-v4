# GitHub Copilot Instructions for This Project

## Project Context

This is a software development project that uses structured context files for team coordination and knowledge management. GitHub Copilot should follow these workflows and conventions.

---

## 🚦 Guard-Rails

### Workspace Boundaries

- **Write code only inside the project workspace**
- Never modify files outside the current project root
- Respect read-only directories and system files

### Stop Conditions - Pause and Ask When

- ❌ Making architectural decisions (major design choices)
- ❌ Requirements are uncertain or ambiguous
- ❌ Encountering build/test failures that aren't immediately fixable
- ❌ Security, privacy, or compliance concerns arise
- ❌ Destructive operations needed (deleting files, dropping databases, major refactors)
- ❌ User feedback requires scope changes

**Don't guess** — ask for clarification and wait for approval.

### Development Best Practices

- **Test your changes**: Verify functionality in the actual environment before asking user to validate
- **No silent fallbacks**: Never introduce hidden retry logic, default branches, or quiet fallbacks without explicit instruction
- **Non-interactive scripts**: Always include non-interactive flags (e.g., `--no-cli-pager`, `-y`) to prevent prompts in scripts
- **Investigate before fixing**: Check logs and root causes before proposing solutions
- **Surface warnings**: Never suppress warnings; resolve root causes instead of muting them
- **Script clarity**: Avoid complex inline one-liners; use small helper scripts under `scripts/` for maintainability
- **No dummy data**: Never generate placeholder/dummy data in the production environment; only specific tables will be seeded
- **Complete implementations**: No partial endpoints, dry runs, or alternate versions. Complete features across all layers (UI, backend, migrations) in the same commit
- **UI alongside backend**: Build UI iteratively with backend changes so features remain testable and usable at every stage

---

## Context Files Location

All project context is maintained in the `.adt/project-context/` directory:

- **`.adt/project-context/README.md`** - Project overview, setup, and getting started
- **`.adt/project-context/status.md`** - Current development state and active work
- **`.adt/project-context/tasks.md`** - Priority task queue with completion tracking and agent claiming
- **`.adt/project-context/decisions.md`** - Technical decisions with rationale
- **`.adt/project-context/session-log.md`** - Development session history
- **`.adt/project-context/active-agents.md`** - Agent registry and coordination status (for multi-agent work)
- **`.adt/project-context/work-partitions.md`** - Work area assignments and conflict prevention (for multi-agent work)

## Development Workflow

### Starting Work

1. **Register as active agent**: Add yourself to `.adt/project-context/active-agents.md` if not already present
2. **Check work partitions**: Review `.adt/project-context/work-partitions.md` for area assignments and conflicts
3. **Check current status**: Review `.adt/project-context/status.md` and `.adt/project-context/tasks.md`
4. **Pick a task**: Select unclaimed task from priority queue in `.adt/project-context/tasks.md`
5. **Claim the task**: Update task with your agent ID in `Claimed` field
6. **Mark in progress**: Change `[ ]` to `[>]` when actively working
7. **Start session**: Log session start in `.adt/project-context/session-log.md` with timestamp and goal

### During Development

1. **Update agent status**: Keep `.adt/project-context/active-agents.md` current with your status (Active/Paused/Blocked)
2. **Document decisions**: Add any significant technical decisions to `.adt/project-context/decisions.md` with rationale
3. **Update progress**: Mark task progress in `.adt/project-context/tasks.md` as you work
4. **Track blockers**: Note any blockers or dependencies in `.adt/project-context/status.md`
5. **Watch for conflicts**: Check `.adt/project-context/work-partitions.md` if touching shared resources

### Completing Work

1. **Update task status**: Mark task as complete `[x]` in `.adt/project-context/tasks.md`
2. **Release claim**: Task completion automatically releases the claim
3. **Log session**: Add session summary to `.adt/project-context/session-log.md` with accomplishments
4. **Update status**: Reflect changes in `.adt/project-context/status.md`
5. **Update agent registry**: Mark yourself Complete or Paused in `.adt/project-context/active-agents.md`

## Queue Management System

This project uses an innovative queue health monitoring system to prevent task queue depletion.

### Queue Health Monitoring

Tasks in `.adt/project-context/tasks.md` are categorized by priority:

- 🔥 **Critical** - Must be done immediately
- ⚡ **High** - Important, do soon
- 📋 **Medium** - Should be done
- 💭 **Low** - Nice to have

**Queue Health Thresholds:**

- **HEALTHY**: 7+ total actionable tasks
- **LOW**: 4-7 total actionable tasks
- **CRITICAL**: ≤3 total actionable tasks
- **DEPLETED**: 0 actionable tasks

### AI-Human Collaboration Pattern

When task queue runs low:

1. **AI Detects Low Queue**: Copilot notices few remaining tasks in `.adt/project-context/tasks.md`
2. **AI Generates Proposals**: Create proposals in `.adt/project-context/queue-proposals/` with:
   - Context-aware task suggestions
   - Priority recommendations with rationale
   - Effort estimates and dependencies
3. **Human Reviews**: Human reviews proposals, approves/modifies/rejects
4. **Queue Replenishment**: Approved tasks added to `.adt/project-context/tasks.md`

### Proposal Format

When generating task proposals, use this structure in `.adt/project-context/queue-proposals/YYYY-MM-DD-proposals.md`:

```markdown
## Proposal: [Task Title]

**Priority**: 🔥|⚡|📋|💭
**Effort**: X hours/days
**Rationale**: Why this is needed now
**Dependencies**: List of prerequisites
**Risks**: Potential issues to consider

### Implementation Approach

[Brief description of how to implement]
```

## Code Quality Standards

- Write clear, maintainable code with comments for complex logic
- Follow existing project patterns and conventions
- Write tests for new functionality
- Update documentation when changing behavior
- Consider edge cases and error handling
- Prefer explicit, readable code over clever shortcuts

### File Operations Best Practices

- Create files intentionally — avoid unnecessary file generation
- Prefer targeted edits over full file replacements
- Handle shell-specific syntax correctly (PowerShell vs Bash)
- For long terminal output, use filters (`Select-Object`, `Where-Object`, `-First`, `-Last`)

## Communication Style

- **Be explicit** about what you're doing and why
- **Document decisions** in `decisions.md` with reasoning
- **Ask questions** when requirements are unclear
- **Update context** continuously as you learn
- Keep responses concise for simple queries, expand for complex tasks
- Confirm completions briefly without over-explaining

### Progress Updates (for multi-step tasks)

For tasks taking >15 minutes, provide periodic updates using this format:

```
Progress : what changed
Next step: single upcoming action
Needs    : blockers / approvals required
```

## Complex Task Protocol

When working on multi-step tasks, use the built-in `manage_todo_list` tool:

1. **Plan**: Break work into specific, actionable steps
2. **Track**: Mark tasks as `in-progress` before starting
3. **Update**: Mark tasks `completed` immediately when done
4. **Communicate**: Keep user informed of progress

### Session Continuity

When resuming work after interruption:

1. Check for in-progress tasks via `manage_todo_list`
2. Summarize what was last being worked on
3. Ask: _"Resume this task or make adjustments?"_
4. Wait for confirmation before proceeding

---

## Task Addition Protocol

When the user explicitly adds a task (especially high-priority items), follow the **dual-recording approach**:

### Dual Recording Steps

1. **Immediate**: Add to `manage_todo_list` tool for active session tracking

   - Use for tasks you'll work on immediately or in current session
   - Provides real-time visibility during conversation
   - Helps track multi-step implementation progress

2. **Persistent**: Add to `.adt/project-context/tasks.md` under appropriate priority
   - Ensures task survives the session
   - Makes it visible to other developers and AI agents
   - Contributes to queue health monitoring
   - Required for multi-agent coordination

### When to Use Each System

**Use `manage_todo_list` only:**

- Breaking down work you're actively doing right now
- Temporary planning for current session
- Implementation steps for a task already in `tasks.md`

**Use `tasks.md` only:**

- Recording ideas for future work
- Tasks you're not starting immediately
- Updating existing task status or claims

**Use BOTH (dual-recording):**

- User explicitly assigns you a high-priority task
- You're starting work on a task from `tasks.md` immediately
- Converting a user request into actionable work

### Example Flow

```
User: "Add this as highest priority to your todo list: Fix the login bug"

AI Response:
1. Add to manage_todo_list (for immediate tracking)
2. Add to tasks.md under "⚡ High Priority"
3. Confirm both recordings with user
4. Begin work if user expects immediate action
```

---

## User Feedback Handling

When receiving user feedback or new requirements:

1. **Don't implement immediately** - Understand and plan first
2. **Document requirements** in `.adt/project-context/decisions.md` with rationale
3. **Create task proposals** in `.adt/project-context/queue-proposals/` directory
4. **Wait for human review** before implementing
5. **Update context files** throughout implementation

## Bug Discovery

When discovering bugs or issues:

1. **Document in `.adt/project-context/status.md`** under "Known Issues"
2. **Create task proposal** for non-critical bugs
3. **For critical bugs**: Fix immediately but document decision in `.adt/project-context/decisions.md`
4. **Update tests** to prevent regression

## Integration with VS Code

This project may have VS Code tasks configured. Use:

- `pwsh .adt/project-context/check-queue.ps1` - Check queue health
- `pwsh .adt/project-context/propose-tasks.ps1` - Generate AI task proposals

## Technology Preferences

When making technology choices (if not already established), prefer:

| Category          | Preference                                             |
| ----------------- | ------------------------------------------------------ |
| **Shell**         | PowerShell (`pwsh`) over Bash unless project uses Bash |
| **Code Style**    | Follow existing project conventions                    |
| **Comments**      | Meaningful comments for complex logic                  |
| **Testing**       | Write tests for new functionality                      |
| **Documentation** | Update docs when changing behavior                     |

## Multi-Agent Coordination

This system is designed to work seamlessly for **1 to N agents** without configuration changes.

### Agent Registration

When starting work (even as solo agent):

- Add yourself to `.adt/project-context/active-agents.md`
- Use format: `agent-<timestamp>` or `<username>-<context>` as your ID
- Update status field as work progresses (Active/Paused/Blocked/Complete)

### Task Claiming Protocol

**Before starting any task:**

1. Verify task shows `Claimed: Unassigned` in `.adt/project-context/tasks.md`
2. Update `Claimed` field with your agent ID
3. Change checkbox from `[ ]` to `[>]` when actively working
4. When complete, mark `[x]` (this releases the claim automatically)

**If task already claimed:**

- Check `.adt/project-context/active-agents.md` to see if claiming agent is still active
- If agent is Paused/Blocked >30min, task may be available for handoff
- Add handoff note in task before claiming

### Partition Awareness

Check `.adt/project-context/work-partitions.md` before starting work:

- **Assigned Partition**: If partition assigned to you, you have full ownership
- **Shared Resources**: Check list before modifying shared files (config, types, docs)
- **Unassigned Areas**: Available for any agent to claim
- **Conflict Resolution**: If conflict arises, document in partition file and coordinate

### Conflict Avoidance

- **Read before edit**: Check file modification time before editing
- **Granular commits**: Commit frequently to reduce merge conflicts
- **Communication**: Update `.adt/project-context/active-agents.md` status when switching focus
- **Partition respect**: Don't modify files in another agent's partition without coordination

### Coordination Frequency

- **Update `.adt/project-context/active-agents.md`**: Every session start/end, status change
- **Check `.adt/project-context/tasks.md` claims**: Before picking new task
- **Review `.adt/project-context/work-partitions.md`**: When starting new feature area
- **Monitor `.adt/project-context/session-log.md`**: Check recent entries to see what others are doing

### Solo Agent Mode

When working alone, the coordination system still helps:

- **Self-registration** provides session tracking
- **Task claiming** shows your current focus
- **Partitions** help maintain work boundaries and focus areas
- **Agent status** tracks your own state across sessions

The system scales naturally — coordination overhead only appears when multiple agents are actually active.

## Key Principles

1. **Context is King**: Always read context files before starting work
2. **Document Decisions**: Explain why, not just what
3. **Maintain Queue Health**: Keep task queue healthy with 7+ items
4. **Human Oversight**: Major decisions require human approval
5. **Continuous Updates**: Update context files as you work, not just at end
6. **Stop and Ask**: Pause for guidance when encountering stop conditions
7. **Track Progress**: Use built-in tools for multi-step tasks
8. **Coordinate Actively**: Register, claim tasks, respect partitions (scales naturally from 1 to N agents)

---

_This project uses a simplified context management system designed to work seamlessly with GitHub Copilot's native capabilities._
