---
name: market-research-reports
description: Generate comprehensive market research reports (50+ pages) in the style of top consulting firms (McKinsey, BCG, Gartner). Features professional LaTeX formatting, extensive visual generation with scientific-schematics and generate-image, deep integration with research-lookup for data gathering, and multi-framework strategic analysis including Porter Five Forces, PESTLE, SWOT, TAM/SAM/SOM, and BCG Matrix.
allowed-tools: Read Write Edit Bash
license: MIT license
metadata:
    skill-author: K-Dense Inc.
---

# Market Research Reports

## Overview

Market research reports are comprehensive strategic documents that analyze industries, markets, and competitive landscapes to inform business decisions, investment strategies, and strategic planning. This skill generates **professional-grade reports of 50+ pages** with extensive visual content, modeled after deliverables from top consulting firms like McKinsey, BCG, Bain, Gartner, and Forrester.

**Key Features:**
- **Comprehensive length**: Reports are designed to be 50+ pages with no token constraints
- **Visual-rich content**: 5-6 key diagrams generated at start (more added as needed during writing)
- **Data-driven analysis**: Deep integration with research-lookup for market data
- **Multi-framework approach**: Porter's Five Forces, PESTLE, SWOT, BCG Matrix, TAM/SAM/SOM
- **Professional formatting**: Consulting-firm quality typography, colors, and layout
- **Actionable recommendations**: Strategic focus with implementation roadmaps

**Output Format:** LaTeX with professional styling, compiled to PDF. Uses the `market_research.sty` style package for consistent, professional formatting.

## When to Use This Skill

This skill should be used when:
- Creating comprehensive market analysis for investment decisions
- Developing industry reports for strategic planning
- Analyzing competitive landscapes and market dynamics
- Conducting market sizing exercises (TAM/SAM/SOM)
- Evaluating market entry opportunities
- Preparing due diligence materials for M&A activities
- Creating thought leadership content for industry positioning
- Developing go-to-market strategy documentation
- Analyzing regulatory and policy impacts on markets
- Building business cases for new product launches

## Visual Enhancement Requirements

**CRITICAL: Market research reports should include key visual content.**

Every report should generate **6 essential visuals** at the start, with additional visuals added as needed during writing.

### Visual Generation Tools

**Use `scientific-schematics` for:**
- Market growth trajectory charts, TAM/SAM/SOM diagrams, Porter's Five Forces
- Competitive positioning matrices, market segmentation charts, value chain diagrams
- Technology roadmaps, risk heatmaps, strategic prioritization matrices
- Implementation timelines/Gantt charts, SWOT diagrams, BCG matrices

```bash
# Example: Generate a TAM/SAM/SOM diagram
python skills/scientific-schematics/scripts/generate_schematic.py \
  "TAM SAM SOM concentric circle diagram showing Total Addressable Market $50B outer circle, Serviceable Addressable Market $15B middle circle, Serviceable Obtainable Market $3B inner circle, with labels and arrows pointing to each segment" \
  -o figures/tam_sam_som.png --doc-type report
```

**Use `generate-image` for:**
- Executive summary hero infographics, industry conceptual illustrations
- Abstract technology visualizations, cover page imagery

### Recommended Visuals by Section

| Section | Priority Visuals | Optional Visuals |
|---------|-----------------|------------------|
| Executive Summary | Executive infographic (START) | - |
| Market Size & Growth | Growth trajectory (START), TAM/SAM/SOM (START) | Regional breakdown, segment growth |
| Competitive Landscape | Porter's Five Forces (START), Positioning matrix (START) | Market share chart, strategic groups |
| Risk Analysis | Risk heatmap (START) | Mitigation matrix |
| Strategic Recommendations | Opportunity matrix | Priority framework |
| Implementation Roadmap | Timeline/Gantt | Milestone tracker |
| Investment Thesis | Financial projections | Scenario analysis |

**Start with 6 priority visuals** (marked as START above), then generate additional visuals as specific sections are written.

---

## Report Structure (50+ Pages) -- Summary

The report follows a three-part structure totaling 50+ pages:

**Front Matter (~5 pages):** Cover page with hero visual, table of contents, list of figures/tables, and a 2-3 page executive summary with market snapshot, investment thesis, key findings, and strategic recommendations.

