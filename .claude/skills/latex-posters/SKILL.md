---
name: latex-posters
description: "Create professional research posters in LaTeX using beamerposter, tikzposter, or baposter. Support for conference presentations, academic posters, and scientific communication. Includes layout design, color schemes, multi-column formats, figure integration, and poster-specific best practices for visual communication."
allowed-tools: Read Write Edit Bash
---

# LaTeX Research Posters

## Overview

Research posters are a critical medium for scientific communication at conferences, symposia, and academic events. This skill provides comprehensive guidance for creating professional, visually appealing research posters using LaTeX packages. Generate publication-quality posters with proper layout, typography, color schemes, and visual hierarchy.

## When to Use This Skill

This skill should be used when:
- Creating research posters for conferences, symposia, or poster sessions
- Designing academic posters for university events or thesis defenses
- Preparing visual summaries of research for public engagement
- Converting scientific papers into poster format
- Creating template posters for research groups or departments
- Designing posters that comply with specific conference size requirements (A0, A1, 36×48", etc.)
- Building posters with complex multi-column layouts
- Integrating figures, tables, equations, and citations in poster format

## AI-Powered Visual Element Generation

**STANDARD WORKFLOW: Generate ALL major visual elements using AI before creating the LaTeX poster.**

This is the recommended approach for creating visually compelling posters:
1. Plan all visual elements needed (title, intro, methods, results, conclusions)
2. Generate each element using scientific-schematics or Nano Banana Pro
3. Assemble generated images in the LaTeX template
4. Add text content around the visuals

**Target: 60-70% of poster area should be AI-generated visuals, 30-40% text.**

---

### CRITICAL: Preventing Content Overflow

**⚠️ POSTERS MUST NOT HAVE TEXT OR CONTENT CUT OFF AT EDGES.**

**Common Overflow Problems:**
1. **Title/footer text extending beyond page boundaries**
2. **Too many sections crammed into available space**
3. **Figures placed too close to edges**
4. **Text blocks exceeding column widths**

**Prevention Rules:**

**1. Limit Content Sections (MAXIMUM 5-6 sections for A0):**
```
✅ GOOD - 5 sections with room to breathe:
   - Title/Header
   - Introduction/Problem
   - Methods
   - Results (1-2 key findings)
   - Conclusions

❌ BAD - 8+ sections crammed together:
   - Overview, Introduction, Background, Methods, 
   - Results 1, Results 2, Discussion, Conclusions, Future Work
```

**2. Set Safe Margins in LaTeX:**
```latex
% tikzposter - add generous margins
\documentclass[25pt, a0paper, portrait, margin=25mm]{tikzposter}

% baposter - ensure content doesn't touch edges
\begin{poster}{
  columns=3,
  colspacing=2em,           % Space between columns
  headerheight=0.1\textheight,  % Smaller header
  % Leave space at bottom
}
```

**3. Figure Sizing - Never 100% Width:**
```latex
% Leave margins around figures
\includegraphics[width=0.85\linewidth]{figure.png}  % NOT 1.0\linewidth
```

**4. Check for Overflow Before Printing:**
```bash
# Compile and check PDF at 100% zoom
pdflatex poster.tex

# Look for:
# - Text cut off at any edge
# - Content touching page boundaries  
# - Overfull hbox warnings in .log file
grep -i "overfull" poster.log
```

**5. Word Count Limits:**
- **A0 poster**: 300-800 words MAXIMUM
- **Per section**: 50-100 words maximum
- **If you have more content**: Cut it or make a handout

---

### CRITICAL: Poster-Size Font Requirements

**⚠️ ALL text within AI-generated visualizations MUST be poster-readable.**

When generating graphics for posters, you MUST include font size specifications in EVERY prompt. Poster graphics are viewed from 4-6 feet away, so text must be LARGE.

**⚠️ COMMON PROBLEM: Content Overflow and Density**

The #1 issue with AI-generated poster graphics is **TOO MUCH CONTENT**. This causes:
- Text overflow beyond boundaries
- Unreadable small fonts
- Cluttered, overwhelming visuals
- Poor white space usage

**SOLUTION: Generate SIMPLE graphics with MINIMAL content.**

**MANDATORY prompt requirements for EVERY poster graphic:**

```
POSTER FORMAT REQUIREMENTS (STRICTLY ENFORCE):
- ABSOLUTE MAXIMUM 3-4 elements per graphic (3 is ideal)
- ABSOLUTE MAXIMUM 10 words total in the entire graphic
- NO complex workflows with 5+ steps (split into 2-3 simple graphics instead)
- NO multi-level nested diagrams (flatten to single level)
- NO case studies with multiple sub-sections (one key point per case)
- ALL text GIANT BOLD (80pt+ for labels, 120pt+ for key numbers)
- High contrast ONLY (dark on white OR white on dark, NO gradients with text)
- MANDATORY 50% white space minimum (half the graphic should be empty)
- Thick lines only (5px+ minimum), large icons (200px+ minimum)
- ONE SINGLE MESSAGE per graphic (not 3 related messages)
```

**⚠️ BEFORE GENERATING: Review your prompt and count elements**
- If your description has 5+ items → STOP. Split into multiple graphics
- If your workflow has 5+ stages → STOP. Show only 3-4 high-level steps
- If your comparison has 4+ methods → STOP. Show only top 3 or Our vs Best Baseline

**Content limits per graphic type (STRICT):**
| Graphic Type | Max Elements | Max Words | Reject If | Good Example |
|--------------|--------------|-----------|-----------|--------------|
| Flowchart | **3-4 boxes MAX** | **8 words** | 5+ stages, nested steps | "DISCOVER → VALIDATE → APPROVE" (3 words) |
| Key findings | **3 items MAX** | **9 words** | 4+ metrics, paragraphs | "95% ACCURATE" "2X FASTER" "FDA READY" (6 words) |
| Comparison chart | **3 bars MAX** | **6 words** | 4+ methods, legend text | "OURS: 95%" "BEST: 85%" (4 words) |
| Case study | **1 case, 3 elements** | **6 words** | Multiple cases, substories | Logo + "18 MONTHS" + "to discovery" (2 words) |
| Timeline | **3-4 points MAX** | **8 words** | Year-by-year detail | "2020 START" "2022 TRIAL" "2024 APPROVED" (6 words) |

For detailed WRONG vs CORRECT prompt examples (workflows, case studies, key findings, ML pipelines), see `references/ai_visual_examples.md`.

**Font size reference for poster prompts:**
| Element | Minimum Size | Prompt Keywords |
|---------|--------------|-----------------|
| Main numbers/metrics | 72pt+ | "huge", "very large", "giant", "poster-size" |
| Section titles | 60pt+ | "large bold", "prominent" |
| Labels/captions | 36pt+ | "readable from 6 feet", "clear labels" |
| Body text | 24pt+ | "poster-readable", "large text" |

**Always include in prompts:**
- "POSTER FORMAT" or "for A0 poster" or "readable from 6 feet"
- "VERY LARGE TEXT" or "huge bold fonts"
- Specific text that should appear (so it's baked into the image)
- "minimal text, maximum impact"
- "high contrast" for readability
- "generous margins" and "no text near edges"

---

### CRITICAL: AI-Generated Graphic Sizing

**⚠️ Each AI-generated graphic should focus on ONE concept with MINIMAL content.**

**Problem**: Generating complex diagrams with many elements leads to small text.

**Solution**: Generate SIMPLE graphics with FEW elements and LARGE text.

**Example - WRONG (too complex, text will be small):**
```bash
# BAD - too many elements in one graphic
python scripts/generate_schematic.py "Complete ML pipeline showing data collection, 
preprocessing with 5 steps, feature engineering with 8 techniques, model training 
with hyperparameter tuning, validation with cross-validation, and deployment with 
monitoring. Include all labels and descriptions." -o figures/pipeline.png
```

**Example - CORRECT (simple, focused, large text):**
```bash
# GOOD - split into multiple simple graphics with large text

# Graphic 1: High-level overview (3-4 elements max)
python scripts/generate_schematic.py "POSTER FORMAT for A0: Simple 4-step pipeline. 
Four large boxes: DATA → PROCESS → MODEL → RESULTS. 
GIANT labels (80pt+), thick arrows, lots of white space. 
Only 4 words total. Readable from 8 feet." -o figures/overview.png

# Graphic 2: Key result (1 metric highlighted)
python scripts/generate_schematic.py "POSTER FORMAT for A0: Single key metric display.
Giant '95%' text (150pt+) with 'ACCURACY' below (60pt+).
Checkmark icon. Minimal design, high contrast.
Readable from 10 feet." -o figures/accuracy.png
```

**Rules for AI-generated poster graphics:**
| Rule | Limit | Reason |
|------|-------|--------|
| **Elements per graphic** | 3-5 maximum | More elements = smaller text |
| **Words per graphic** | 10-15 maximum | Minimal text = larger fonts |
| **Flowchart steps** | 4-5 maximum | Keeps labels readable |
| **Chart categories** | 3-4 maximum | Prevents crowding |
| **Nested levels** | 1-2 maximum | Avoids complexity |

**Split complex content into multiple simple graphics:**
```
Instead of 1 complex diagram with 12 elements:
→ Create 3 simple diagrams with 4 elements each
→ Each graphic can have LARGER text
→ Arrange in poster with clear visual flow
```

---

### Step 0: MANDATORY Pre-Generation Review (DO THIS FIRST)

**⚠️ BEFORE generating ANY graphics, review your content plan:**

**For EACH planned graphic, ask these questions:**
1. **Element count**: Can I describe this in 3-4 items or less?
   - ❌ NO → Simplify or split into multiple graphics
   - ✅ YES → Continue

2. **Complexity check**: Is this a multi-stage workflow (5+ steps) or nested diagram?
   - ❌ YES → Flatten to 3-4 high-level steps only
   - ✅ NO → Continue

3. **Word count**: Can I describe all text in 10 words or less?
   - ❌ NO → Cut text, use single-word labels
   - ✅ YES → Continue

4. **Message clarity**: Does this graphic convey ONE clear message?
   - ❌ NO → Split into multiple focused graphics
   - ✅ YES → Continue to generation

**Common patterns that ALWAYS fail (reject these):**
- "Show stages 1 through 7..." → Split into high-level overview (3 stages) + detail graphics
- "Multiple case studies..." → One case per graphic
- "Timeline from 2015 to 2024 with annual milestones..." → Show only 3-4 key years
- "Comparison of 6 methods..." → Show only top 3 or Our method vs Best baseline
- "Architecture with all layers and connections..." → High-level only (3-4 components)

### Step 1: Plan Your Poster Elements

After passing the pre-generation review, identify visual elements needed:

1. **Title Block** - Stylized title with institutional branding (optional - can be LaTeX text)
2. **Introduction Graphic** - Conceptual overview (3 elements max)
3. **Methods Diagram** - High-level workflow (3-4 steps max)
4. **Results Figures** - Key findings (3 metrics max per figure, may need 2-3 separate figures)
5. **Conclusion Graphic** - Summary visual (3 takeaways max)
6. **Supplementary Icons** - Simple icons, QR codes, logos (minimal)

### Step 2: Generate Each Element (After Pre-Generation Review)

**Review Step 0 checklist before proceeding.** For full example prompts for schematics, stylized blocks, and data visualizations, see `references/ai_visual_examples.md`.

### Step 2b: MANDATORY Post-Generation Review (Before Assembly)

**⚠️ CRITICAL: Review EVERY generated graphic before adding to poster.**

**For each generated figure, open at 25% zoom and check:**

1. **✅ PASS criteria (all must be true):**
   - Can read ALL text clearly at 25% zoom
   - Count elements: 3-4 or fewer
   - White space: 50%+ of image is empty
   - Simple enough to understand in 2 seconds
   - NOT a complex workflow with 5+ stages
   - NOT multiple nested sections

2. **❌ FAIL criteria (regenerate if ANY are true):**
   - Text is small or hard to read at 25% zoom → REGENERATE with "150pt+" fonts
   - More than 4 elements → REGENERATE with "ONLY 3 elements"
   - Less than 50% white space → REGENERATE with "60% white space"
   - Complex multi-stage workflow → SPLIT into 2-3 simple graphics
   - Multiple case studies cramped together → SPLIT into separate graphics
   - Takes more than 3 seconds to understand → SIMPLIFY and regenerate

**Common failures and fixes:**
- "7-stage workflow with tiny text" → Regenerate as "3 high-level stages only"
- "3 case studies in one graphic" → Generate 3 separate simple graphics
- "Timeline with 8 years" → Regenerate with "ONLY 3 key milestones"
- "Comparison of 5 methods" → Regenerate with "ONLY Our method vs Best baseline (2 bars)"

**DO NOT PROCEED to assembly if ANY graphic fails the checks above.**

### Step 3: Assemble in LaTeX Template

For tikzposter and baposter assembly examples, see `references/ai_visual_examples.md`.

### Complete Poster Generation Workflow

For a full end-to-end example with quality checks at each stage, see `references/ai_visual_examples.md`.

### Visual Element Guidelines

**ABSOLUTE LIMITS per graphic (NOT guidelines, HARD LIMITS):**
- **MAXIMUM 3-4 elements** (3 is ideal)
- **MAXIMUM 10 words** total
- **MINIMUM 50% white space** (60% is better)
- **MINIMUM 120pt** for key numbers, **80pt** for labels

For per-section prompt templates and the complete list of patterns that always fail vs always work, see `references/ai_visual_examples.md`.

---

## Scientific Schematics Integration

For detailed guidance on creating schematics, refer to the **scientific-schematics** skill documentation.

**Key capabilities:**
- Nano Banana Pro automatically generates, reviews, and refines diagrams
- Creates publication-quality images with proper formatting
- Ensures accessibility (colorblind-friendly, high contrast)
- Supports iterative refinement for complex diagrams

---

## Core Capabilities

This skill covers 9 core areas for poster creation. For detailed guidance on each, see `references/core_capabilities.md`.

1. **LaTeX Poster Packages** -- beamerposter, tikzposter, baposter (see also `references/latex_poster_packages.md`)
2. **Poster Layout and Structure** -- column-based, block-based, Z-pattern flow (see also `references/poster_layout_design.md`)
3. **Design Principles** -- typography, color, visual hierarchy (see also `references/poster_design_principles.md`)
4. **Standard Poster Sizes** -- A0/A1/A2, 36x48", portrait/landscape
5. **Package-Specific Templates** -- ready-to-use templates in `assets/`
6. **Figure and Image Integration** -- vector graphics, subfigures, 300 DPI minimum
7. **Color Schemes and Themes** -- institutional colors, colorblind-safe palettes
8. **Typography and Text Formatting** -- sans-serif fonts, size hierarchy, emphasis
9. **QR Codes and Interactive Elements** -- links to papers, code, demos

## Compilation and Quality Control

For detailed compilation commands, full-page setup for each package, and the complete 9-step PDF review checklist, see `references/compilation_and_review.md`.

**Quick compilation:**
```bash
pdflatex poster.tex
# Or with bibliography:
pdflatex poster.tex && bibtex poster && pdflatex poster.tex && pdflatex poster.tex
```

**Essential post-compilation check:**
```bash
grep -i "overfull\|underfull\|badbox" poster.log
pdfinfo poster.pdf | grep "Page size"
```

## Content Patterns, Accessibility, and Presentation Tips

For poster content organization templates (experimental, computational, review), accessibility guidelines, and presentation best practices, see `references/presentation_tips.md`.

## Workflow for Poster Creation

A 6-stage workflow guides poster creation from planning through delivery. For the full detailed workflow with commands and checklists, see `references/workflow_details.md`.

1. **Planning** -- Determine size, develop content outline (1-3 core messages, 300-800 words), choose LaTeX package
2. **Generate Visuals** -- AI-powered graphics with strict limits (3-5 elements max, 50% white space, GIANT fonts)
3. **Design and Layout** -- Select template, plan columns, set typography hierarchy
4. **Content Integration** -- Header, AI figures, minimal text, QR codes, references
5. **Refinement and Testing** -- Proofread, 25% scale print test, optimize for printing
6. **Compilation and Delivery** -- Final PDF, verify quality, prepare print and digital versions

## Common Pitfalls to Avoid

For the complete list of AI graphics mistakes, design mistakes, content mistakes, technical mistakes, and best practices checklist, see `references/common_pitfalls.md`.

**Top 3 pitfalls:**
- Too many elements in AI graphics (10+ items) -- keep to 3-5 max
- Text too small in AI graphics -- specify "GIANT (100pt+)" in prompts
- Too much text on poster (1000+ words) -- aim for 300-800 words

## Integration with Other Skills

This skill works effectively with:
- **Scientific Schematics**: CRITICAL - Use for generating all poster diagrams and flowcharts
- **Generate Image / Nano Banana Pro**: For stylized graphics, conceptual illustrations, and summary visuals
- **Scientific Writing**: For developing poster content from papers
- **Literature Review**: For contextualizing research
- **Data Analysis**: For creating result figures and charts

**Recommended workflow**: Always use scientific-schematics and generate-image skills BEFORE creating the LaTeX poster to generate all visual elements.

## Package Installation

Ensure required LaTeX packages are installed:

```bash
# For TeX Live (Linux/Mac)
tlmgr install beamerposter tikzposter baposter

# For MiKTeX (Windows)
# Packages typically auto-install on first use

# Additional recommended packages
tlmgr install qrcode graphics xcolor tcolorbox subcaption
```

## Scripts and Automation

Helper scripts available in `scripts/` directory:

- `compile_poster.sh`: Automated compilation with error handling
- `generate_template.py`: Interactive template generator
- `resize_images.py`: Batch image optimization for posters
- `poster_checklist.py`: Pre-submission validation tool

## References

Comprehensive reference files for detailed guidance:

- `references/latex_poster_packages.md`: Detailed comparison of beamerposter, tikzposter, and baposter with examples
- `references/poster_layout_design.md`: Layout principles, grid systems, and visual flow
- `references/poster_design_principles.md`: Typography, color theory, visual hierarchy, and accessibility
- `references/poster_content_guide.md`: Content organization, writing style, and section-specific guidance
- `references/core_capabilities.md`: All 9 core capability areas with package configs, templates, and code examples
- `references/compilation_and_review.md`: Compilation commands, full-page setup, and 9-step PDF quality checklist
- `references/presentation_tips.md`: Content patterns, accessibility, and poster presentation best practices
- `references/workflow_details.md`: Complete 6-stage poster creation workflow with commands and checklists
- `references/common_pitfalls.md`: Common mistakes and best practices checklist
- `references/ai_visual_examples.md`: WRONG vs CORRECT prompt examples, assembly templates, and complete workflow example

## Templates

Ready-to-use poster templates in `assets/` directory:

- beamerposter templates (classic, modern, colorful)
- tikzposter templates (default, rays, wave, envelope)
- baposter templates (portrait, landscape, minimal)
- Example posters from various scientific disciplines
- Color scheme definitions and institutional templates

Load these templates and customize for your specific research and conference requirements.

