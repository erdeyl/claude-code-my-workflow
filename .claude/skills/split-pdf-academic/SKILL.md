---
name: split-pdf-academic
description: Reads academic PDFs by splitting into 4-page chunks, extracting structured notes with citations, and building a synthesis. Use when reading papers, referee reports, or any long academic PDF.
argument-hint: "[path to PDF file]"
allowed-tools: Read, Write, Bash(python3 *), Bash(pdfinfo *), Bash(touch *), Bash(find *), Bash(mkdir *), Glob, WebSearch
---

# Split and Read Academic PDF

ultrathink


Read academic PDFs by splitting them into manageable chunks, extracting structured notes with citations, and building a cumulative synthesis.

**Input:** `$ARGUMENTS` — path to the PDF file.

## Why Split?

Claude Code's PDF reader has page limits per request. Academic papers are often 30-60 pages. Splitting into 4-page chunks ensures reliable reading while maintaining context across chunks.

## Workflow

### Step 1: Get PDF Metadata

```bash
pdfinfo "$ARGUMENTS"
```

Extract total page count and title.

### Step 2: Split the PDF into 4-Page Chunks

Use Python with pypdf to split:

```bash
python3 -c "
from pypdf import PdfReader, PdfWriter
import os, sys

pdf_path = sys.argv[1]
basename = os.path.splitext(os.path.basename(pdf_path))[0]
output_dir = os.path.dirname(pdf_path) or '.'

reader = PdfReader(pdf_path)
total = len(reader.pages)
chunk_size = 4

for start in range(0, total, chunk_size):
    end = min(start + chunk_size, total)
    writer = PdfWriter()
    for i in range(start, end):
        writer.add_page(reader.pages[i])
    chunk_file = f'{output_dir}/split-pdf-{basename}_pp{start+1}-{end}.pdf'
    with open(chunk_file, 'wb') as f:
        writer.write(f)
    print(f'Created: {chunk_file}')
print(f'Total chunks: {(total + chunk_size - 1) // chunk_size}')
" "$ARGUMENTS"
```

### Step 3: Read Each Chunk Sequentially

For each 4-page chunk, read the PDF and extract:

1. **Key arguments and claims** made in these pages
2. **Data sources** mentioned (dataset names, years, coverage)
3. **Statistical methods** used (estimators, identification strategies)
4. **Equations and notation** (verbatim important equations)
5. **Findings and effect sizes** (specific numbers, confidence intervals)
6. **Citations to other work** (for bibliography cross-referencing)

Maintain a running context across chunks — refer back to earlier sections as needed.

### Step 4: Build Structured Notes

After reading all chunks, compile structured notes:

```markdown
# Reading Notes: "[Paper Title]" ([Authors], [Journal] [Year])

## Status: Complete — all [N] pages read

---

## 1. Research question and importance
[What question does the paper answer and why it matters]

## 2. Intended audience
[Who is the paper written for]

## 3. How they answer the question
[Method, model structure, identification strategy]

## 4. Data sources and where they came from
[All datasets with details]

## 5. Statistical methods
[Econometric approach, estimation details]

## 6. Findings
[Key results with effect sizes and significance]

## 7. What is learned
[Takeaways, implications for our research]

## 8. Data availability and replication access
[Replication data, code availability]
```

### Step 5: Save Notes

Save to auto-detected output directory (`documents/`, `notes/`, `quality_reports/`, or alongside the PDF). Filename: `[basename]_notes.md`

### Step 6: Clean Up Split Files (Optional)

Ask user if they want to keep or remove the split chunk PDFs.

## Important

- **Read ALL chunks** — do not stop partway through the paper
- **Maintain context** — each chunk should build on previous ones
- **Be precise with numbers** — exact effect sizes, sample sizes, standard errors
- **Note page numbers** — reference specific pages for key claims
- **Flag uncertainty** — if a section is unclear due to splitting, say so
- **Do NOT fabricate** — if you cannot read something, note it explicitly
