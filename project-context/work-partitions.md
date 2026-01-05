# Work Partitions

**Last Updated**: [YYYY-MM-DD HH:MM]

---

## Overview

Work partitions help prevent conflicts by defining clear areas of responsibility. This is useful whether you have one agent (helps maintain focus) or multiple agents (prevents stepping on each other's toes).

---

## Active Partitions

### [Agent ID / Focus Area 1]

**Owner**: [Agent ID or name]  
**Active**: [YYYY-MM-DD] to [ongoing/date]

**Primary Areas:**

- `/path/to/directory/**`
- `/path/to/another/area/**`
- Specific files: `src/specific-file.ts`

**Shared Areas (Coordinate Before Editing):**

- `/shared/types/**` - Shared type definitions
- `/shared/config/**` - Configuration files
- `README.md` - Documentation

**Off-Limits (Owned by Others):**

- `/other/agent/area/**` - Assigned to [other-agent-id]

**Notes:**

- [Any special considerations]
- [Dependencies or coordination needs]

---

### [Agent ID / Focus Area 2]

**Owner**: [Agent ID or name]  
**Active**: [YYYY-MM-DD] to [ongoing/date]

**Primary Areas:**

- [List of directories/files]

**Shared Areas:**

- [List of shared resources]

**Off-Limits:**

- [List of other agents' areas]

---

## Shared Resources (Require Coordination)

| Resource             | Type          | Coordination Method         | Current Owner |
| -------------------- | ------------- | --------------------------- | ------------- |
| `/src/types/**`      | Shared types  | Document in decisions.md    | All           |
| `/config/**`         | Configuration | Announce in session-log.md  | All           |
| `README.md`          | Documentation | Update in PR/commit message | All           |
| `/src/api/client.ts` | API client    | Coordinate in decisions.md  | Backend       |

---

## Partition Guidelines

### For Single Agent

Even when working alone, partitions help you:

- **Maintain focus**: "Today I'm only touching frontend"
- **Avoid scope creep**: Clear boundaries keep you on task
- **Track progress**: Easy to see what areas are complete
- **Plan sessions**: "This session = authentication module"

**Example Solo Partition:**

```markdown
### Main Development Session

**Owner**: me
**Focus**: Authentication feature

**Primary Areas:**

- `/src/auth/**` - Auth module
- `/src/components/Login/**` - Login UI

**Defer to Later:**

- `/src/api/other-endpoints/**` - Not touching today
- `/docs/**` - Will update after feature complete
```

### For Multiple Agents

Partitions prevent conflicts by:

- **Clear ownership**: Everyone knows their area
- **Reduced merge conflicts**: Separate directories
- **Parallel work**: Agents work independently
- **Clear handoff points**: Shared areas are explicit

**Multi-Agent Strategy:**

1. **Divide by Layer**: Frontend | Backend | Testing | DevOps
2. **Divide by Feature**: Auth | Payments | Analytics | Admin
3. **Divide by Module**: Core | Plugins | Integrations | Utils
4. **Divide by Type**: API | UI | Data | Infrastructure

---

## Conflict Resolution Protocol

### If You Need to Edit Another Agent's Area

1. **Check active-agents.md**: Is the agent currently working?
2. **Check session-log.md**: What are they doing right now?
3. **Coordinate**:
   - **If urgent**: Add note to decisions.md with `@agent-id` mention
   - **If not urgent**: Add task to tasks.md for them to review
   - **If major change**: Wait for their session to end and coordinate

### Shared File Changes

Before editing shared files:

1. **Announce intent** in decisions.md or session-log.md
2. **Wait 5-10 minutes** for other agents to see and respond
3. **Make changes with clear commit messages**
4. **Update documentation** explaining the change

### Merge Conflict Resolution

If conflicts occur despite partitions:

1. **Manual resolution**: Human reviews and resolves
2. **Document resolution** in decisions.md with rationale
3. **Update partitions** if conflicts keep happening
4. **Adjust agent assignments** if needed

---

## Partition Strategies

### Strategy 1: Vertical Slices (Recommended for Features)

Each agent owns complete features:

```
Agent 1: User Authentication
- /src/auth/** (backend)
- /src/components/Login/** (frontend)
- /tests/auth/** (tests)

Agent 2: User Profile
- /src/profile/** (backend)
- /src/components/Profile/** (frontend)
- /tests/profile/** (tests)
```

**Pros**: Complete ownership, minimal coordination  
**Cons**: Requires balanced feature sizing

### Strategy 2: Horizontal Layers (Recommended for Technical Work)

Each agent owns technical layers:

```
Agent 1: Frontend
- /src/components/**
- /src/pages/**
- /src/styles/**

Agent 2: Backend
- /src/api/**
- /src/models/**
- /src/services/**

Agent 3: Testing
- /tests/**
- /e2e/**
```

**Pros**: Clear technical boundaries, expertise-based  
**Cons**: Requires more coordination at interfaces

### Strategy 3: Hybrid Approach (Best for Complex Projects)

Mix of vertical and horizontal:

```
Agent 1: Core Frontend (horizontal)
- /src/components/core/**
- /src/layouts/**

Agent 2: Feature: Payments (vertical)
- /src/api/payments/**
- /src/components/Payments/**

Agent 3: Infrastructure (horizontal)
- /config/**
- /scripts/**
- CI/CD pipelines
```

**Pros**: Flexible, matches team structure  
**Cons**: Requires thoughtful planning

---

## Example Partitions

### Example 1: Solo Developer

```markdown
## Current Session Focus

**Owner**: me
**Focus**: User authentication
**Date**: 2025-11-01

**Primary Areas:**

- `/src/auth/**` - Complete ownership
- `/src/components/Login/**` - Complete ownership
- `/tests/auth/**` - Complete ownership

**Avoiding Today:**

- `/src/api/payments/**` - Will break into separate session
- `/docs/**` - Update at end of week
```

### Example 2: Two AI Agents

```markdown
## Frontend Agent

**Owner**: agent-frontend
**Focus**: User interface

**Primary Areas:**

- `/src/components/**`
- `/src/pages/**`
- `/src/styles/**`

**Shared Areas:**

- `/src/types/**` - Read-only, coordinate changes

**Off-Limits:**

- `/src/api/**` - Backend agent's area

---

## Backend Agent

**Owner**: agent-backend
**Focus**: API services

**Primary Areas:**

- `/src/api/**`
- `/src/models/**`
- `/src/services/**`

**Shared Areas:**

- `/src/types/**` - Coordinate with frontend

**Off-Limits:**

- `/src/components/**` - Frontend agent's area
```

### Example 3: Feature Team (3+ Agents)

```markdown
## Auth Feature Lead

**Owner**: agent-auth
**Focus**: Complete auth feature

**Primary Areas:**

- `/src/auth/**` (all files)
- `/src/components/Auth/**`
- `/tests/auth/**`

## Payments Feature Lead

**Owner**: agent-payments
**Focus**: Complete payment feature

**Primary Areas:**

- `/src/payments/**`
- `/src/components/Payments/**`
- `/tests/payments/**`

## Shared Infrastructure

**Owner**: agent-infra
**Focus**: Shared services

**Primary Areas:**

- `/src/services/common/**`
- `/src/utils/**`
- `/config/**`

**Note**: All feature agents use but don't modify
```

---

## Best Practices

1. **Start Broad, Refine Over Time**

   - Begin with large partitions
   - Split if conflicts occur
   - Merge if coordination overhead is high

2. **Make Shared Areas Explicit**

   - List all shared resources
   - Define coordination method for each
   - Keep shared areas minimal

3. **Update Partitions as Work Evolves**

   - Reassign completed areas
   - Adjust based on actual work patterns
   - Don't be rigid - adapt to reality

4. **Use for Planning, Not Just Prevention**

   - Partitions help plan sprints
   - Show what's actively being worked
   - Visualize progress by area

5. **Document Ownership Transfers**
   - When handing off an area, update this file
   - Add handoff notes in session-log.md
   - Ensure new owner has context

---

_Partitions scale naturally from 1 agent (focus) to N agents (conflict prevention)_
