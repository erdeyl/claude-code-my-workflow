---
name: audit
description: Audits a codebase or specific directory for quality, security, architecture, and correctness. Use when asked to audit or review code quality.
argument-hint: [path-or-scope]
allowed-tools: Bash(git *), Bash(gh *), Bash(wc *), Bash(find *), Bash(du *), Read, Grep, Glob, Agent, WebSearch
context: fork
---

# Codebase Audit

ultrathink

Perform a thorough, read-only audit of the codebase. Do NOT make any changes.

If $ARGUMENTS is provided, scope the audit to that path or topic. Otherwise audit the entire project.


### A. Architecture Overview

(Brief description of components and data flow.
Include ASCII diagram if it helps clarity.)

---

### B. Findings

#### Severity: HIGH (confidence: verified)
(Correctness bugs, security vulnerabilities, data loss risks)

#### Severity: MEDIUM
(Architectural concerns, missing validation, inconsistencies)

#### Severity: LOW
(Style, minor duplication, documentation gaps)

| # | Category | Issue | Location | Confidence | Details |
|---|----------|-------|----------|------------|---------|

Categories: Security, Correctness, Numerical, Statistical, Architecture, Data, Reproducibility

(Omit empty severity levels.)

---

### C. Strengths

(Good patterns, solid testing, clean architecture)

---

### D. Numerical Precision Assessment

(Only if project performs calculations/statistics/quantitative work.
Methods used, precision adequacy, cross-implementation risks,
algebraic constraints to verify.)

---

### E. Recommendations

(Prioritized: what to fix first, what's optional)
```

## Rules

- READ-ONLY audit. Never use Edit, Write, or NotebookEdit. Never run file-modifying commands.
- **FULLY AUTONOMOUS.** All read-only tools pre-authorized. Do NOT use AskUserQuestion. If a tool is denied, skip and continue.
- **Google Drive access granted.** Mounted at `/Users/erdeylaszlo/Library/CloudStorage/GoogleDrive-erdeyl@erdey.info/`. Read-only.
- **Subagents inherit permissions.** Instruct them to proceed without asking.
- **Prefer dedicated tools.** Read over `cat`, Grep over `grep`, Glob over `find`. Bash only for git, gh, pipes, compound commands.
- Report facts with file:line references. No opinions.
- Don't report style preferences unless they cause real problems.
- Be concise. Skip empty categories.
- Scale depth to project size.
