---
name: scientific-writing
description: Core skill for the deep research and writing tool. Write scientific manuscripts in full paragraphs (never bullet points). Use two-stage process with (1) section outlines with key points using research-lookup then (2) convert to flowing prose. IMRAD structure, citations (APA/AMA/Vancouver), figures/tables, reporting guidelines (CONSORT/STROBE/PRISMA), for research papers and journal submissions.
allowed-tools: Read Write Edit Bash
license: MIT license
metadata:
    skill-author: K-Dense Inc.
---

# Scientific Writing

## Overview

**This is the core skill for the deep research and writing tool**—combining AI-driven deep research with well-formatted written outputs. Every document produced is backed by comprehensive literature search and verified citations through the research-lookup skill.

Scientific writing is a process for communicating research with precision and clarity. Write manuscripts using IMRAD structure, citations (APA/AMA/Vancouver), figures/tables, and reporting guidelines (CONSORT/STROBE/PRISMA). Apply this skill for research papers and journal submissions.

**Critical Principle: Always write in full paragraphs with flowing prose. Never submit bullet points in the final manuscript.** Use a two-stage process: first create section outlines with key points using research-lookup, then convert those outlines into complete paragraphs.

## When to Use This Skill

This skill should be used when:
- Writing or revising any section of a scientific manuscript (abstract, introduction, methods, results, discussion)
- Structuring a research paper using IMRAD or other standard formats
- Formatting citations and references in specific styles (APA, AMA, Vancouver, Chicago, IEEE)
- Creating, formatting, or improving figures, tables, and data visualizations
- Applying study-specific reporting guidelines (CONSORT for trials, STROBE for observational studies, PRISMA for reviews)
- Drafting abstracts that meet journal requirements (structured or unstructured)
- Preparing manuscripts for submission to specific journals
- Improving writing clarity, conciseness, and precision
- Ensuring proper use of field-specific terminology and nomenclature
- Addressing reviewer comments and revising manuscripts

## Visual Enhancement with Scientific Schematics

**MANDATORY: Every scientific paper MUST include a graphical abstract plus 1-2 additional AI-generated figures using the scientific-schematics skill.**

Before finalizing any document:
1. **ALWAYS generate a graphical abstract** as the first visual element
2. Generate at minimum ONE additional schematic or diagram using scientific-schematics
3. Prefer 3-4 total figures for comprehensive papers (graphical abstract + methods flowchart + results visualization + conceptual diagram)

### Graphical Abstract (REQUIRED)

Every scientific writeup MUST include a graphical abstract—a visual summary capturing the paper's key message in one image (landscape, typically 1200x600px).

```bash
python scripts/generate_schematic.py "Graphical abstract for [paper title]: [brief description showing workflow from input -> methods -> key findings -> conclusions]" -o figures/graphical_abstract.png
```

### Additional Figures (GENERATE EXTENSIVELY)

**Use BOTH scientific-schematics AND generate-image EXTENSIVELY throughout all documents.**

**MINIMUM Figure Requirements:**

| Document Type | Minimum | Recommended |
|--------------|---------|-------------|
| Research Papers | 5 | 6-8 |
| Literature Reviews | 4 | 5-7 |
| Market Research | 20 | 25-30 |
| Presentations | 1/slide | 1-2/slide |
| Posters | 6 | 8-10 |
| Grants | 4 | 5-7 |
| Clinical Reports | 3 | 4-6 |

**Use scientific-schematics for technical diagrams** (flowcharts, pathways, architectures, decision trees) and **generate-image for visual content** (illustrations, infographics, cover images). When in doubt, generate a figure.

For detailed guidance, refer to the scientific-schematics and generate-image skill documentation.

---

## Core Capabilities

### 1. Manuscript Structure and Organization

**IMRAD Format**: Guide papers through the standard Introduction, Methods, Results, And Discussion structure. For detailed guidance, refer to `references/imrad_structure.md`.

**Alternative Structures**: Support discipline-specific formats including review articles (narrative, systematic, scoping), case reports, meta-analyses, theoretical/modeling papers, and methods papers.

