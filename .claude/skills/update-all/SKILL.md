---
name: update-all
description: Checks and updates all local tools, packages, and configurations used by Claude Code. Audits Homebrew packages, Python venv, TeX Live, MCP servers, and skills for available upgrades. Applies safe, non-breaking updates and reports machine-side novelties. Use when the user wants to update tools, check for upgrades, maintain their Claude Code environment, or asks "is everything up to date?". Trigger for phrases like "update tools", "check for upgrades", "update everything", "maintain environment", "upgrade packages", or "system health check".
disable-model-invocation: true
allowed-tools: Bash(brew *), Bash(pip *), Bash(pip3 *), Bash(npm *), Bash(npx *), Bash(tlmgr *), Bash(uv *), Bash(gh *), Bash(git *), Bash(date *), Bash(touch *), Bash(find *), Bash(cat *), Bash(rm /tmp/update-all-*), Bash(stat *), Bash(wc *), Bash(du *), Bash(which *), Bash(ls *), Bash(head *), Bash(tail *), Bash(diff *), Bash(grep *), Bash(sort *), Bash(cut *), Bash(tr *), Bash(tee *), Bash(mktemp *), Bash(test *), Read, Write, Edit, Glob, Grep, WebSearch
---

# Update All Claude Code Tools

ultrathink

Audit and update every local tool, package, and configuration that Claude Code depends on. This is a maintenance skill — it checks what's installed, finds available upgrades, assesses safety, applies non-breaking updates, and reports anything that needs manual attention.

## Daily self-check

On the first run each day, verify this skill is current with Anthropic's latest recommendations. Check the marker file:

```bash
TODAY=$(date '+%Y-%m-%d')
MARKER="$HOME/.claude/.update-all-skill-checked-$TODAY"
if [ ! -f "$MARKER" ]; then
  echo "NEEDS_CHECK"
else
  echo "ALREADY_CHECKED"
fi
```

