---
name: tidy-up
description: Synchronizes the local repo with the remote and clean up stale local branches, untracked files, and build artifacts. Use when the user wants to clean up their repo, remove old branches, delete stale local branches that have been merged or deleted upstream, clean build artifacts, or generally tidy their working directory. Trigger for phrases like "clean up branches", "tidy up", "remove old branches", "clean the repo", "prune local branches", "delete merged branches", "clean up my workspace", or "housekeeping".
argument-hint: "[--force]"
disable-model-invocation: true
allowed-tools: Bash(git *), Bash(gh *), Bash(stat *), Bash(date *), Bash(find *), Bash(rm /tmp/tidy-*), Bash(cat /tmp/tidy-*), Bash(touch *), Bash(wc *), Bash(du *), Bash(xargs *), Read, Grep, Glob, WebSearch
---

# Tidy Up Local Repository

ultrathink

Synchronize the local repository with the remote, then identify and clean up stale branches, untracked files, and build artifacts. This is a destructive operation — always show the user what will be removed and get explicit confirmation before deleting anything.

If $ARGUMENTS contains `--force`, skip the confirmation prompt and proceed with all deletions. Otherwise, always ask before each category of deletion.

## Prerequisites

Verify we're inside a git repo and have a remote configured:

```bash
git rev-parse --is-inside-work-tree && git remote -v
```

If not a git repo or no remote, tell the user and stop.

Also detect the default branch name (main, master, develop, etc.):

```bash
git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@' || echo "main"
```

Store this as `DEFAULT_BRANCH` — it's used throughout the cleanup to avoid deleting the primary branch.

## Step 1: Fetch and prune remote-tracking refs

Sync with the remote first so we have an accurate picture of what exists upstream:

```bash
git fetch --all --prune --tags 2>&1
```

This removes remote-tracking refs for branches that no longer exist on the remote.

## Step 2: Identify stale local branches

Find local branches whose upstream tracking branch is gone (was deleted on the remote):

```bash
git for-each-ref --format='%(refname:short) %(upstream:short) %(upstream:track)' refs/heads/ > /tmp/tidy-branch-status.txt
```

Classify branches into these categories:

### 2a. Branches with deleted upstream (gone)

These had a tracking branch that no longer exists on the remote — the PR was likely merged or the remote branch was deleted:

```bash
git for-each-ref --format='%(refname:short) %(upstream:track)' refs/heads/ | grep '\[gone\]'
```

These are the safest to delete — the remote already removed them.

### 2b. Fully merged branches

Local branches that are fully merged into the default branch:

```bash
git branch --merged $DEFAULT_BRANCH | grep -v -E "^\*|$DEFAULT_BRANCH"
```

### 2c. Branches with no upstream and no recent commits

Local branches that never had a tracking branch and haven't been touched in over 30 days:

```bash
git for-each-ref --sort=committerdate --format='%(refname:short) %(committerdate:iso8601) %(upstream:short)' refs/heads/
```

Flag branches with no upstream whose last commit is older than 30 days.

### 2d. Cross-check with GitHub PRs (if `gh` is available)

For branches that aren't obviously stale, check if their associated PR was merged or closed:

```bash
gh pr list --state merged --json headRefName --limit 100
gh pr list --state closed --json headRefName --limit 100
```

A local branch whose PR is merged or closed is safe to suggest for deletion.

## Step 3: Identify unnecessary files and folders

### 3a. Build artifacts and caches

Look for common build output and cache directories that can be regenerated:

```bash
# Common build/cache directories — check which exist
for dir in node_modules/.cache .next .nuxt dist build .parcel-cache \
           __pycache__ .pytest_cache .mypy_cache .ruff_cache \
           .gradle/caches .sass-cache .turbo .webpack-cache \
           coverage .nyc_output .angular/cache; do
  if [ -d "$dir" ]; then
    du -sh "$dir" 2>/dev/null
  fi
done
```

### 3b. Untracked files (git clean dry-run)

Show what `git clean` would remove, without actually removing anything:

```bash
git clean -fdn 2>&1
```

This shows untracked files and directories that aren't in `.gitignore`. Be cautious here — untracked files might be intentional work-in-progress.

### 3c. Ignored files taking up space

Show the largest ignored files/directories that could be cleaned:

```bash
git ls-files --others --ignored --exclude-standard --directory | head -20
```

For the top entries, show their sizes:

```bash
du -sh <path> 2>/dev/null
```

## Step 4: Present the cleanup plan

Before deleting anything, present a clear summary to the user. Group by category and risk level:

```
## Tidy-up plan

### Branches to delete (safe — upstream gone or PR merged)
- feature/old-widget (upstream deleted, last commit 2 weeks ago)
- fix/typo-readme (PR #42 merged 5 days ago)
- hotfix/login-bug (fully merged into main)

### Branches to consider deleting (review recommended)
- experiment/new-api (no upstream, last commit 45 days ago)
- wip/refactor (no upstream, last commit 60 days ago)

### Build artifacts / caches (regenerable)
- node_modules/.cache (128MB)
- .next (45MB)
- __pycache__ (2MB)
Total: ~175MB reclaimable

### Untracked files
- temp-debug.log (4KB)
- scratch.js (1KB)

### Protected (will NOT touch)
- Current branch: feature/my-work
- Default branch: main
- Branches with uncommitted upstream changes
```

## Step 5: Execute cleanup (with confirmation)

Unless `--force` was passed, ask the user what they want to clean. They can approve all, or pick specific categories:
- "Delete all safe branches?"
- "Remove build artifacts?"
- "Clean untracked files?"

### Deleting branches

For each approved branch deletion:

```bash
git branch -d <branch-name>   # safe delete (fails if not merged)
```

If `-d` fails on a "gone" branch (it was rebased/squashed so git doesn't recognize it as merged), use:

```bash
git branch -D <branch-name>   # force delete
```

Only use `-D` for branches whose upstream is confirmed gone or whose PR is confirmed merged/closed. Never force-delete without evidence that the work was already integrated.

### Cleaning build artifacts

```bash
rm -rf <path>
```

Only for directories the user approved from the list shown in Step 4.

### Cleaning untracked files

```bash
git clean -fd <specific-paths>
```

Only for files the user approved. Never run `git clean -fd` without specifying paths unless the user explicitly asked for a full clean.

## Step 6: Summary report

After cleanup, show what was done:

```
## Tidy-up complete

### Branches deleted (5)
- feature/old-widget
- fix/typo-readme
- hotfix/login-bug
- experiment/new-api
- wip/refactor

### Space reclaimed
- Build artifacts: 175MB removed
- Untracked files: 5KB removed
- Total: ~175MB freed

### Current state
- Local branches remaining: 3 (main, develop, feature/my-work)
- Working tree: clean
- Current branch: feature/my-work (up to date with origin)
```

## Rules

- **Never delete the current branch.** Switch the user away first if they ask to delete it.
- **Never delete the default branch** (main, master, develop) or any branch that is ahead of its upstream with unpushed commits.
- **Never delete branches with uncommitted work.** Check `git stash list` and warn if there are stashes that reference a branch about to be deleted.
- **Always confirm before destructive actions** unless `--force` was passed. This is the most important rule — the user trusts this skill to not lose their work.
- **Never run `git clean` without explicit paths** unless the user specifically approved a full clean.
- **Don't delete `.env` files, credentials, or config files** even if they're untracked. Flag them separately as "sensitive untracked files — review manually."
- **Clean up temp files** (`/tmp/tidy-*`) when done.
- Keep the output concise and scannable. Use relative times ("2 weeks ago") for dates.
- If nothing needs cleaning, say so and exit — don't make up work.
