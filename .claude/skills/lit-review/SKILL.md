---
name: lit-review
description: Structured literature search and synthesis with citation extraction and gap identification
argument-hint: "[topic, paper title, or research question]"
allowed-tools: Read, Grep, Glob, Write, Bash(touch *), Bash(find *), Agent, WebSearch, WebFetch
context: fork
---

# Literature Review

ultrathink


Conduct a structured literature search and synthesis on the given topic.

**Input:** `$ARGUMENTS` — a topic, paper title, research question, or phenomenon to investigate.

## Parallel Search Pattern (Fan-Out / Fan-In)

Launch 2 parallel search agents, then synthesize findings:

### Agent 1: Local Repository Search (Sonnet)
- Search the project for uploaded papers: auto-detect `master_supporting_docs/`, `documents/`, `papers/`, or similar directories
- Grep/Glob for relevant content in existing `.bib` files, `.tex` files, `.qmd` files
- Extract citations and findings from any locally available papers

### Agent 2: Web Literature Search (Sonnet)
- Use `WebSearch` to find recent publications on the topic
- Use `WebFetch` to access working paper repositories (NBER, SSRN, arXiv, etc.)
- Search for key authors and recent survey articles
- Focus on last 5-10 years unless seminal papers are older

### Fan-In: Synthesis (Main Context)
Combine findings from both agents and organize into the structured output below.

---

## Steps

1. **Parse the topic** from `$ARGUMENTS`. If a specific paper is named, use it as the anchor.

2. **Launch parallel search agents** as described above.

3. **Organize findings** into these categories:
   - **Theoretical contributions** — models, frameworks, mechanisms
   - **Empirical findings** — key results, effect sizes, data sources
   - **Methodological innovations** — new estimators, identification strategies, inference methods
   - **Open debates** — unresolved disagreements in the literature

4. **Identify gaps and opportunities:**
   - What questions remain unanswered?
   - What data or methods could address them?
   - Where do findings conflict?

5. **Extract citations** in BibTeX format for all papers discussed.

6. **Save the report** to auto-detected output directory (`quality_reports/`, `notes/`, or current directory). Filename: `lit_review_[sanitized_topic].md`

---

## Output Format

```markdown
# Literature Review: [Topic]

**Date:** [YYYY-MM-DD]
**Query:** [Original query from user]

## Summary
[2-3 paragraph overview of the state of the literature]

## Key Papers

### [Author (Year)] — [Short Title]
- **Main contribution:** [1-2 sentences]
- **Method:** [Identification strategy / data]
- **Key finding:** [Result with effect size if available]
- **Relevance:** [Why it matters for our research]

[Repeat for 5-15 papers, ordered by relevance]

## Thematic Organization

### Theoretical Contributions
[Grouped discussion]

### Empirical Findings
[Grouped discussion with comparison across studies]

### Methodological Innovations
[Methods relevant to the topic]

## Gaps and Opportunities
1. [Gap 1 — what's missing and why it matters]
2. [Gap 2]
3. [Gap 3]

## Suggested Next Steps
- [Concrete actions: papers to read, data to obtain, methods to consider]

## BibTeX Entries
[BibTeX entries for all papers discussed]
```

---

## Important

- **Be honest about uncertainty.** If you cannot verify a citation, say so.
- **Prioritize recent work** (last 5-10 years) unless seminal papers are older.
- **Note working papers vs published papers** — working papers may change.
- **Do NOT fabricate citations.** If you're unsure about a paper's details, flag it for the user to verify.
