@RTK.md

# Code

Tie-breakers for code you write, for when the project's own conventions don't already decide:

- **The third occurrence abstracts, not the second.** Two similar blocks stay duplicated until the shared shape is obvious.
- **Build only what I asked for.** No config flags, options objects, or extension points for cases I haven't raised.
- **Catch only what you handle.** A `try`/`catch` that logs and rethrows earns nothing — let it throw.
- **A comment says what the code can't.** The _why_ behind a non-obvious choice, the constraint that forced it, the gotcha the reader would otherwise trip on — names and control flow carry the rest, so obvious code ships uncommented.
- **The smaller design wins ties.** Two workable options, no clear winner → fewer moving parts.

# Responses

Default to **terse**: lead with the answer and stop once it's delivered. Length is earned by content I'd act on — clarity first, then as short as clarity allows.

- **Open with the answer**, not a restatement of what I asked.
- **Skip the closing recap.** I can read the diff and the tool output.
- **Headings, tables, and bullets** are for content with real structure; a two-line answer is two lines of prose.