If `NEEDS_CHECK`:
1. Search the web for "Claude Code skills documentation site:code.claude.com" and "Claude Code SKILL.md frontmatter best practices site:platform.claude.com 2026"
2. Compare the current skill's frontmatter fields, structure, and body against what the docs recommend
3. Also check all sibling skills in `~/.claude/skills/` — read each SKILL.md's frontmatter and compare against current best practices (name format, description style third-person, allowed-tools syntax, body length <500 lines, progressive disclosure, no time-sensitive info)
4. **Subagent and agent team audit.** For every skill, evaluate whether it uses the right execution context:
   - Search the web for "Claude Code subagents agent teams best practices site:code.claude.com 2026" and "Claude Code context fork skills recommendations site:code.claude.com 2026"
   - For each skill, classify it into one of three categories:

     **Should use `context: fork` + `agent: Explore`** — read-only skills that only need Read/Grep/Glob, produce no files, and return results to the main context (e.g., bibliography validators, devil's advocate challenges)

     **Should use `context: fork`** (general-purpose agent) — self-contained tasks that spawn subagents, save reports to disk, or need Write/Bash/Agent tools but whose orchestration details should not pollute the main context (e.g., multi-agent reviews, literature searches, research ideation)

     **Should stay inline (no `context: fork`)** — skills that require conversation context, modify project files, are interactive (back-and-forth with user), or run build/deploy commands (e.g., commit, compile, deploy, interactive interviews, translation workflows that edit .qmd/.tex files)

   - Compare each skill's current `context` and `agent` frontmatter against its classification
   - Apply fixes to any misclassified skills and report changes
   - Additionally, note which read-only multi-perspective skills (audits, reviews with independent dimensions) are safe candidates for **agent teams** — but do NOT auto-enable agent teams (experimental feature); only report them as recommendations in the summary
5. If any skill (including this one) deviates from current best practices, apply fixes automatically and inform the user briefly
6. Create the marker so the check doesn't repeat today:

```bash
touch "$HOME/.claude/.update-all-skill-checked-$TODAY"
```

```bash
# Clean up old marker files (keep only today's)
find "$HOME/.claude/" -name '.update-all-skill-checked-*' ! -name ".update-all-skill-checked-$TODAY" -delete 2>/dev/null
```

If `ALREADY_CHECKED`, skip silently and proceed to the update workflow.

---

## Step 1: Inventory current tools

Build a snapshot of everything Claude Code depends on:

### 1a. Homebrew packages

```bash
brew list --versions > /tmp/update-all-brew-current.txt
brew outdated > /tmp/update-all-brew-outdated.txt
```

Focus on packages Claude Code uses directly:
- `ghostscript`, `pdf2svg`, `poppler`, `imagemagick`, `ffmpeg`
- `node`, `python`, `uv`, `gh`, `git`
- `pandoc`, `quarto` (if installed via brew)

### 1b. Python venv packages

```bash
$HOME/.claude/venv/bin/pip list --format=freeze > /tmp/update-all-pip-current.txt
$HOME/.claude/venv/bin/pip list --outdated --format=json > /tmp/update-all-pip-outdated.json 2>/dev/null
```

### 1c. Global npm packages

```bash
npm list -g --depth=0 --json 2>/dev/null > /tmp/update-all-npm-current.json
npm outdated -g --json 2>/dev/null > /tmp/update-all-npm-outdated.json
```

### 1d. TeX Live packages (if installed)

```bash
which tlmgr && tlmgr update --list 2>/dev/null | head -30 > /tmp/update-all-tex-outdated.txt
```

### 1e. Claude Code itself

```bash
claude --version 2>/dev/null || echo "claude CLI not found"
```

### 1f. MCP servers

```bash
cat "$HOME/.claude/mcp-needs-auth-cache.json" 2>/dev/null
cat "$HOME/.claude/settings.json" 2>/dev/null | grep -A5 '"mcpServers"'
```

Note any MCP servers with expired auth or that failed to connect recently.

## Step 2: Assess available updates

For each outdated item, classify by risk:

**Safe updates** (auto-apply):
- Patch-level bumps (e.g., 1.2.3 → 1.2.4) for all packages
- Minor bumps for well-known stable tools (git, gh, ghostscript, poppler)
- Python packages in the Claude venv that are patch-level only

**Review updates** (report to user, don't auto-apply):
- Major version bumps for any package
- Minor bumps for Python packages (API changes possible)
- Node.js major version changes
- Any TeX Live package updates (require sudo)
- Claude Code CLI version changes

**Blocked updates** (never auto-apply):
- Python system interpreter upgrades
- macOS system tools
- Anything requiring `sudo` (report command for user to run)

## Step 3: Web search for machine-side novelties

Search for recent improvements that materially benefit Claude Code on this machine:

```
Search: "Claude Code new features changelog 2026"
Search: "Claude Code MCP servers recommended 2026"
Search: "Homebrew packages for AI coding assistants 2026"
```

Assess each finding against these criteria:
- Does it materially improve Claude Code's capabilities on this machine?
- Is it a stable release (not alpha/beta)?
- Does it integrate with existing tools without conflicts?
- Is the installation reversible if something breaks?

Only recommend findings that pass all four criteria.

## Step 4: Apply safe updates

### 4a. Homebrew safe updates

```bash
brew upgrade <package-name>
```

Only for packages classified as safe in Step 2. Run each individually, not `brew upgrade` (blanket).

### 4b. Python venv safe updates

```bash
$HOME/.claude/venv/bin/pip install --upgrade <package-name>
```

Only for patch-level bumps.

### 4c. npm safe updates

```bash
npm update -g <package-name>
```

Only for patch-level bumps of packages Claude Code actually uses.

## Step 5: Verify nothing broke

After applying updates, run quick smoke tests:

```bash
# Core tools still work
git --version
gh --version
python3 --version
node --version
gs --version 2>/dev/null
pdf2svg 2>&1 | head -1

# Claude venv still works
$HOME/.claude/venv/bin/python3 -c "import pypdf, pdfplumber, reportlab; print('venv OK')"

# Check if any brew package is broken
brew doctor 2>&1 | head -10
```

If any smoke test fails, report the failure prominently and suggest rollback steps.

## Step 6: Sync backup repo

After all updates and smoke tests pass, sync the live `~/.claude/` setup to the backup repo and push.

**Repo location:** `~/Library/CloudStorage/GoogleDrive-erdeyl@erdey.info/Saját meghajtó/Claude/claude-code-my-workflow`
**Remote:** `origin` → `https://github.com/erdeyl/claude-code-my-workflow`

```bash
REPO="$HOME/Library/CloudStorage/GoogleDrive-erdeyl@erdey.info/Saját meghajtó/Claude/claude-code-my-workflow"

# Sync skills (mirror live state, remove deleted skills)
rsync -av --delete --exclude='.git' "$HOME/.claude/skills/" "$REPO/.claude/skills/"

# Remove any nested .git dirs from cloned skills
find "$REPO/.claude/skills" -mindepth 2 -name ".git" -type d -exec rm -rf {} + 2>/dev/null
find "$REPO/.claude/skills" -mindepth 2 -name ".git" -type f -exec rm -f {} + 2>/dev/null

# Sync other config files
cp "$HOME/.claude/settings.json" "$REPO/.claude/settings.json"
[ -d "$HOME/.claude/hooks" ] && rsync -av --delete "$HOME/.claude/hooks/" "$REPO/.claude/hooks/"
[ -d "$HOME/.claude/rules" ] && rsync -av --delete "$HOME/.claude/rules/" "$REPO/.claude/rules/"
[ -d "$HOME/.claude/agents" ] && rsync -av --delete "$HOME/.claude/agents/" "$REPO/.claude/agents/"
[ -d "$HOME/.claude/scripts" ] && mkdir -p "$REPO/.claude/scripts" && rsync -av --delete "$HOME/.claude/scripts/" "$REPO/.claude/scripts/"

# Export venv requirements
"$HOME/.claude/venv/bin/pip" freeze > "$REPO/.claude/requirements.txt" 2>/dev/null

# Sync MEMORY.md and CLAUDE.md from project memory
PROJECT_DIR="$HOME/.claude/projects/-Users-erdeylaszlo-Library-CloudStorage-GoogleDrive-erdeyl-erdey-info-Saj-t-meghajt--Claude"
[ -f "$PROJECT_DIR/memory/MEMORY.md" ] && cp "$PROJECT_DIR/memory/MEMORY.md" "$REPO/MEMORY.md"
[ -f "$PROJECT_DIR/CLAUDE.md" ] && cp "$PROJECT_DIR/CLAUDE.md" "$REPO/CLAUDE.md"
```

Then check if there are changes to commit:

```bash
cd "$REPO" && git add -A && git diff --cached --quiet
```

If there are staged changes:
1. Commit with a descriptive message summarizing what changed (updated skills, new packages, config changes, etc.)
2. Push to `origin main`
3. Report the commit hash and file count in the summary

If no changes, report "Backup repo already up to date" in the summary.

## Step 7: Summary report

Present a clean, scannable report:

```
## Update-all complete

### Updates applied
- ghostscript: 10.07.0 → 10.07.1 ✓
- pypdf: 6.9.1 → 6.9.2 ✓
- gh: 2.65.0 → 2.65.1 ✓

### Updates available (manual action needed)
- latexmk: not installed → run `sudo tlmgr install latexmk`
- biber: not installed → run `sudo tlmgr install biber`
- node: 22.x → 23.x (major bump — review before upgrading)

### MCP servers
- scite: auth expired — reconnect via MCP settings
- playwright: OK
- filesystem: OK

### Skills audit
- 48 skills checked
- 2 updated to match latest Anthropic recommendations
- 0 issues found

### Subagent / agent team audit
- N skills using context: fork (correct)
- N skills staying inline (correct)
- N skills reclassified (details above)
- Agent team candidates: [list read-only multi-perspective skills, or "none new"]

### Machine-side novelties
- [description of any relevant finding, or "No actionable novelties found"]

### Backup repo
- Synced and pushed to erdeyl/claude-code-my-workflow @ [commit-hash]
- N files changed (+X / -Y lines)

### Smoke tests
- All core tools: PASS ✓
- Python venv: PASS ✓
- Brew health: PASS ✓
```

Omit sections with no content.

## Rules

- **Never run `brew upgrade` without specifying package names.** Always upgrade individually.
- **Never upgrade the system Python.** Only manage the Claude venv at `~/.claude/venv/`.
- **Never run `sudo` commands.** Report them as "manual action needed" for the user.
- **Never modify `~/.claude/settings.json` or `~/.claude/settings.local.json`** — report MCP issues for the user to fix.
- **Always verify after updating.** If a smoke test fails, revert the specific package: `brew install <package>@<old-version>` or `pip install <package>==<old-version>`.
- **Be conservative.** When in doubt, report an update as "review needed" rather than auto-applying.
- **Clean up temp files** (`/tmp/update-all-*`) when done.
- **Keep the output concise.** The user wants to know what changed, what needs attention, and whether anything broke — not a full package manifest.
- **Never install new packages** unless the user explicitly requested them. Only upgrade existing ones.
