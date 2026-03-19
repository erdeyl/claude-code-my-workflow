---
name: slide-excellence
description: Multi-agent slide review (visual, pedagogy, proofreading). Use for comprehensive quality check before milestones.
argument-hint: "[QMD or TEX filename]"
context: fork
allowed-tools: ["Read", "Grep", "Glob", "Write", "Agent"]
---

# Slide Excellence Review

Run a comprehensive multi-dimensional review of lecture slides. Multiple agents analyze the file independently, then results are synthesized.

## Steps

### 1. Identify the File

Parse `$ARGUMENTS` for the filename. Resolve path in `Quarto/` or `Slides/`.

### 2. Run Review Agents in Parallel

Launch **all applicable agents simultaneously using the Agent tool with `run_in_background: true`**. Collect results from all agents using TaskOutput as they complete.

Each agent prompt MUST include:
- The full file path and file type (.qmd or .tex)
- The specific review dimension instructions (copied from below)
- This instruction: "This is a READ-ONLY review. Do NOT use Edit or Write to modify source files. Save your report to the specified path. Do NOT use AskUserQuestion. All file reads, glob searches, and grep searches are pre-authorized."

Report: "Step 2: [N] review agents launched in background. Waiting for results..."
As agents complete, report: "Step 2: [N]/[total] reviews complete."

**Agent failure handling:** If any agent fails to launch or crashes:
1. Log the failure: agent name and error message
2. Continue with remaining agents — do NOT abort
3. After all other agents complete, attempt ONE retry of the failed agent
4. If the retry also fails, note the missing dimension in the report

**Agent 1: Visual Audit** (slide-auditor)
- Overflow, font consistency, box fatigue, spacing, images
- Save: `quality_reports/[FILE]_visual_audit.md`

**Agent 2: Pedagogical Review** (pedagogy-reviewer)
- 13 pedagogical patterns, narrative, pacing, notation
- Save: `quality_reports/[FILE]_pedagogy_report.md`

**Agent 3: Proofreading** (proofreader)
- Grammar, typos, consistency, academic quality, citations
- Save: `quality_reports/[FILE]_report.md`

**Agent 4: TikZ Review** (only if file contains TikZ)
- Label overlaps, geometric accuracy, visual semantics
- Save: `quality_reports/[FILE]_tikz_review.md`

**Agent 5: Content Parity** (only for .qmd files with corresponding .tex)
- Frame count comparison, environment parity, content drift
- Save: `quality_reports/[FILE]_parity_report.md`

**Agent 6: Substance Review** (optional, for .tex files)
- Domain correctness via domain-reviewer protocol
- Save: `quality_reports/[FILE]_substance_review.md`

### 3. Synthesize Combined Summary

```markdown
# Slide Excellence Review: [Filename]

## Overall Quality Score: [EXCELLENT / GOOD / NEEDS WORK / POOR]

| Dimension | Critical | Medium | Low |
|-----------|----------|--------|-----|
| Visual/Layout | | | |
| Pedagogical | | | |
| Proofreading | | | |

### Critical Issues (Immediate Action Required)
### Medium Issues (Next Revision)
### Recommended Next Steps
```

## Quality Score Rubric

| Score | Critical | Medium | Meaning |
|-------|----------|--------|---------|
| Excellent | 0-2 | 0-5 | Ready to present |
| Good | 3-5 | 6-15 | Minor refinements |
| Needs Work | 6-10 | 16-30 | Significant revision |
| Poor | 11+ | 31+ | Major restructuring |
