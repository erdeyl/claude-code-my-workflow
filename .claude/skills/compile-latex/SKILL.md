---
name: compile-latex
description: Compiles a Beamer LaTeX slide deck with XeLaTeX (3 passes + bibtex). Use when compiling lecture slides.
argument-hint: "[filename without .tex extension]"
disable-model-invocation: true
allowed-tools: Bash(xelatex *), Bash(bibtex *), Bash(latexmk *), Bash(pdfinfo *), Bash(open *), Bash(grep *), Bash(touch *), Bash(find *), Read, Glob, WebSearch
---

# Compile Beamer LaTeX Slides

ultrathink


Compile a Beamer slide deck using XeLaTeX with full citation resolution.

## Steps

1. **Auto-detect Slides directory.** Look for a directory containing `.tex` files matching `$ARGUMENTS`. Check `Slides/`, `slides/`, `decks/`, or the current directory. Fall back to `$ARGUMENTS` as a direct path if no match found.

2. **Compile with 3-pass sequence:**

```bash
cd <slides-dir>
TEXINPUTS=../Preambles:$TEXINPUTS xelatex -interaction=nonstopmode $ARGUMENTS.tex
BIBINPUTS=..:$BIBINPUTS bibtex $ARGUMENTS
TEXINPUTS=../Preambles:$TEXINPUTS xelatex -interaction=nonstopmode $ARGUMENTS.tex
TEXINPUTS=../Preambles:$TEXINPUTS xelatex -interaction=nonstopmode $ARGUMENTS.tex
```

**Alternative (latexmk):**
```bash
cd <slides-dir>
TEXINPUTS=../Preambles:$TEXINPUTS BIBINPUTS=..:$BIBINPUTS latexmk -xelatex -interaction=nonstopmode $ARGUMENTS.tex
```

3. **Check for warnings:**
   - Grep output for `Overfull \\hbox` warnings
   - Grep for `undefined citations` or `Label(s) may have changed`
   - Report any issues found

4. **Open the PDF** for visual verification:
   ```bash
   open <slides-dir>/$ARGUMENTS.pdf          # macOS
   # xdg-open <slides-dir>/$ARGUMENTS.pdf    # Linux
   ```

5. **Report results:**
   - Compilation success/failure
   - Number of overfull hbox warnings
   - Any undefined citations
   - PDF page count

## Why 3 passes?
1. First xelatex: Creates `.aux` file with citation keys
2. bibtex: Reads `.aux`, generates `.bbl` with formatted references
3. Second xelatex: Incorporates bibliography
4. Third xelatex: Resolves all cross-references with final page numbers

## Important
- **Always use XeLaTeX**, never pdflatex
- **TEXINPUTS** is required: your Beamer theme lives in `Preambles/`
- **BIBINPUTS** is required: your `.bib` file lives in the repo root