**Core Analysis (~35 pages) -- 8 Chapters:**
1. **Market Overview & Definition** (4-5pp): Market scope, ecosystem mapping, stakeholders, boundaries, history
2. **Market Size & Growth** (6-8pp): TAM/SAM/SOM, historical + projected growth, regional/segment breakdown
3. **Industry Drivers & Trends** (5-6pp): PESTLE analysis, macroeconomic factors, technology and regulatory trends
4. **Competitive Landscape** (6-8pp): Porter's Five Forces, market share, competitive positioning, strategic groups
5. **Customer Analysis & Segmentation** (4-5pp): Segment definitions, buying behavior, value drivers
6. **Technology & Innovation** (4-5pp): Tech stack, emerging tech, adoption curves, R&D, patents
7. **Regulatory & Policy Environment** (3-4pp): Framework, compliance, upcoming changes, impact
8. **Risk Analysis** (3-4pp): Risk heatmap (probability vs impact), mitigation strategies

**Strategic Recommendations (~10 pages) -- 3 Chapters:**
9. **Strategic Opportunities & Recommendations** (4-5pp): Opportunity sizing, prioritization, detailed recommendations
10. **Implementation Roadmap** (3-4pp): Phased plan, milestones, resources, governance
11. **Investment Thesis & Financial Projections** (3-4pp): Projections, scenario analysis, ROI/IRR

**Back Matter (~5 pages):** Methodology, data tables, company profiles, bibliography.

> **Full details:** Load `references/chapter_structure.md` for complete content requirements, required visuals, key data points, and analysis frameworks for each chapter.

---

## Workflow -- Summary

The workflow has 5 phases and 11 steps:

**Phase 1 -- Research & Data Gathering:** Define scope (market, geography, time horizon), conduct deep research using `research-lookup` for market size, competitors, trends, and regulations, then organize data by section.

**Phase 2 -- Analysis & Framework Application:** Apply TAM/SAM/SOM, Porter's Five Forces, PESTLE, SWOT, and competitive positioning frameworks. Synthesize into key insights and recommendations.

**Phase 3 -- Visual Generation:** Generate all visuals BEFORE writing. Use `scientific-schematics` for diagrams and `generate-image` for infographics. Batch generation available via `scripts/generate_market_visuals.py`.

**Phase 4 -- Report Writing:** Initialize project structure under `writing_outputs/`, write each section using `market_report_template.tex`, ensuring comprehensive coverage, data-driven content, visual integration, and professional tone.

**Phase 5 -- Compilation & Review:** 3-pass XeLaTeX + BibTeX compilation. Quality review checklist (50+ pages, visuals render, sources cited, frameworks applied). Peer review for comprehensiveness and accuracy.

> **Full details:** Load `references/workflow_phases.md` for complete step-by-step instructions, research-lookup commands, visual generation scripts, project structure, and compilation commands.

---

## LaTeX Formatting -- Summary

Use the `market_research.sty` style package. Key box environments:
- `keyinsightbox` (blue) -- Key findings and insights
- `marketdatabox` (green) -- Market snapshots and data summaries
- `riskbox` (orange) -- Risk warnings
- `recommendationbox` (purple) -- Strategic recommendations
- `calloutbox` (gray) -- Definitions and notes

> **Full details:** Load `references/latex_formatting.md` for complete LaTeX examples of box environments, figure formatting, and table formatting. Also see `assets/FORMATTING_GUIDE.md`.

---

## Quality Standards

### Page Count Targets

| Section | Minimum Pages | Target Pages |
|---------|---------------|--------------|
| Front Matter | 4 | 5 |
| Market Overview | 4 | 5 |
| Market Size & Growth | 5 | 7 |
| Industry Drivers | 4 | 6 |
| Competitive Landscape | 5 | 7 |
| Customer Analysis | 3 | 5 |
| Technology Landscape | 3 | 5 |
| Regulatory Environment | 2 | 4 |
| Risk Analysis | 2 | 4 |
| Strategic Recommendations | 3 | 5 |
| Implementation Roadmap | 2 | 4 |
| Investment Thesis | 2 | 4 |
| Back Matter | 4 | 5 |
| **TOTAL** | **43** | **66** |

### Visual Quality Requirements

- **Resolution**: All images at 300 DPI minimum
- **Format**: PNG for raster, PDF for vector
- **Accessibility**: Colorblind-friendly palettes
- **Consistency**: Same color scheme throughout
- **Labeling**: All axes, legends, and data points labeled
- **Source Attribution**: Sources cited in figure captions

### Data Quality Requirements

