export ZSH="$HOME/.oh-my-zsh"

# TMUX config https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_DEFAULT_SESSION_NAME=cr4ftx

# Zoxide config https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/zoxide
ZOXIDE_CMD_OVERRIDE=cd

# FZF config https://github.com/junegunn/fzf?tab=readme-ov-file#key-bindings-for-command-line
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS=" \
    --tmux center,80%,80% \
    --layout=reverse \
    --color=fg:#c0caf5,bg:#24283b,hl:#ff9e64 \
    --color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
    --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
    --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS=" --preview 'fzf-preview.sh {}'"

# NVM config https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/nvm
zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' lazy-cmd git nvim
zstyle ':omz:plugins:nvm' autoload yes
# YARN config https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/yarn
zstyle ':omz:plugins:yarn' global-path no
# FZF TAB config https://github.com/Aloxaf/fzf-tab?tab=readme-ov-file#configure
zstyle ':fzf-tab:*' use-fzf-default-opts yes

plugins=(
    sudo
    vi-mode
    brew # always place brew before tmux if tmux is installed with brew
    tmux
    fzf
    fzf-tab
    zsh-autosuggestions
    zsh-syntax-highlighting
    git
    nvm
    yarn
    starship
    zoxide
    gpg-agent
    gh
    eza
)

source $ZSH/oh-my-zsh.sh

if command -v bat &> /dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'" # set better man page with bat
    # some aliases
    alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
    alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
fi

alias v="nvim"
alias vi="nvim"
alias vim="nvim"

autoload -Uz compinit
compinit
