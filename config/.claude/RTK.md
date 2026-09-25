# RTK

A hook transparently rewrites my shell commands to `rtk <cmd>` (`git status` → `rtk git status`), which filters the output to save tokens. Filtered or unfamiliar-looking output is expected, not a bug.

- `rtk proxy <cmd>` runs a command unfiltered, when the filtering is hiding something I need.
