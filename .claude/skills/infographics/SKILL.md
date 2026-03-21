---
name: infographics
description: "Create professional infographics using Nano Banana Pro AI with smart iterative refinement. Uses Gemini 3 Pro for quality review. Integrates research-lookup and web search for accurate data. Supports 10 infographic types, 8 industry styles, and colorblind-safe palettes."
allowed-tools: Read Write Edit Bash
---

# Infographics

## Overview

Infographics are visual representations of information, data, or knowledge designed to present complex content quickly and clearly. **This skill uses Nano Banana Pro AI for infographic generation with Gemini 3 Pro quality review and Perplexity Sonar for research.**

**How it works:**
- (Optional) **Research phase**: Gather accurate facts and statistics using Perplexity Sonar
- Describe your infographic in natural language
- Nano Banana Pro generates publication-quality infographics automatically
- **Gemini 3 Pro reviews quality** against document-type thresholds
- **Smart iteration**: Only regenerates if quality is below threshold
- Professional-ready output in minutes
- No design skills required

**Quality Thresholds by Document Type:**
| Document Type | Threshold | Description |
|---------------|-----------|-------------|
| marketing | 8.5/10 | Marketing materials - must be compelling |
| report | 8.0/10 | Business reports - professional quality |
| presentation | 7.5/10 | Slides, talks - clear and engaging |
| social | 7.0/10 | Social media content |
| internal | 7.0/10 | Internal use |
| draft | 6.5/10 | Working drafts |
| default | 7.5/10 | General purpose |

**Simply describe what you want, and Nano Banana Pro creates it.**

## Quick Start

Generate any infographic by simply describing it:

```bash
# Generate a list infographic (default threshold 7.5/10)
python skills/infographics/scripts/generate_infographic.py \
  "5 benefits of regular exercise" \
  -o figures/exercise_benefits.png --type list

# Generate for marketing (highest threshold: 8.5/10)
python skills/infographics/scripts/generate_infographic.py \
  "Product features comparison" \
  -o figures/product_comparison.png --type comparison --doc-type marketing

# Generate with corporate style
python skills/infographics/scripts/generate_infographic.py \
  "Company milestones 2010-2025" \
  -o figures/timeline.png --type timeline --style corporate

# Generate with colorblind-safe palette
python skills/infographics/scripts/generate_infographic.py \
  "Heart disease statistics worldwide" \
  -o figures/health_stats.png --type statistical --palette wong

# Generate WITH RESEARCH for accurate, up-to-date data
python skills/infographics/scripts/generate_infographic.py \
  "Global AI market size and growth projections" \
  -o figures/ai_market.png --type statistical --research
```

**What happens behind the scenes:**
1. **(Optional) Research**: Perplexity Sonar gathers accurate facts, statistics, and data
2. **Generation 1**: Nano Banana Pro creates initial infographic following design best practices
3. **Review 1**: **Gemini 3 Pro** evaluates quality against document-type threshold
4. **Decision**: If quality >= threshold → **DONE** (no more iterations needed!)
5. **If below threshold**: Improved prompt based on critique, regenerate
6. **Repeat**: Until quality meets threshold OR max iterations reached

**Smart Iteration Benefits:**
- Saves API calls if first generation is good enough
- Higher quality standards for marketing materials
- Faster turnaround for drafts/internal use
- Appropriate quality for each use case

**Output**: Versioned images plus a detailed review log with quality scores, critiques, and early-stop information.

## When to Use This Skill

Use the **infographics** skill when:
- Presenting data or statistics in a visual format
- Creating timeline visualizations for project milestones or history
- Explaining processes, workflows, or step-by-step guides
- Comparing options, products, or concepts side-by-side
- Summarizing key points in an engaging visual format
- Creating geographic or map-based data visualizations
- Building hierarchical or organizational charts
- Designing social media content or marketing materials

**Use scientific-schematics instead for:**
- Technical flowcharts and circuit diagrams
- Biological pathways and molecular diagrams
- Neural network architecture diagrams
- CONSORT/PRISMA methodology diagrams

---

## Research Integration

### Automatic Data Gathering (`--research`)

When creating infographics that require accurate, up-to-date data, use the `--research` flag to automatically gather facts and statistics using **Perplexity Sonar Pro**.

```bash
# Research and generate statistical infographic
python skills/infographics/scripts/generate_infographic.py \
  "Global renewable energy adoption rates by country" \
  -o figures/renewable_energy.png --type statistical --research

# Research for timeline infographic
python skills/infographics/scripts/generate_infographic.py \
  "History of artificial intelligence breakthroughs" \
  -o figures/ai_history.png --type timeline --research

# Research for comparison infographic
python skills/infographics/scripts/generate_infographic.py \
  "Electric vehicles vs hydrogen vehicles comparison" \
  -o figures/ev_hydrogen.png --type comparison --research
```

### What Research Provides

The research phase automatically:

1. **Gathers Key Facts**: 5-8 relevant facts and statistics about the topic
2. **Provides Context**: Background information for accurate representation
3. **Finds Data Points**: Specific numbers, percentages, and dates
4. **Cites Sources**: Mentions major studies or sources
5. **Prioritizes Recency**: Focuses on 2023-2026 information

### When to Use Research

**Enable research (`--research`) for:**
- Statistical infographics requiring accurate numbers
- Market data, industry statistics, or trends
- Scientific or medical information
- Current events or recent developments
- Any topic where accuracy is critical

**Skip research for:**
- Simple conceptual infographics
- Internal process documentation
- Topics where you provide all the data in the prompt
- Speed-critical generation

