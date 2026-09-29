#!/usr/bin/env bash

# Run by the alert-bell hook. Writing to the client tty instead of our own output sends the
# OSC 99 notification straight to kitty, so tmux passthrough isn't needed.

set -euo pipefail

client_tty=$1
pane=$2

# bell-action any also fires for the window on screen, which only needs a notification when
# kitty is in the background
if [[ $(tmux display -p -t "$pane" '#{window_active}') == 1 &&
  $(tmux display -p -c "$client_tty" '#{client_flags}') == *focused* ]]; then
  exit 0
fi

title=$(tmux display -p -t "$pane" '#{session_name}:#{window_name}')
body=$(tmux display -p -t "$pane" '#{pane_title}')

printf '\e]99;i=tmux:d=0;%s\e\\\e]99;i=tmux:d=1:p=body;%s\e\\' "$title" "$body" >"$client_tty"
tmux set -g @notify_target "$pane"
