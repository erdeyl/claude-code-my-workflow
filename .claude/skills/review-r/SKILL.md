---
name: review-r
description: Runs the R code review protocol on R scripts. Checks code quality, reproducibility, domain correctness, and professional standards. Produces a report without editing files.
argument-hint: "[filename or 'all' or 'LectureN']"
allowed-tools: Read, Grep, Glob, Write, Bash(touch *), Bash(find *), Agent, WebSearch
context: fork
---

# Review R Scripts

ultrathink


Run the comprehensive R code review protocol.

## Steps

1. **Identify scripts to review:**
   - If `$ARGUMENTS` is a specific `.R` filename: review that file only
   - If `$ARGUMENTS` is `LectureN`: review all R scripts matching that lecture
   - If `$ARGUMENTS` is `all`: review all R scripts (auto-detect in `scripts/R/`, `code/R/`, `Figures/*/`)

2. **For each script, launch the r-reviewer agent** with instructions to:
   - Follow the full protocol in the agent instructions
   - Read `.claude/rules/r-code-conventions.md` for current standards (if present)
   - Save report to auto-detected output directory

3. **After all reviews complete**, present a summary:
   - Total issues found per script
   - Breakdown by severity (Critical / High / Medium / Low)
   - Top 3 most critical issues

4. **IMPORTANT: Do NOT edit any R source files.**
   Only produce reports. Fixes are applied after user review.
