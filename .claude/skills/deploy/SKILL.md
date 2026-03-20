---
name: deploy
description: Render Quarto slides and sync to docs/ for GitHub Pages deployment. Use when deploying lecture slides after making changes.
argument-hint: "[LectureN or 'all']"
disable-model-invocation: true
allowed-tools: Read, Bash(./scripts/*), Bash(quarto *), Bash(open *), Bash(grep *), Bash(ls *), Bash(touch *), Bash(find *), WebSearch
---

# Deploy Slides to GitHub Pages

ultrathink


Render Quarto slides and sync all files to `docs/` for GitHub Pages deployment.

## Steps

1. **Auto-detect sync script.** Look for `scripts/sync_to_docs.sh`, `sync_to_docs.sh`, or similar. If not found, perform manual sync steps.

2. **Run the sync script:**
   - If `$ARGUMENTS` is provided (e.g., "Lecture4"): `./scripts/sync_to_docs.sh $ARGUMENTS`
   - If no argument: `./scripts/sync_to_docs.sh` (syncs all lectures)

3. **Verify deployment:**
   - Check that HTML files exist in `docs/slides/`
   - Check that `_files/` directories were copied (RevealJS assets)
   - Check that figures directory was synced

4. **Verify interactive charts** (if applicable):
   - Grep rendered HTML for interactive widget count
   - Confirm count matches expected

5. **Verify TikZ SVGs** (if applicable):
   - Check that all referenced SVG files exist in the docs figures directory

6. **Open in browser** for visual verification:
   - `open docs/slides/LectureX_Name.html`          # macOS
   - `# xdg-open docs/slides/LectureX_Name.html`    # Linux
   - Confirm slides render, images display, navigation works

7. **Report results** to the user

## What the sync script does:
- Renders all `.qmd` files in `Quarto/` (skips `*_backup*` files)
- Copies HTML and `_files/` directories to `docs/slides/`
- Copies Beamer PDFs from `Slides/` to `docs/slides/`
- Syncs figures using rsync
