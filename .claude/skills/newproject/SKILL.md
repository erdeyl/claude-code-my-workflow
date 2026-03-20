---
name: newproject
description: Creates a standard research project directory scaffold with CLAUDE.md, README, code, data, output, documents, and progress logs.
argument-hint: "[project-name]"
disable-model-invocation: true
allowed-tools: Bash(mkdir *), Bash(cp *), Bash(touch *), Bash(find *), Read, Write, WebSearch
---

# New Project Scaffold

ultrathink


Create a consistent directory structure for a new research project.

**Input:** `$ARGUMENTS` — the project name (kebab-case preferred, e.g., `my-project-name`).

## What It Creates

```
$ARGUMENTS/
├── CLAUDE.md              # Research rules & estimation philosophy (permanent)
├── README.md              # Project-specific notes
├── code/
│   ├── R/                 # R scripts
│   ├── python/            # Python scripts
│   └── stata/             # Stata do-files
├── data/
│   ├── raw/               # Original source data (never modify these)
│   └── clean/             # Cleaned and merged datasets
├── output/
│   ├── tables/            # Generated tables (LaTeX, CSV)
│   └── figures/           # Generated figures (PDF, PNG)
├── documents/             # Outside papers and PDFs (split with /split-pdf-academic)
├── decks/                 # Beamer presentations
├── notes/                 # Scratch notes, ideas, miscellaneous
└── progress_logs/         # Session logs for continuity across Claude conversations
```

## Steps

1. **Create the directory tree:**

```bash
PROJECT="$ARGUMENTS"
mkdir -p "$PROJECT"/{code/{R,python,stata},data/{raw,clean},output/{tables,figures},documents,decks,notes,progress_logs}
```

2. **Create CLAUDE.md** from template. Check for a permanent template at:
   - `~/mixtapetools/claude/CLAUDE.md`
   - `~/.claude/templates/CLAUDE.md`
   - If no template found, create a minimal CLAUDE.md with research rules scaffold

3. **Create README.md** with project metadata:

```markdown
# [Project Name]

**Created:** [YYYY-MM-DD]
**Status:** Setup

## Research Question
[To be defined]

## Directory Structure
- `code/` — Analysis scripts (R, Python, Stata)
- `data/raw/` — Original source data (read-only by convention)
- `data/clean/` — Processed datasets
- `output/` — Generated tables and figures
- `documents/` — Reference papers and PDFs
- `decks/` — Presentations
- `notes/` — Scratch notes
- `progress_logs/` — Session continuity logs
```

4. **Create initial progress log:**

```markdown
# Progress Log: [YYYY-MM-DD] — Project Setup

## What was done
- Created project scaffold with /newproject
- Directory structure initialized

## Next steps
- Define research question
- Gather initial data
- Review literature
```

5. **Report** what was created and suggest next steps.

## Philosophy

### Two Configuration Files, Two Purposes

- **`CLAUDE.md`** contains research rules that apply across all sessions: estimation philosophy ("design before results"), coding conventions, collaborator information, and key methodological decisions. It is the institutional memory of the project.

- **`README.md`** is project-specific: what the research question is, who's involved, current status, and how files are organized.

### Session Continuity

The `progress_logs/` directory solves session persistence: if a session crashes or you start fresh, the progress log tells the next session exactly where you left off. Logs are dated (`YYYY-MM-DD_description.md`).

### Data Discipline

- `data/raw/` is **read-only** by convention. Original source data goes here and is never modified.
- `data/clean/` holds everything that's been transformed, merged, or constructed.
