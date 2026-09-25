---
name: workflow
description: "Start work on a ticket ('start ARS-123', a Linear ID or URL) or any task that writes files in a git repo: implement, fix, refactor. Covers the worktree and branch name, TDD slice by slice, conventional commits, the checks that gate done, a code review before pushing, the draft PR, watching CI, and removing the worktree once the work is signed off."
---

Never edit the repo's currently checked-out branch, especially `main`/`master`. Work happens on a new branch in a new worktree, is built slice by slice test-first, and lands as a reviewed draft PR with green CI.

Steps 1–7 run in order, without asking, except where a step says to stop. Cleanup is a separate branch, triggered much later.

## 0. Does this apply?

Yes for anything that writes files in a git repo.

Stay in place for: read-only questions, exploration and search, a single-command chore, a non-git directory, or when I explicitly say to edit in place.

## 1. Settle the branch name first

The name comes from Linear when a ticket exists, and is used verbatim.

1. **Ticket referenced or identifiable** — I mention an ID like `ARS-123`, paste a Linear URL, or the task clearly maps to an existing issue: fetch it with `mcp__linear-server__get_issue` and take its `gitBranchName` exactly as returned (e.g. `swanncastel/ars-123-fix-login-redirect`). Never reconstruct or shorten it.
2. **No ticket** — ask me whether to create one, and wait.
   - Yes → create the Linear issue, then use its `gitBranchName` as in (1).
   - No → `swanncastel/<slug>`, where `<slug>` is a short kebab-case description of the task.

With a ticket, move it to **In Progress** with `mcp__linear-server__save_issue` before going further — unless it's already there or further along (In Review, Done). The team's status may be named differently; check `mcp__linear-server__list_issue_statuses` for its `started`-type status rather than guessing.

Keep the ticket text in context. Step 5 hands it to the review's Spec axis, which has no way to fetch it on its own.

## 2. Enter the worktree

Prefer `EnterWorktree`, or `Agent` with `isolation: "worktree"` when delegating.

Manual fallback, from the repo root:

```
git worktree add .claude/worktrees/<branch-slug> -b <branch-name>
```

Always that path. Never a sibling of the repo.

## 3. Implement in vertical slices, test-first

Invoke the `mattpocock-skills:tdd` skill and follow it for the whole implementation. It is the reference for what a good test is, where the seams are, and the rules of the red → green loop.

Before the first slice, present two things and **stop**:

- **The slices** — the feature cut into vertical slices, in the order you'll build them. A slice is one seam, one test, one minimal implementation: a tracer bullet, not a layer.
- **The seams under test** — tdd writes no test at an unconfirmed seam, so confirming them here is what stops the question being re-asked every cycle.

Then run the loop per slice, without asking between slices:

1. Red — the failing test.
2. Green — only enough code to pass it.
3. Commit the slice (step 4's format).

Refactoring is not part of this loop. It belongs to the review in step 6.

Let what a slice teaches you reshape the ones still ahead. If the plan stops matching the code, say so and re-cut it rather than forcing the original list.

## 4. Commit as you go

Conventional Commits, with the Linear ID as a bare suffix on the subject line — no brackets, no parens:

```
fix(auth): redirect to intended page after login ARS-123
```

- `feat` / `fix` / `chore` / `refactor` / `docs` / `test`, optional scope in parens.
- No ticket → no suffix, just the conventional subject.
- Body is optional and explains *why*, not what.
- One commit per slice, plus any logical chunk in between. Don't ask first.

## 5. Verify

**Typecheck**, **lint + format**, and **tests** all pass on the changed project — the full suite, or at minimum the tests covering the change. This step is done when each of the three has either passed or been reported to me with its real output.

**Resolve each against the project's own scripts. Don't assume a tool.** Read the task manifest first — `package.json` `scripts`, then `Makefile` / `justfile` / `Taskfile.yml` / `pyproject.toml` / `Cargo.toml`, plus any CI workflow showing the canonical commands — and run the matching script with the project's own runner. Prefer one script that covers a whole type (a `check` that runs lint + format) over calling the tool directly.

- **Monorepo**: run the scripts of the package(s) actually changed, not the whole workspace, unless only a root script exists.
- No matching script → fall back to what the config implies: `tsconfig.json` → `tsc --noEmit`; an eslint/biome/prettier config → that tool on the changed files.
- No script *and* no config → skip that check, and say which one you skipped and why. Don't invent a command.

A failing check gets fixed, or gets reported plainly as failing. Neither one is silent.

## 6. Review before pushing

Invoke the `mattpocock-skills:code-review` skill. Give it both inputs it needs up front, so it asks for neither:

- **Fixed point**: the default branch on the remote. Resolve it, never assume `main`: `git symbolic-ref --short refs/remotes/origin/HEAD`.
- **Spec**: the Linear ticket text from step 1, pasted in. The repos carry no `docs/agents/issue-tracker.md`, so handing the ticket over explicitly is what makes the Spec axis work at all.

This is the refactoring stage the tdd loop deferred. Act on the findings: fix what's worth fixing, and tell me which findings you're leaving and why. Any change made here sends you back through step 5 before pushing.

## 7. Push and open a draft PR

Once steps 5 and 6 are clean: push the branch, open a **draft** PR, hand back the link.

- Link the Linear issue in the PR body when there is one.
- Carry the review findings you chose not to fix into the PR body, under a heading that flags them for a second opinion.
- Draft, not ready-for-review. I promote it myself.

## 8. Watch CI and fix it

Poll the GitHub Actions run for the branch (`gh run watch`, `gh run list --branch <branch>`). On failure, pull the failing job's logs, fix the cause, push again. Report when it's green, with the run URL.

Stop and tell me what's failing if the same job fails around three times, or if the fix isn't obvious. Thrashing is worse than handing it back.

## Hand-back

Report the worktree path and the branch name. Leave the worktree in place.

## Cleanup — only on my signal

Remove the worktree once I say the work is finished: "done", "merged", "ship it", "clean up", or the branch is merged / the PR closed. A finished task is not that signal.

Check before removing, always:

```
git -C <path> status --porcelain
git -C <path> log --branches --not --remotes
```

Uncommitted changes or unpushed commits → tell me what would be lost and wait for my go-ahead. `--force` only when I ask for it.

Then prefer `ExitWorktree`; manual fallback from the main checkout: `git worktree remove <path>`, then `git worktree prune`.

Delete the worktree, not the work: the branch stays.