### 2. Section-Specific Writing Guidance

**Abstract**: Craft concise, standalone summaries (100-250 words) in structured or unstructured formats.

**Introduction**: Establish importance, review literature, identify gaps, state hypotheses, explain novelty.

**Methods**: Ensure reproducibility through detailed participant/sample descriptions, procedures, statistical methods, and ethical statements.

**Results**: Present findings with logical flow, figure/table integration, statistical significance with effect sizes, and objective reporting.

**Discussion**: Relate results to questions, compare with literature, acknowledge limitations, propose implications and future research.

### 3. Citation and Reference Management

Apply citation styles correctly across disciplines. For comprehensive style guides, refer to `references/citation_styles.md`.

**Major styles**: AMA (numbered superscript, medicine), Vancouver (numbered brackets, biomedical), APA (author-date, social sciences), Chicago (notes or author-date, humanities), IEEE (numbered brackets, engineering).

**Best practices**: Cite primary sources, include recent literature (5-10 years), balance citations across sections, verify against originals, use reference management software.

### 4. Figures and Tables

Create effective data visualizations. For detailed best practices, refer to `references/figures_tables.md`.

Use tables for precise numerical data; figures for trends, patterns, and relationships. Make each self-explanatory with complete captions, consistent formatting, labeled axes with units, and sample sizes. Follow "one table/figure per 1000 words" guideline.

### 5. Reporting Guidelines by Study Type

Ensure completeness by following established standards. For comprehensive details, refer to `references/reporting_guidelines.md`.

**Key guidelines**: CONSORT (RCTs), STROBE (observational), PRISMA (systematic reviews), STARD (diagnostic), TRIPOD (prediction), ARRIVE (animal), CARE (case reports), SQUIRE (QI), SPIRIT (protocols), CHEERS (economic evaluations).

### 6. Writing Principles and Style

Apply fundamental scientific writing principles. For detailed guidance, refer to `references/writing_principles.md`.

**Clarity**: Precise language, defined terms, logical flow, active voice. **Conciseness**: No redundancy, short sentences (15-20 words), no unnecessary qualifiers. **Accuracy**: Exact values, consistent terminology, distinguish observations from interpretations. **Objectivity**: No bias, no overstatement, acknowledge conflicts, neutral tone.

### 7. Writing Process: From Outline to Full Paragraphs

Use a two-stage process: (1) create section outlines with key points using research-lookup, then (2) convert to flowing prose with transitions, integrated citations, and logical flow. Bullet points are for planning only -- the final manuscript must be in complete paragraphs.

For the complete process with examples, common mistakes, and acceptable list usage, refer to `references/writing_process.md`.

### 8. Professional Report Formatting (Non-Journal Documents)

For research reports, white papers, and technical documents (NOT journal manuscripts), use the `scientific_report.sty` LaTeX style package. Provides Helvetica typography, colored box environments (keyfindings, methodology, recommendations, limitations), professional tables, and scientific notation commands.

For complete LaTeX examples, box environment syntax, and scientific notation commands, refer to `references/report_formatting_latex.md`.

See also: `assets/scientific_report.sty`, `assets/scientific_report_template.tex`, `assets/REPORT_FORMATTING_GUIDE.md`, `references/professional_report_formatting.md`.

### 9. Journal-Specific Formatting

Adapt manuscripts to journal requirements:
- Follow author guidelines for structure, length, and format
- Apply journal-specific citation styles
- Meet figure/table specifications (resolution, file formats, dimensions)
- Include required statements (funding, conflicts of interest, data availability, ethical approval)
- Adhere to word limits for each section
- Format according to template requirements when provided

### 10. Field-Specific Language and Terminology

Adapt language and conventions to the target discipline. Each field has established vocabulary, preferred phrasings, and nomenclature that signal expertise and ensure clarity. Covers biomedical, molecular biology, chemistry, ecology, physics, neuroscience, and social sciences.

For field-by-field terminology guides and general principles (audience matching, consistency, avoiding field mixing errors), refer to `references/field_specific_language.md`.

### 11. Common Pitfalls to Avoid

