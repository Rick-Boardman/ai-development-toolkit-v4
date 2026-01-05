# Task Queue

**Last Updated**: [YYYY-MM-DD HH:MM]

---

## Queue Health Status

📊 **Current Health**: [HEALTHY | LOW | CRITICAL | DEPLETED]

| Priority    | Count | Threshold | Status          |
| ----------- | ----- | --------- | --------------- |
| 🔥 Critical | 0     | ≥ 1       | ⚠️              |
| ⚡ High     | 0     | ≥ 2       | ⚠️              |
| 📋 Medium   | 0     | ≥ 3       | ⚠️              |
| 💭 Low      | 0     | ≥ 5       | ⚠️              |
| **Total**   | **0** | **≥ 7**   | **❌ DEPLETED** |

**Action Needed**: Queue needs replenishment - generate proposals or review existing proposals

---

## 🔥 Critical Priority

_Items that must be done immediately - system broken or production issue_

- [ ] [Task description]
  - **Effort**: [X hours/days]
  - **Claimed**: [Unassigned | agent-id]
  - **Notes**: [Any important context]

**Agent Claiming:**

- Mark as `[>]` when starting: `- [>] Task in progress - agent-frontend`
- Mark as `[x]` when complete: `- [x] Task completed - agent-frontend`

---

## ⚡ High Priority

_Important tasks that should be done soon_

- [ ] [Task description]

  - **Effort**: [X hours/days]
  - **Claimed**: [Unassigned | agent-id]
  - **Notes**: [Any important context]

- [ ] [Task description]
  - **Effort**: [X hours/days]
  - **Claimed**: [Unassigned | agent-id]
  - **Notes**: [Any important context]

---

## 📋 Medium Priority

_Tasks that should be done but aren't urgent_

- [ ] [Task description]

  - **Effort**: [X hours/days]
  - **Claimed**: [Unassigned | agent-id]
  - **Notes**: [Any important context]

- [ ] [Task description]

  - **Effort**: [X hours/days]
  - **Claimed**: [Unassigned | agent-id]
  - **Notes**: [Any important context]

- [ ] [Task description]
  - **Effort**: [X hours/days]
  - **Claimed**: [Unassigned | agent-id]
  - **Notes**: [Any important context]

---

## 💭 Low Priority

_Nice to have items and future improvements_

- [ ] [Task description]

  - **Effort**: [X hours/days]
  - **Claimed**: [Unassigned | agent-id]
  - **Notes**: [Any important context]

- [ ] [Task description]
  - **Effort**: [X hours/days]
  - **Claimed**: [Unassigned | agent-id]
  - **Notes**: [Any important context]

---

## ✅ Recently Completed

### [YYYY-MM-DD]

- [x] [Completed task] - [Who completed it]
- [x] [Completed task] - [Who completed it]

### [YYYY-MM-DD]

- [x] [Completed task] - [Who completed it]

---

## 🔮 Future Considerations

_Ideas and tasks for later - not in active queue_

- [Idea or future task]
- [Idea or future task]

---

## Task Guidelines

**Adding Tasks**:

- Use clear, actionable descriptions
- Include effort estimate
- Add relevant context in notes
- Assign appropriate priority

**Completing Tasks**:

- Mark with [x] when done
- Move to "Recently Completed" with date
- Update `status.md` if significant
- Log in `session-log.md`

**Priority Guidelines**:

- **🔥 Critical**: Production broken, security issue, blocking others
- **⚡ High**: Important features, major bugs, upcoming deadline
- **📋 Medium**: Planned features, minor bugs, improvements
- **💭 Low**: Nice-to-haves, documentation, refactoring

---

_Queue Health: Aim to maintain at least 7 actionable tasks across all priorities_
