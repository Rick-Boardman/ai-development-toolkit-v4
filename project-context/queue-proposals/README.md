# Queue Proposals Directory

This directory contains AI-generated task proposals for queue replenishment. When the task queue in `tasks.md` runs low, AI can generate proposals here for human review.

## Purpose

- **Prevent Queue Depletion**: Keep development moving with fresh, contextual tasks
- **AI-Human Collaboration**: AI proposes, human approves
- **Quality Assurance**: Human oversight ensures strategic alignment

## Workflow

### 1. AI Detects Low Queue

AI notices task queue is running low (< 7 actionable tasks)

### 2. AI Generates Proposals

AI creates a dated proposal file: `YYYY-MM-DD-proposals.md`

### 3. Human Reviews

Human reviews proposals, marks for approval/rejection/modification

### 4. Queue Replenishment

Approved tasks are added to `.adt/project-context/tasks.md`

## Proposal File Naming

Format: `YYYY-MM-DD-proposals.md`

Examples:

- `2025-11-01-proposals.md`
- `2025-11-15-proposals.md`

## Proposal Template

```markdown
# Task Proposals - [Date]

**Generated**: [YYYY-MM-DD HH:MM]
**Context**: [Brief description of current project state]
**Queue Health**: [Current health status]

---

## Proposal 1: [Task Title]

**Priority**: 🔥|⚡|📋|💭
**Effort**: X hours/days
**Status**: ⏳ Pending Review | ✅ Approved | ❌ Rejected | 📝 Modified

**Rationale**:
[Why this task is important now - what problem does it solve?]

**Implementation Approach**:
[Brief description of how to implement this]

**Dependencies**:

- [Prerequisite 1]
- [Prerequisite 2]

**Risks/Considerations**:
[Potential issues or things to watch out for]

**Human Notes**:
[Space for human reviewer to add comments]

---

## Proposal 2: [Task Title]

...
```

## Review Guidelines

When reviewing proposals:

- **Approve** (✅): Task is good as-is, add to tasks.md
- **Modify** (📝): Good idea but needs adjustment, edit and approve
- **Reject** (❌): Not appropriate right now, document why
- **Defer** (💭): Good idea but wrong timing, move to "Future Considerations"

## Quality Criteria

Good proposals should have:

- Clear, actionable task description
- Appropriate priority level
- Realistic effort estimate
- Strong rationale tied to project needs
- Practical implementation approach
- Identified dependencies and risks

## After Review

1. Add approved tasks to `.adt/project-context/tasks.md` under appropriate priority
2. Archive proposal file (keep for reference)
3. Update queue health status in `.adt/project-context/tasks.md`

---

_This system ensures the task queue stays healthy while maintaining human strategic oversight_
