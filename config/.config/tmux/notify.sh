#!/usr/bin/env bash

# Run by the alert-bell hook. Writing to the client tty instead of our own output sends the
# OSC 99 notification straight to kitty, so tmux passthrough isn't needed.

set -euo pipefail

client_tty=$1
pane=$2

title=$(tmux display -p -t "$pane" '#{session_name}:#{window_name}')
body=$(tmux display -p -t "$pane" '#{pane_title}')

printf '\e]99;i=tmux:d=0;%s\e\\\e]99;i=tmux:d=1:p=body;%s\e\\' "$title" "$body" >"$client_tty"
