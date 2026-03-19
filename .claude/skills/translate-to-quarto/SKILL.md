---
name: translate-to-quarto
description: Translate a Beamer LaTeX lecture to Quarto RevealJS. Multi-phase workflow covering content translation, TikZ extraction, citation mapping, figure handling, overflow audit, and deployment.
disable-model-invocation: true
argument-hint: "[Beamer .tex filename, e.g., LectureN_Topic]"
allowed-tools: ["Read", "Grep", "Glob", "Write", "Edit", "Bash", "Agent"]
context: fork
---

# Beamer → Quarto Translation Workflow

Full translation of a Beamer LaTeX lecture to Quarto RevealJS HTML slides.

**CRITICAL: The Beamer .tex file is the SINGLE SOURCE OF TRUTH.**

---

## Phase 0: Pre-Flight Checks (Parallel)

Launch **4 pre-flight agents simultaneously using the Agent tool with `run_in_background: true`**. Collect results from all agents using TaskOutput as they complete.

Report: "Phase 0: 4 pre-flight agents launched in background. Waiting for results..."

**Agent failure handling:** If any agent fails, continue with remaining agents. Log the failure and address manually after other agents complete.

### 0A. Environment Parity Audit (Agent)
Scan Beamer for all custom environments. Verify CSS equivalents exist in your theme SCSS. Report any missing environments.

### 0B. TikZ Freshness Verification (Agent)
Compare TikZ blocks in Beamer source against `extract_tikz.tex`. Report if SVGs need regeneration.

### 0C. RDS Data Inventory (Agent)
List all RDS files needed for interactive charts. Verify they exist and report any missing files.

### 0D. Citation Key Mapping (Agent)
Extract all citations from Beamer, map to bibliography keys. Report any unresolved keys.

**After all 4 agents complete:** Address any missing CSS environments (0A) and regenerate TikZ SVGs (0B) BEFORE proceeding to Phase 1.

## Phase 1: Pre-Translation Preparation
- Read complete Beamer source, count frames
- Inventory figures (TikZ → SVG, R plots → plotly, other → SVG)

## Phase 2: Create QMD File with YAML Header
- Standard RevealJS YAML with theme, logo, footer, bibliography
- Setup chunk for R data loading if needed

## Phase 3: Slide-by-Slide Translation
- Delegate to `beamer-translator` agent
- 1:1 frame-to-slide mapping
- Verbatim math, environment parity, no font reduction

## Phase 4: TikZ Diagram Integration
Reference extracted SVGs with 0-based indexing.

## Phase 5: R Figure Integration (Plotly-First)
Interactive plotly from RDS data, static SVG for TikZ/complex figures.

## Phase 6: First Render & Content Fidelity Check
Render, count slides, go through EVERY slide checking for issues.

## Phase 6.5: Pedagogical Review
Run pedagogy-reviewer before visual polish.

## Phase 7: Visual Polish
Semantic colors, transition slides, framing sentences.

## Phase 8: Proofreading
Run `/proofread` on the QMD file.

## Phase 9: Final Verification & Deployment
Render, open in browser, verify all elements.

## Phase 10: Beamer Source Sync
Apply any corrections back to Beamer source.

## Phase 11: Documentation
Update CLAUDE.md, session log, create PR.
