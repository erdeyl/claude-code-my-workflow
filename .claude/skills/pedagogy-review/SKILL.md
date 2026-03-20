---
name: pedagogy-review
description: Runs holistic pedagogical review on lecture slides. Checks narrative arc, student prerequisites, worked examples, notation clarity, and deck pacing.
argument-hint: "[QMD or TEX filename]"
allowed-tools: Read, Grep, Glob, Write, Bash(touch *), Bash(find *), Agent, WebSearch
context: fork
---

# Pedagogical Review of Lecture Slides

ultrathink


Perform a comprehensive pedagogical review.

## Steps

1. **Identify the file** specified in `$ARGUMENTS`
   - If no argument, ask user which lecture to review
   - Auto-detect in `Quarto/`, `Slides/`, `decks/`, or use as direct path

2. **Launch the pedagogy-reviewer agent** with the full file path
   - The agent checks 13 pedagogical patterns
   - Performs deck-level analysis (narrative arc, pacing, visual rhythm, notation)
   - Considers student perspective (prerequisites, objections)

3. **The agent produces a report** saved to auto-detected output directory (`quality_reports/` or current directory):
   `[FILENAME_WITHOUT_EXT]_pedagogy_report.md`

4. **Present summary to user:**
   - Patterns followed vs violated (out of 13)
   - Deck-level assessments
   - Critical recommendations (top 3-5)

## Important Notes

- This is a **read-only review** — no files are edited
- Focuses on **pedagogy** not visual layout (use `/visual-audit` for that)
- For a combined review, use `/slide-excellence` instead
