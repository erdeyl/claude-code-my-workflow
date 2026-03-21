# Workflow Phases for Market Research Reports

This file contains the detailed step-by-step workflow for producing a market research report, from research through compilation.

---

## Phase 1: Research & Data Gathering

**Step 1: Define Scope**
- Clarify market definition
- Set geographic boundaries
- Determine time horizon
- Identify key questions to answer

**Step 2: Conduct Deep Research**

Use `research-lookup` extensively to gather market data:

```bash
# Market size and growth data
python skills/research-lookup/scripts/research_lookup.py \
  "What is the current market size and projected growth rate for [MARKET] industry? Include TAM, SAM, SOM estimates and CAGR projections"

# Competitive landscape
python skills/research-lookup/scripts/research_lookup.py \
  "Who are the top 10 competitors in the [MARKET] market? What is their market share and competitive positioning?"

# Industry trends
python skills/research-lookup/scripts/research_lookup.py \
  "What are the major trends and growth drivers in the [MARKET] industry for 2024-2030?"

# Regulatory environment
python skills/research-lookup/scripts/research_lookup.py \
  "What are the key regulations and policy changes affecting the [MARKET] industry?"
```

**Step 3: Data Organization**
- Create `sources/` folder with research notes
- Organize data by section
- Identify data gaps
- Conduct follow-up research as needed

---

## Phase 2: Analysis & Framework Application

**Step 4: Apply Analysis Frameworks**

For each framework, conduct structured analysis:

- **Market Sizing**: TAM → SAM → SOM with clear assumptions
- **Porter's Five Forces**: Rate each force High/Medium/Low with rationale
- **PESTLE**: Analyze each dimension with trends and impacts
- **SWOT**: Internal strengths/weaknesses, external opportunities/threats
- **Competitive Positioning**: Define axes, plot competitors

**Step 5: Develop Insights**
- Synthesize findings into key insights
- Identify strategic implications
- Develop recommendations
- Prioritize opportunities

---

## Phase 3: Visual Generation

**Step 6: Generate All Visuals**

Generate visuals BEFORE writing the report. Use the batch generation script:

```bash
# Generate all standard market report visuals
python skills/market-research-reports/scripts/generate_market_visuals.py \
  --topic "[MARKET NAME]" \
  --output-dir figures/
```

Or generate individually:

```bash
# 1. Market growth trajectory
python skills/scientific-schematics/scripts/generate_schematic.py \
  "Bar chart showing market growth from 2020 to 2034, with historical bars in dark blue (2020-2024) and projected bars in light blue (2025-2034). Y-axis shows market size in billions USD. Include CAGR annotation" \
  -o figures/01_market_growth.png --doc-type report

# 2. TAM/SAM/SOM breakdown
python skills/scientific-schematics/scripts/generate_schematic.py \
  "TAM SAM SOM concentric circles diagram. Outer circle TAM Total Addressable Market, middle circle SAM Serviceable Addressable Market, inner circle SOM Serviceable Obtainable Market. Each labeled with acronym and description. Blue gradient" \
  -o figures/02_tam_sam_som.png --doc-type report

# 3. Porter's Five Forces
python skills/scientific-schematics/scripts/generate_schematic.py \
  "Porter's Five Forces diagram with center box 'Competitive Rivalry' connected to four surrounding boxes: Threat of New Entrants (top), Bargaining Power of Suppliers (left), Bargaining Power of Buyers (right), Threat of Substitutes (bottom). Color code by rating: High=red, Medium=yellow, Low=green" \
  -o figures/03_porters_five_forces.png --doc-type report

# 4. Competitive positioning matrix
python skills/scientific-schematics/scripts/generate_schematic.py \
  "2x2 competitive positioning matrix with X-axis 'Market Focus (Niche to Broad)' and Y-axis 'Solution Approach (Product to Platform)'. Plot 8-10 competitors as labeled circles of varying sizes. Include quadrant labels" \
  -o figures/04_competitive_positioning.png --doc-type report

# 5. Risk heatmap
python skills/scientific-schematics/scripts/generate_schematic.py \
  "Risk heatmap matrix. X-axis Impact (Low to Critical), Y-axis Probability (Unlikely to Very Likely). Color gradient: Green (low risk) to Red (critical risk). Plot 10-12 risks as labeled points" \
  -o figures/05_risk_heatmap.png --doc-type report

# 6. (Optional) Executive summary infographic
python skills/generate-image/scripts/generate_image.py \
  "Professional executive summary infographic for market research report, modern data visualization style, blue and green color scheme, clean minimalist design" \
  --output figures/06_exec_summary.png
```

---

## Phase 4: Report Writing

**Step 7: Initialize Project Structure**

Create the standard project structure:

```
writing_outputs/YYYYMMDD_HHMMSS_market_report_[topic]/
├── progress.md
├── drafts/
│   └── v1_market_report.tex
├── references/
│   └── references.bib
├── figures/
│   └── [all generated visuals]
├── sources/
│   └── [research notes]
└── final/
```

**Step 8: Write Report Using Template**

Use the `market_report_template.tex` as a starting point. Write each section following the structure guide, ensuring:

- **Comprehensive coverage**: Every subsection addressed
- **Data-driven content**: Claims supported by research
- **Visual integration**: Reference all generated figures
- **Professional tone**: Consulting-style writing
- **No token constraints**: Write fully, don't abbreviate

**Writing Guidelines:**
- Use active voice where possible
- Lead with insights, support with data
- Use numbered lists for recommendations
- Include data sources for all statistics
- Create smooth transitions between sections

---

## Phase 5: Compilation & Review

**Step 9: Compile LaTeX**

```bash
cd writing_outputs/[project_folder]/drafts/
xelatex v1_market_report.tex
bibtex v1_market_report
xelatex v1_market_report.tex
xelatex v1_market_report.tex
```

**Step 10: Quality Review**

Verify the report meets quality standards:

- [ ] Total page count is 50+ pages
- [ ] All essential visuals (5-6 core + any additional) are included and render correctly
- [ ] Executive summary captures key findings
- [ ] All data points have sources cited
- [ ] Analysis frameworks are properly applied
- [ ] Recommendations are actionable and prioritized
- [ ] No orphaned figures or tables
- [ ] Table of contents, list of figures, list of tables are accurate
- [ ] Bibliography is complete
- [ ] PDF renders without errors

**Step 11: Peer Review**

Use the peer-review skill to evaluate the report:
- Assess comprehensiveness
- Verify data accuracy
- Check logical flow
- Evaluate recommendation quality
