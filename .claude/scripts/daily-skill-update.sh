#!/bin/bash
# Daily skill auto-update for Claude Code
# Pulls latest from erdeyl/claude-setup and copies updated skills.
# Called by SessionStart hook — runs at most once per calendar day.

set -euo pipefail

CLAUDE_DIR="$HOME/.claude"
STAMP_FILE="$CLAUDE_DIR/.last-skill-update"
REPO_DIR="$HOME/claude-setup"
TODAY=$(date +%Y-%m-%d)

# Check if already updated today
if [ -f "$STAMP_FILE" ] && [ "$(cat "$STAMP_FILE")" = "$TODAY" ]; then
    exit 0
fi

# Ensure repo exists
if [ ! -d "$REPO_DIR/.git" ]; then
    echo '{"hookSpecificOutput":{"additionalContext":"[daily-update] claude-setup repo not found at ~/claude-setup. Skipping."}}' >&2
    exit 0
fi

# Pull latest
cd "$REPO_DIR"
git pull --ff-only origin main 2>/dev/null || true

# Sync all custom skills (only if source files exist and are newer)
for skill in \
    audit audit-pr commit compile-latex context-status create-lecture \
    data-analysis deep-audit deploy devils-advocate extract-tikz fetch \
    interview-me learn lit-review newproject pedagogy-review proofread \
    qa-quarto release-notes research-ideation review-paper review-r \
    slide-excellence split-pdf-academic stat-dev tidy-up \
    translate-to-quarto validate-bib visual-audit; do
    src="$REPO_DIR/global/skills/$skill/SKILL.md"
    dst="$CLAUDE_DIR/skills/$skill/SKILL.md"
    if [ -f "$src" ]; then
        mkdir -p "$(dirname "$dst")"
        if [ ! -f "$dst" ] || [ "$src" -nt "$dst" ]; then
            cp "$src" "$dst"
        fi
    fi
done

# Sync notebooklm SKILL.md only (full install is via git clone in setup.sh)
src="$REPO_DIR/global/skills/notebooklm/SKILL.md"
dst="$CLAUDE_DIR/skills/notebooklm/SKILL.md"
if [ -f "$src" ] && [ -d "$CLAUDE_DIR/skills/notebooklm" ]; then
    if [ ! -f "$dst" ] || [ "$src" -nt "$dst" ]; then
        cp "$src" "$dst"
    fi
fi

# Sync settings.json (only if repo version is newer)
src="$REPO_DIR/global/settings.json"
dst="$CLAUDE_DIR/settings.json"
if [ -f "$src" ] && [ "$src" -nt "$dst" ]; then
    cp "$src" "$dst"
fi

# Sync this script itself (keep hook in sync with repo)
src="$REPO_DIR/global/scripts/daily-skill-update.sh"
dst="$CLAUDE_DIR/scripts/daily-skill-update.sh"
if [ -f "$src" ] && [ "$src" -nt "$dst" ]; then
    cp "$src" "$dst"
    chmod +x "$dst"
fi

# Update timestamp
echo "$TODAY" > "$STAMP_FILE"

exit 0
