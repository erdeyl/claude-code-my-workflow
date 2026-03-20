---
name: validate-bib
description: Validates bibliography entries against citations in all lecture files. Find missing entries and unused references.
argument-hint: "[optional: path to .bib file]"
allowed-tools: Read, Grep, Glob, Bash(touch *), Bash(find *), WebSearch
context: fork
agent: Explore
---

# Validate Bibliography

ultrathink


Cross-reference all citations in lecture files against bibliography entries.

## Steps

1. **Auto-detect bibliography file.** If `$ARGUMENTS` provided, use it. Otherwise scan for `*.bib` files in the repo root and common locations (`Bibliography_base.bib`, `references.bib`, etc.).

2. **Read the bibliography file** and extract all citation keys.

3. **Auto-detect lecture directories.** Scan `Slides/`, `Quarto/`, `decks/`, or current directory for `.tex` and `.qmd` files.

4. **Scan all lecture files for citation keys:**
   - `.tex` files: look for `\cite{`, `\citet{`, `\citep{`, `\citeauthor{`, `\citeyear{`
   - `.qmd` files: look for `@key`, `[@key]`, `[@key1; @key2]`
   - Extract all unique citation keys used

5. **Cross-reference:**
   - **Missing entries:** Citations used in lectures but NOT in bibliography
   - **Unused entries:** Entries in bibliography not cited anywhere
   - **Potential typos:** Similar-but-not-matching keys

6. **Check entry quality** for each bib entry:
   - Required fields present (author, title, year, journal/booktitle)
   - Author field properly formatted
   - Year is reasonable
   - No malformed characters or encoding issues

7. **Report findings:**
   - List of missing bibliography entries (CRITICAL)
   - List of unused entries (informational)
   - List of potential typos in citation keys
   - List of quality issues
