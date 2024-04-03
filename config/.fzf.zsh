# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
    PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--height 99% --layout=reverse'
# Tokyonight color
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
    --color=fg:#c0caf5,bg:#24283b,hl:#ff9e64 \
    --color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
    --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
    --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"
export FZF_CTRL_T_OPTS="\
    --walker-skip .git,node_modules,target,bin,build,dist \
    --preview 'fzf-preview.sh {}'"