**Top Rejection Reasons:**
1. Inappropriate, incomplete, or insufficiently described statistics
2. Over-interpretation of results or unsupported conclusions
3. Poorly described methods affecting reproducibility
4. Small, biased, or inappropriate samples
5. Poor writing quality or difficult-to-follow text
6. Inadequate literature review or context
7. Figures and tables that are unclear or poorly designed
8. Failure to follow reporting guidelines

**Writing Quality Issues:**
- Mixing tenses inappropriately (use past tense for methods/results, present for established facts)
- Excessive jargon or undefined acronyms
- Paragraph breaks that disrupt logical flow
- Missing transitions between sections
- Inconsistent notation or terminology

## Workflow for Manuscript Development

**Stage 1: Planning**
1. Identify target journal and review author guidelines
2. Determine applicable reporting guideline (CONSORT, STROBE, etc.)
3. Outline manuscript structure (usually IMRAD)
4. Plan figures and tables as the backbone of the paper

**Stage 2: Drafting** (Use two-stage writing process for each section)
1. Start with figures and tables (the core data story)
2. For each section, first create outline with research-lookup, then convert to prose
3. Write Methods, Results, Discussion, Introduction, Abstract, Title (in that order)

**Remember**: Bullet points are for planning only -- the final manuscript must be in complete paragraphs.

**Stage 3: Revision**
1. Check logical flow and "red thread" throughout
2. Verify consistency in terminology and notation
3. Ensure figures/tables are self-explanatory
4. Confirm adherence to reporting guidelines
5. Verify all citations are accurate and properly formatted
6. Check word counts for each section
7. Proofread for grammar, spelling, and clarity

**Stage 4: Final Preparation**
1. Format according to journal requirements
2. Prepare supplementary materials
3. Write cover letter highlighting significance
4. Complete submission checklists
5. Gather all required statements and forms

## Integration with Other Scientific Skills

This skill works effectively with:
- **Data analysis skills**: For generating results to report
- **Statistical analysis**: For determining appropriate statistical presentations
- **Literature review skills**: For contextualizing research
- **Figure creation tools**: For developing publication-quality visualizations
- **Venue-templates skill**: For venue-specific writing styles and formatting (journal manuscripts)
- **scientific_report.sty**: For professional reports, white papers, and technical documents

### Professional Reports vs. Journal Manuscripts

| Document Type | Formatting Approach |
|---------------|---------------------|
| Journal manuscripts | Use `venue-templates` skill |
| Conference papers | Use `venue-templates` skill |
| Research/white/technical/grant reports | Use `scientific_report.sty` (this skill) |

### Venue-Specific Writing Styles

Before writing for a specific venue, consult the venue-templates skill for writing style guides. Different venues have dramatically different expectations (Nature/Science: story-driven; Cell Press: mechanistic depth; Medical journals: structured abstracts; ML/CS conferences: contribution bullets).

**Workflow**: First use this skill for general scientific writing principles, then consult venue-templates for venue-specific style adaptation.

## References

- `references/imrad_structure.md`: Detailed guide to IMRAD format and section-specific content
- `references/citation_styles.md`: Complete citation style guides (APA, AMA, Vancouver, Chicago, IEEE)
- `references/figures_tables.md`: Best practices for creating effective data visualizations
- `references/reporting_guidelines.md`: Study-specific reporting standards and checklists
- `references/writing_principles.md`: Core principles of effective scientific communication
- `references/professional_report_formatting.md`: Comprehensive formatting guide
- `references/report_formatting_latex.md`: LaTeX-specific formatting with `scientific_report.sty`
- `references/writing_process.md`: Two-stage outline-to-prose process with examples
- `references/field_specific_language.md`: Field-by-field terminology and nomenclature guides

## Assets

- `assets/scientific_report.sty`: Professional LaTeX style package
- `assets/scientific_report_template.tex`: Complete report template
- `assets/REPORT_FORMATTING_GUIDE.md`: Quick reference guide

For venue-specific writing styles, see the **venue-templates** skill.

Load these references as needed when working on specific aspects of scientific writing.
