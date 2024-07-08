export AWS_PAGER=""

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Tmux config
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_DEFAULT_SESSION_NAME=cr4ftx

# Zoxide config
ZOXIDE_CMD_OVERRIDE=cd

# Fzf config
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS=" \
    --height 99% \
    --layout=reverse \
    --color=fg:#c0caf5,bg:#24283b,hl:#ff9e64 \
    --color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
    --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
    --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"
export FZF_CTRL_T_OPTS="\
    --walker-skip .git,node_modules,target,bin,build,dist \
    --preview 'fzf-preview.sh {}'"

zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' lazy-cmd git nvim

plugins=(
    sudo
    vi-mode
    brew # always place brew before tmux if tmux is installed through brew
    tmux
    zsh-autosuggestions
    zsh-syntax-highlighting
    git
    terraform
    docker
    yarn
    nvm
    fzf
    starship
    zoxide
)

source $ZSH/oh-my-zsh.sh

command -v bat &> /dev/null && export MANPAGER="sh -c 'col -bx | bat -l man -p'" # set better man page with bat
[[ -d ~/.fzf-tab-completion ]] && source ~/.fzf-tab-completion/zsh/fzf-zsh-completion.sh # tab completion with fzf

# add zsh hook to auto change node version based on .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
    nvm &> /dev/null # run nvm to load it
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
        local nvmrc_node_version=$(nvm version "\$(cat "${nvmrc_path}")")

        if [ "$nvmrc_node_version" = "N/A" ]; then
            nvm install
        elif [ "$nvmrc_node_version" != "$node_version" ]; then
            nvm use
        fi
    elif [ "$node_version" != "$(nvm version default)" ]; then
        echo "Reverting to nvm default version"
        nvm use default
    fi
}
add-zsh-hook chpwd load-nvmrc

# some aliases
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

alias v="nvim"
alias vi="nvim"
alias vim="nvim"

if command -v eza &> /dev/null; then
    alias ls="eza"
    alias ll="eza --long --icons --group --git"
    alias l="eza --long --icons --group --git --all"
    alias tree="eza --tree --icons --git --ignore-glob=.git,node_modules --all"
fi
