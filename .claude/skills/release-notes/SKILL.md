---
name: release-notes
description: Generates release notes from git history, PRs, and changelog entries. Use when asked to create release notes, a changelog, or summarize changes for a version or time period.
argument-hint: [version-or-range]
allowed-tools: Bash(git *), Bash(gh *), Read, Grep, Glob, Agent, WebSearch
---

# Release Notes Generator

ultrathink

Generate structured release notes from git history, merged PRs, and existing changelogs.

If $ARGUMENTS is provided, use it as the version tag or commit range (e.g., `v1.2.0`, `v1.1.0..v1.2.0`, `--since=2026-03-01`). Otherwise, infer the range from the latest tag to HEAD.

## Step 1: Gather context (parallel)

Run these in parallel via Bash:

```bash
# Latest tags and range
git tag --sort=-v:refname | head -5
git log --oneline --no-merges $RANGE

# Merged PRs (if GitHub repo)
gh pr list --state merged --limit 50 --json number,title,labels,mergedAt,body

# Existing changelog
cat CHANGELOG.md 2>/dev/null || cat CHANGES.md 2>/dev/null || echo "No changelog found"
```

Also launch an **Explore** subagent (Haiku, background) to:
- Check for release config (`.releaserc`, `release.config.js`, `cliff.toml`)
- Identify the project's changelog convention (Keep a Changelog, Conventional Commits, custom)
- Read CLAUDE.md for any release-specific instructions

## Step 2: Classify changes (fan-out, Sonnet subagents)

Launch **3 subagents in parallel** (background, Sonnet) to classify commits:

### Agent A: Features & Enhancements
- Identify new features, capabilities, API additions
- Group by component/module
- Extract user-facing descriptions from PR bodies and commit messages
- Note breaking changes

### Agent B: Bug Fixes & Corrections
- Identify bug fixes with their root causes
- Link to issues/PRs where available
- Classify severity: critical (data loss, security), major (functionality broken), minor (cosmetic, edge case)

### Agent C: Infrastructure & Maintenance
- Dependency updates, CI/CD changes, refactors
- Documentation changes
- Performance improvements
- Deprecations

## Step 3: Fan-in & Draft

After all agents complete, synthesize into release notes following the project's existing convention. If no convention exists, use **Keep a Changelog** format:

```markdown
## [version] - YYYY-MM-DD

### Breaking Changes
- Description (PR #N)

### Added
- Feature description (PR #N, @author)

### Fixed
- Bug fix description (PR #N)
  - Root cause: ...

### Changed
- Change description (PR #N)

### Deprecated
- Deprecation notice

### Security
- Security fix description (PR #N)

### Infrastructure
- CI/CD, deps, refactors (summarized, not itemized unless significant)
```

## Step 4: Validation

- Verify every PR/issue link is valid: `gh pr view N --json state`
- Cross-check that no merged PRs in the range are missing from the notes
- Check for duplicate entries
- Verify the version number follows the project's versioning scheme

## Step 5: Output

Present the release notes in the terminal. Then ask:
1. "Write to CHANGELOG.md?" (prepend to existing file or create new)
2. "Create a GitHub release?" (`gh release create`)

## Rules

- **FULLY AUTONOMOUS for reading.** All read-only tools pre-authorized. No AskUserQuestion during research.
- **Prefer dedicated tools.** Read over `cat`, Grep over `grep`, Glob over `find`.
- If no git history exists, report that and stop.
- Attribute changes to authors when PR data is available.
- Keep descriptions user-facing and concise — avoid internal jargon.
- Group related changes together rather than listing each commit separately.
- For large releases (50+ commits), summarize infrastructure changes instead of itemizing.
