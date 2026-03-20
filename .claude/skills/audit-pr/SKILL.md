---
name: audit-pr
description: Audits a pull request for data changes, code quality, architecture, and correctness. Use when asked to review or audit a PR.
argument-hint: [pr-number]
allowed-tools: Bash(git *), Bash(gh *), Bash(wc *), Read, Grep, Glob, Agent, WebSearch
context: fork
---

# PR Audit

ultrathink

Perform a thorough, read-only audit of PR $ARGUMENTS. Do NOT make any changes.


### A. [Category] Changes

(One section per category with changes.
Data: table of actual value changes.
Code: architectural impact.)

---

### B. Issues Found

#### Severity: HIGH (confidence: verified)
(Correctness bugs, security vulnerabilities, data loss risks)

#### Severity: MEDIUM
(Logic concerns, missing validation, cross-implementation inconsistencies)

#### Severity: LOW
(Style, minor duplication, missing edge case handling)

| # | Issue | Confidence | Details |
|---|-------|------------|---------|

(Omit empty severity levels.)

---

### C. What's Good

(Good patterns, improved safety, clean refactors)

---

### D. Numerical Precision Assessment

(Only if PR touches calculations/statistics/numerical code.)

---

### E. Recommendation

(One paragraph: must-fix before merge vs optional.)
```

## Rules

- READ-ONLY audit. Never use Edit, Write, or NotebookEdit.
- **FULLY AUTONOMOUS.** All read-only tools pre-authorized. No AskUserQuestion. If denied, skip and continue.
- **Google Drive access granted.** Mounted at `/Users/erdeylaszlo/Library/CloudStorage/GoogleDrive-erdeyl@erdey.info/`. Read-only.
- **Subagents inherit permissions.** Instruct them to proceed without asking.
- **Prefer dedicated tools.** Read over `cat`, Grep over `grep`, Glob over `find`.
- Report facts with file:line. Normalize formatting diffs before flagging data value changes.
- Be concise. Don't pad with generic advice.