### Research Output

When research is enabled, additional files are created:
- `{name}_research.json` - Raw research data and sources
- Research content is automatically incorporated into the infographic prompt

---

## Infographic Types

10 types available: `statistical`, `timeline`, `process`, `comparison`, `list`, `geographic`, `hierarchical`, `anatomical`, `resume`, `social`. Each type has optimized layouts and key visual elements for its use case.

> **Full details:** See `references/type_descriptions.md` for descriptions, key elements, and example commands for all 10 types.

---

## Style Presets & Colorblind Palettes

8 industry styles (`--style`): corporate, healthcare, technology, nature, education, marketing, finance, nonprofit. 3 colorblind-safe palettes (`--palette`): wong, ibm, tol.

> **Full details:** See `references/style_presets.md` for color specifications and usage examples.

---

## Smart Iterative Refinement

### How It Works

```
┌─────────────────────────────────────────────────────┐
│  1. Generate infographic with Nano Banana Pro       │
│                    ↓                                │
│  2. Review quality with Gemini 3 Pro                │
│                    ↓                                │
│  3. Score >= threshold?                             │
│       YES → DONE! (early stop)                      │
│       NO  → Improve prompt, go to step 1            │
│                    ↓                                │
│  4. Repeat until quality met OR max iterations      │
└─────────────────────────────────────────────────────┘
```

### Quality Review Criteria

Gemini 3 Pro evaluates each infographic on:

1. **Visual Hierarchy & Layout** (0-2 points)
   - Clear visual hierarchy
   - Logical reading flow
   - Balanced composition

2. **Typography & Readability** (0-2 points)
   - Readable text
   - Bold headlines
   - No overlapping

3. **Data Visualization** (0-2 points)
   - Prominent numbers
   - Clear charts/icons
   - Proper labels

4. **Color & Accessibility** (0-2 points)
   - Professional colors
   - Sufficient contrast
   - Colorblind-friendly

5. **Overall Impact** (0-2 points)
   - Professional appearance
   - Free of visual bugs
   - Achieves communication goal

### Review Log

Each generation produces a JSON review log:
```json
{
  "user_prompt": "5 benefits of exercise...",
  "infographic_type": "list",
  "style": "healthcare",
  "doc_type": "marketing",
  "quality_threshold": 8.5,
  "iterations": [
    {
      "iteration": 1,
      "image_path": "figures/exercise_v1.png",
      "score": 8.7,
      "needs_improvement": false,
      "critique": "SCORE: 8.7\nSTRENGTHS:..."
    }
  ],
  "final_score": 8.7,
  "early_stop": true,
  "early_stop_reason": "Quality score 8.7 meets threshold 8.5"
}
```

---

## Command-Line Reference

Use `generate_infographic.py` with a PROMPT and options for output path (`-o`), type (`--type`), style (`--style`), palette (`--palette`), background color (`--background`), document type (`--doc-type`), max iterations (`--iterations`), and verbosity (`-v`). Run `--list-options` to see all available values.

> **Full details:** See `references/cli_reference.md` for complete argument reference.

---

## Configuration

### API Key Setup

Set your OpenRouter API key:
```bash
export OPENROUTER_API_KEY='your_api_key_here'
```

Get an API key at: https://openrouter.ai/keys

---

## Prompt Engineering Tips

### Be Specific About Content

Good prompts (specific, detailed):
```
"5 benefits of meditation: reduces stress, improves focus,
better sleep, lower blood pressure, emotional balance"
```

Avoid vague prompts:
```
"meditation infographic"
```

### Include Data Points

Good:
```
"Market growth from $10B (2020) to $45B (2025), CAGR 35%"
```

Vague:
```
"market is growing"
```

### Specify Visual Elements

Good:
```
"Timeline showing 5 milestones with icons for each event"
```

---

## Reference Files

For detailed guidance, load these reference files:

- **`references/infographic_types.md`**: Extended templates for all 10+ types
- **`references/type_descriptions.md`**: Descriptions, key elements, and examples for all 10 types
- **`references/design_principles.md`**: Visual hierarchy, layout, typography
- **`references/color_palettes.md`**: Full palette specifications
- **`references/style_presets.md`**: Industry styles and colorblind-safe palettes
- **`references/cli_reference.md`**: Complete command-line argument reference

---

## Troubleshooting

### Common Issues

**Problem**: Text in infographic is unreadable
- **Solution**: Reduce text content; use --type to specify layout type

**Problem**: Colors clash or are inaccessible
- **Solution**: Use `--palette wong` for colorblind-safe colors

**Problem**: Quality score too low
- **Solution**: Increase iterations with `--iterations 3`; use more specific prompt

**Problem**: Wrong infographic type generated
- **Solution**: Always specify `--type` flag for consistent results

---

## Integration with Other Skills

This skill works synergistically with:

- **scientific-schematics**: For technical diagrams and flowcharts
- **market-research-reports**: Infographics for business reports
- **scientific-slides**: Infographic elements for presentations
- **generate-image**: For non-infographic visual content

---

## Quick Reference Checklist

Before generating:
- [ ] Clear, specific content description
- [ ] Infographic type selected (`--type`)
- [ ] Style appropriate for audience (`--style`)
- [ ] Output path specified (`-o`)
- [ ] API key configured

After generating:
- [ ] Review the generated image
- [ ] Check the review log for scores
- [ ] Regenerate with more specific prompt if needed

---

Use this skill to create professional, accessible, and visually compelling infographics using the power of Nano Banana Pro AI with intelligent quality review.
