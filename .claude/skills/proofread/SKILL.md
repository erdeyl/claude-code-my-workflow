---
name: proofread
description: Run the proofreading protocol on lecture files. Checks grammar, typos, overflow, consistency, and academic writing quality. Produces a report without editing files.
argument-hint: "[filename or 'all']"
context: fork
allowed-tools: ["Read", "Grep", "Glob", "Write", "Agent"]
---

# Proofread Lecture Files

Run the mandatory proofreading protocol on lecture files. This produces a report of all issues found WITHOUT editing any source files.

## Steps

1. **Identify files to review:**
   - If `$ARGUMENTS` is a specific filename: review that file only
   - If `$ARGUMENTS` is "all": review all lecture files in `Slides/` and `Quarto/`

2. **For each file, launch a proofreader agent.** When reviewing multiple files (e.g., `$ARGUMENTS` is "all"), launch **all agents simultaneously using the Agent tool with `run_in_background: true`**. Collect results from all agents using TaskOutput as they complete.

   Each agent prompt MUST include:
   - The full file path and file type (.tex or .qmd)
   - The proofreading checklist below
   - This instruction: "This is a READ-ONLY review. Do NOT edit source files. Save your report to the specified path. Do NOT use AskUserQuestion."

   Report: "Step 2: [N] proofreader agents launched in background. Waiting for results..."
   As agents complete, report: "Step 2: [N]/[total] files complete."

   **Agent failure handling:** If any agent fails, continue with remaining agents. After all complete, retry failed agents once.

   Each agent checks for:

   **GRAMMAR:** Subject-verb agreement, articles (a/an/the), prepositions, tense consistency
   **TYPOS:** Misspellings, search-and-replace artifacts, duplicated words
   **OVERFLOW:** Overfull hbox (LaTeX), content exceeding slide boundaries (Quarto)
   **CONSISTENCY:** Citation format, notation, terminology
   **ACADEMIC QUALITY:** Informal language, missing words, awkward constructions

3. **Produce a detailed report** for each file listing every finding with:
   - Location (line number or slide title)
   - Current text (what's wrong)
   - Proposed fix (what it should be)
   - Category and severity

4. **Save each report** to `quality_reports/`:
   - For `.tex` files: `quality_reports/FILENAME_report.md`
   - For `.qmd` files: `quality_reports/FILENAME_qmd_report.md`

5. **IMPORTANT: Do NOT edit any source files.**
   Only produce the report. Fixes are applied separately after user review.

6. **Present summary** to the user:
   - Total issues found per file
   - Breakdown by category
   - Most critical issues highlighted
