# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)

plugins=(git sudo npm)

source $ZSH/oh-my-zsh.sh

# Load aliases
[[ -f ~/.aliases ]] && \. ~/.aliases

# Load nvm
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"

# Add deno to PATH
export PATH=$PATH:$HOME/.deno/bin

# Load fzf
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