- **Currency**: Data no older than 2 years (prefer current year)
- **Sourcing**: All statistics attributed to specific sources
- **Validation**: Cross-reference multiple sources when possible
- **Assumptions**: All projections state underlying assumptions
- **Limitations**: Acknowledge data limitations and gaps

### Writing Quality Requirements

- **Objectivity**: Present balanced analysis, acknowledge uncertainties
- **Clarity**: Avoid jargon, define technical terms
- **Precision**: Use specific numbers over vague qualifiers
- **Structure**: Clear headings, logical flow, smooth transitions
- **Actionability**: Recommendations are specific and implementable

---

## Integration with Other Skills

This skill works synergistically with:

- **research-lookup**: Essential for gathering market data, statistics, and competitive intelligence
- **scientific-schematics**: Generate all diagrams, charts, and visualizations
- **generate-image**: Create infographics and conceptual illustrations
- **peer-review**: Evaluate report quality and completeness
- **citation-management**: Manage BibTeX references

---

## Example Prompts

**Market Overview:**
> Write a comprehensive market overview for [Electric Vehicle Charging Infrastructure]. Include market definition, ecosystem mapping, value chain, historical evolution, and current dynamics. Generate 2 supporting visuals.

**Competitive Landscape:**
> Analyze the competitive landscape for [Cloud Computing]. Include Porter's Five Forces (rated), top 10 competitors with market share, positioning matrix, strategic groups, and barriers to entry. Generate 4 visuals.

**Strategic Recommendations:**
> Develop strategic recommendations for entering [Renewable Energy Storage]. Include 5-7 prioritized recommendations with opportunity sizing, implementation considerations, risks, and success criteria. Generate 3 visuals.

---

## Checklist: 50+ Page Validation

### Structure Completeness
- [ ] Cover page with hero visual
- [ ] Table of contents, list of figures, list of tables (auto-generated)
- [ ] Executive summary (2-3 pages)
- [ ] All 11 core chapters present
- [ ] Appendices A-C (Methodology, Data tables, Company profiles)
- [ ] References/Bibliography

### Visual Completeness
- [ ] Market growth trajectory chart
- [ ] TAM/SAM/SOM diagram
- [ ] Porter's Five Forces
- [ ] Competitive positioning matrix
- [ ] Risk heatmap
- [ ] Executive summary infographic (optional)
- [ ] Additional section-specific visuals as needed

### Content & Technical Quality
- [ ] All statistics have sources
- [ ] Projections include assumptions
- [ ] Frameworks properly applied
- [ ] Recommendations are actionable
- [ ] Professional writing quality
- [ ] No placeholder or incomplete sections
- [ ] PDF compiles without errors
- [ ] All figures render correctly
- [ ] Cross-references work
- [ ] Bibliography complete
- [ ] Page count exceeds 50

---

## Resources

### Reference Files

Load these files for detailed guidance:

- **`references/chapter_structure.md`**: Complete chapter-by-chapter content requirements, required visuals, key data points, and analysis frameworks
- **`references/workflow_phases.md`**: Full step-by-step workflow with research commands, visual generation scripts, and compilation instructions
- **`references/latex_formatting.md`**: LaTeX box environments, figure formatting, and table formatting examples
- **`references/report_structure_guide.md`**: Detailed section-by-section content requirements
- **`references/visual_generation_guide.md`**: Complete prompts for generating all visual types
- **`references/data_analysis_patterns.md`**: Templates for Porter's, PESTLE, SWOT, etc.

### Assets

- **`assets/market_research.sty`**: LaTeX style package
- **`assets/market_report_template.tex`**: Complete LaTeX template
- **`assets/FORMATTING_GUIDE.md`**: Quick reference for box environments and styling

### Scripts

- **`scripts/generate_market_visuals.py`**: Batch generate all report visuals

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Report under 50 pages | Expand data tables in appendices, add company profiles, include regional breakdowns |
| Visuals not rendering | Check file paths in LaTeX, ensure images in figures/ folder, verify extensions |
| Bibliography missing entries | Run bibtex after first xelatex pass, check .bib syntax |
| Table/figure overflow | Use `\resizebox` or `adjustbox` package, reduce image width |
| Poor visual quality | Use `--doc-type report` flag, increase iterations with `--iterations 5` |

---

Use this skill to create comprehensive, visually-rich market research reports that rival top consulting firm deliverables. The combination of deep research, structured frameworks, and extensive visualization produces documents that inform strategic decisions and demonstrate analytical rigor.
