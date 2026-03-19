---
name: review-r
description: Run the R code review protocol on R scripts. Checks code quality, reproducibility, domain correctness, and professional standards. Produces a report without editing files.
argument-hint: "[filename or 'all' or 'LectureN']"
context: fork
allowed-tools: ["Read", "Grep", "Glob", "Write", "Agent"]
---

# Review R Scripts

Run the comprehensive R code review protocol.

## Steps

1. **Identify scripts to review:**
   - If `$ARGUMENTS` is a specific `.R` filename: review that file only
   - If `$ARGUMENTS` is `LectureN`: review all R scripts matching that lecture
   - If `$ARGUMENTS` is `all`: review all R scripts in `scripts/R/` and `Figures/*/`

2. **For each script, launch an `r-reviewer` agent.** When reviewing multiple scripts (e.g., `$ARGUMENTS` is "all" or "LectureN"), launch **all agents simultaneously using the Agent tool with `run_in_background: true`**. Collect results from all agents using TaskOutput as they complete.

   Each agent prompt MUST include:
   - The full script path
   - Instruction to read `.claude/rules/r-code-conventions.md` for current standards
   - Instruction to follow the full r-reviewer protocol
   - This instruction: "This is a READ-ONLY review. Do NOT edit R source files. Save your report to `quality_reports/[script_name]_r_review.md`. Do NOT use AskUserQuestion."

   Report: "Step 2: [N] r-reviewer agents launched in background. Waiting for results..."
   As agents complete, report: "Step 2: [N]/[total] scripts complete."

   **Agent failure handling:** If any agent fails, continue with remaining agents. After all complete, retry failed agents once.

3. **After all reviews complete**, present a summary:
   - Total issues found per script
   - Breakdown by severity (Critical / High / Medium / Low)
   - Top 3 most critical issues

4. **IMPORTANT: Do NOT edit any R source files.**
   Only produce reports. Fixes are applied after user review.
