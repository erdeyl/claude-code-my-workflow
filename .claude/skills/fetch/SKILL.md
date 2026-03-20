---
name: fetch
description: Fetches the latest remote changes and show a summary of new/updated branches and pull requests. Use when the user wants to sync with the remote, check what changed upstream, see new or updated PRs, or catch up on a repo they haven't looked at in a while. Trigger for phrases like "what's new", "fetch changes", "sync", "catch up on PRs", "what happened upstream", or "pull updates".
argument-hint: "[remote-name]"
allowed-tools: Bash(git *), Bash(gh *), Bash(stat *), Bash(date *), Bash(diff *), Bash(rm /tmp/fetch-*), Bash(cat /tmp/fetch-*), Bash(touch *), Bash(find *), Read, Grep, Glob, WebSearch
---

# Fetch Remote Changes & PR Summary

ultrathink

Fetch the latest state from the remote repository and give the user a concise, actionable overview of what changed since they last synced.

If $ARGUMENTS is provided, use it as the remote name (e.g., `origin`, `upstream`). Otherwise, fetch from all remotes.

## Prerequisites

Verify we're inside a git repo and have a remote configured:

```bash
git rev-parse --is-inside-work-tree && git remote -v
```

If not a git repo or no remote, tell the user and stop.

Check `gh` is available and authenticated (for the PR section):

```bash
gh auth status 2>&1
```

If `gh` isn't authenticated, skip the PR section and note that in the output. Don't block the rest of the workflow on it.

## Step 1: Snapshot the current state

Before fetching, capture the current remote-tracking refs so we can diff after the fetch:

```bash
git for-each-ref --format='%(refname) %(objectname:short)' refs/remotes/ > /tmp/fetch-pre-refs.txt
```

Also note when the last fetch happened:

```bash
stat -f '%Sm' -t '%Y-%m-%d %H:%M' .git/FETCH_HEAD 2>/dev/null || echo "Never fetched"
```

## Step 2: Fetch

If a specific remote was given via $ARGUMENTS, fetch only that remote. Otherwise fetch all:

```bash
git fetch ${REMOTE:-"--all"} --prune --tags 2>&1
```

The `--prune` flag cleans up remote-tracking branches that no longer exist upstream, and `--tags` ensures we get new tags too.

## Step 3: Diff the refs

After fetching, capture the new state and compare:

```bash
git for-each-ref --format='%(refname) %(objectname:short)' refs/remotes/ > /tmp/fetch-post-refs.txt
```

Compare the two snapshots to identify:
- **New branches**: refs in post but not in pre
- **Updated branches**: refs in both but with different commit hashes
- **Deleted branches**: refs in pre but not in post (pruned)

For updated branches, show how many new commits arrived:

```bash
git log --oneline <old-hash>..<new-hash>
```

Keep commit lists short (at most 10 per branch). If there are more, show the count and the most recent 5.

## Step 4: New tags

Show any tags that appeared:

```bash
git tag --sort=-creatordate | head -5
```

Compare against pre-fetch state. Only mention genuinely new tags.

## Step 5: Pull request summary (requires `gh`)

If `gh` is available and authenticated, and the remote is GitHub, fetch recent PR activity:

```bash
# Open PRs, sorted by most recently updated
gh pr list --limit 15 --json number,title,author,updatedAt,reviewDecision,isDraft,labels,headRefName --state open

# Recently merged PRs (last 7 days)
gh pr list --limit 10 --json number,title,author,mergedAt,headRefName --state merged --search "merged:>=$(date -v-7d '+%Y-%m-%d' 2>/dev/null || date -d '7 days ago' '+%Y-%m-%d')"
```

Organize the output into:
- **PRs needing your review**: where you are a requested reviewer (determine the current user via `gh api user --jq .login`)
- **Open PRs** (non-draft first, then drafts)
- **Recently merged**

For each PR show: `#number title (author, last updated/merged date)`

If the repo is not on GitHub or `gh` is not available, skip this section gracefully.

## Step 6: Current branch status

Show how the user's current branch compares to its upstream:

```bash
git status -sb
git log --oneline HEAD..@{upstream} 2>/dev/null | head -5   # incoming commits
git log --oneline @{upstream}..HEAD 2>/dev/null | head -5   # outgoing commits
```

Tell them if their branch is ahead, behind, or diverged from upstream, and by how many commits.

## Output format

Present a clean, scannable summary. Use this structure:

```
## Remote sync complete

Last fetch: <previous fetch time> -> now
Remote: <remote-name> (<url>)

### Branch changes
- <new/updated/deleted branch summaries>

### New tags
- <tag list>

### Pull requests
**Needs your review:**
- #42 Fix auth timeout (alice, updated 2h ago)

**Open:**
- #38 Add dashboard widget (bob, updated 1d ago)
- #35 [Draft] Refactor DB layer (charlie, updated 3d ago)

**Recently merged:**
- #31 Migrate to v2 API (dana, merged yesterday)

### Your branch: main
- Up to date with origin/main
```

Omit any section that has no content — don't show empty headings.

## Rules

- This is a read-only operation. Never run `git pull`, `git merge`, or `git rebase` — only `git fetch`.
- If the user asks to also pull or merge, tell them what you found and let them decide which branches to integrate.
- Clean up temp files (`/tmp/fetch-pre-refs.txt`, `/tmp/fetch-post-refs.txt`) when done.
- Keep the output concise. The goal is a quick "what do I need to know" summary, not an exhaustive log.
- Use relative times where possible ("2 hours ago", "yesterday") to make the output scannable.
