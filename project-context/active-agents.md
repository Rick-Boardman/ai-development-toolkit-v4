# Active Agents

**Last Updated**: [YYYY-MM-DD HH:MM]

---

## Currently Active Agents

| Agent ID | Started | Working On | Focus Area | Last Update | Status |
| -------- | ------- | ---------- | ---------- | ----------- | ------ |
| -        | -       | -          | -          | -           | -      |

**Status Codes:**

- 🟢 **Active** - Currently working
- 🟡 **Paused** - Temporarily away but returning
- 🔴 **Blocked** - Waiting on something
- ✅ **Complete** - Finished for this session

---

## Agent Registration

### When Starting Work

1. Add your entry to the table above
2. Specify your focus area (helps prevent conflicts)
3. Update timestamp
4. Set status to 🟢 Active

### During Work

- Update "Last Update" timestamp every 15-30 minutes
- Change "Working On" as you switch tasks
- Update status if blocked or pausing

### When Stopping

- Set status to ✅ Complete
- Add final notes in session-log.md
- Move your row to "Recent Sessions" below

---

## Recent Sessions (Last 24 Hours)

| Agent ID | Date | Worked On | Duration | Key Accomplishments |
| -------- | ---- | --------- | -------- | ------------------- |
| -        | -    | -         | -        | -                   |

---

## Coordination Guidelines

### For Single Agent

- Register yourself at session start
- Helps maintain clear session boundaries
- Useful for tracking your own focus areas
- Good practice even when working alone

### For Multiple Agents

**Avoid Conflicts:**

- Check this file before starting work
- Claim focus areas in work-partitions.md
- Coordinate on shared files via decisions.md
- Update frequently so others see your progress

**Communication:**

- Use session-log.md for detailed updates
- Use decisions.md for technical coordination
- Use status.md for blockers affecting others
- Tag other agents in notes when coordination needed

**Handoffs:**

- Complete your session-log.md entry before stopping
- Update tasks.md with progress
- Note any blockers or next steps
- Deregister from this file (move to Recent Sessions)

---

## Quick Reference

**Agent IDs:** Use descriptive names

- Solo work: `main`, `dev`, or your name
- Multi-agent: `agent-frontend`, `agent-backend`, `agent-testing`, etc.
- Human + AI: `human-alice`, `ai-copilot-1`, etc.

**Focus Areas:** Match work-partitions.md

- Frontend, Backend, Testing, DevOps, Docs, etc.
- Or specific modules: Auth, Payments, Analytics
- Be specific to avoid conflicts

**Update Frequency:**

- Active work: Every 15-30 minutes
- Long-running tasks: At logical breakpoints
- Before touching shared files
- Before ending session

---

## Example Entry

| Agent ID       | Started | Working On            | Focus Area       | Last Update | Status    |
| -------------- | ------- | --------------------- | ---------------- | ----------- | --------- |
| agent-frontend | 09:00   | Login form validation | Frontend UI      | 10:30       | 🟢 Active |
| agent-backend  | 09:15   | Rate limiting API     | Backend services | 10:25       | 🟡 Paused |

---

_This file enables seamless coordination from 1 agent to N agents without reconfiguration_
