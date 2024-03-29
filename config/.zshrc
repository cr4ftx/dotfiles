export PATH=$PATH:$HOME/bin:/opt/homebrew/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

ZSH_THEME="powerlevel10k/powerlevel10k"
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_DEFAULT_SESSION_NAME=cr4ftx

plugins=(zsh-autosuggestions zsh-syntax-highlighting tmux git sudo terraform vi-mode docker-compose docker yarn)

source $ZSH/oh-my-zsh.sh

autoload -Uz compinit && compinit -i

# Load aliases
[[ -f ~/.aliases ]] && \. ~/.aliases

# Load nvm
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"

autoload -U add-zsh-hook
load-nvmrc() {
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

# Load Rust toolchain
[[ -s $HOME/.cargo/env ]] && source $HOME/.cargo/env

# Add deno to PATH
export PATH=$PATH:$HOME/.deno/bin

# Load fzf
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

[[ ! -f ~/.zprofile ]] || source ~/.zprofile

export AWS_PAGER=""
