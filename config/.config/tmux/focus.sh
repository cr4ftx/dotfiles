#!/usr/bin/env bash

# Run by the client-focus-in hook. kitty can't tell tmux which notification was clicked, so the
# first refocus after a bell jumps to the pane that rang, then forgets it.

set -euo pipefail

client=$1

target=$(tmux show -gv @notify_target 2>/dev/null || true)
[[ -n $target ]] || exit 0

tmux set -gu @notify_target
tmux switch-client -c "$client" -t "$target" \; select-window -t "$target" \; select-pane -t "$target"
