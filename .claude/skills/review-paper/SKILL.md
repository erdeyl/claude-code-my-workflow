---
name: review-paper
description: Comprehensive manuscript review covering argument structure, econometric specification, citation completeness, and potential referee objections
argument-hint: "[paper filename in documents/ or path to .tex/.pdf]"
allowed-tools: Read, Grep, Glob, Write, Bash(touch *), Bash(find *), Agent, WebSearch
context: fork
---

# Manuscript Review

ultrathink


Produce a thorough, constructive review of an academic manuscript — the kind of report a top-journal referee would write.

**Input:** `$ARGUMENTS` — path to a paper (.tex, .pdf, or .qmd), or a filename in a documents directory.

## Parallel Review Dimensions (Fan-Out / Fan-In)

Launch 4 parallel agents for independent review, then fan-in for validation:

### Agent 1: Argument Structure (Sonnet)
- Is the research question clearly stated?
- Does the introduction motivate the question effectively?
- Is the logical flow sound (question -> method -> results -> conclusion)?
- Are the conclusions supported by the evidence?
- Are limitations acknowledged?

### Agent 2: Econometric Specification (Opus)
- Is the causal claim credible? Key identifying assumptions stated?
- Correct standard errors (clustered? robust? bootstrap?)?
- Appropriate functional form? Sample selection issues?
- Multiple testing concerns?
- Are point estimates economically meaningful?
- Robustness checks adequate?

### Agent 3: Literature Coverage (Sonnet)
- Are the key papers cited?
- Is prior work characterized accurately?
- Is the contribution clearly differentiated from existing work?
- Any missing citations that a referee would flag?

### Agent 4: Writing Quality (Haiku)
- Clarity and concision
- Academic tone and consistent notation
- Abstract effectiveness
- Tables and figures self-contained
- Typos, grammatical errors, formatting issues

### Fan-In: Validation Pass (Main Context)
Synthesize all 4 agent reports into a unified review. Resolve any contradictions between agents. Generate 3-5 "referee objections" — the tough questions a top referee would ask.

---

## Steps

1. **Locate and read the manuscript.** Check:
   - Direct path from `$ARGUMENTS`
   - Auto-detect in `master_supporting_docs/`, `documents/`, `papers/`
   - Glob for partial matches

2. **Read the full paper** end-to-end. For long PDFs, read in chunks (5 pages at a time).

3. **Launch 4 parallel review agents** as described above.

4. **Fan-in synthesis:** Generate unified review with referee objections.

5. **Save to** auto-detected output directory. Filename: `paper_review_[sanitized_name].md`

---

## Output Format

```markdown
# Manuscript Review: [Paper Title]

**Date:** [YYYY-MM-DD]
**Reviewer:** review-paper skill
**File:** [path to manuscript]

## Summary Assessment
**Overall recommendation:** [Strong Accept / Accept / Revise & Resubmit / Reject]
[2-3 paragraph summary]

## Strengths
1. [Strength 1]
2. [Strength 2]

## Major Concerns
### MC1: [Title]
- **Dimension:** [Identification / Econometrics / Argument / Literature / Writing]
- **Issue:** [Description]
- **Suggestion:** [How to address it]

## Minor Concerns
### mc1: [Title]

## Referee Objections
### RO1: [Question]
**Why it matters:** [Why this could be fatal]
**How to address it:** [Suggested response]

## Summary Statistics
| Dimension | Rating (1-5) |
|-----------|-------------|
| Argument Structure | [N] |
| Identification | [N] |
| Econometrics | [N] |
| Literature | [N] |
| Writing | [N] |
| Presentation | [N] |
| **Overall** | **[N]** |
```

---

## Principles

- **Be constructive.** Every criticism should come with a suggestion.
- **Be specific.** Reference exact sections, equations, tables.
- **Think like a referee at a top-5 journal.** What would make them reject?
- **Distinguish fatal flaws from minor issues.**
- **Acknowledge what's done well.**
- **Do NOT fabricate details.** If you can't read a section clearly, say so.
