#!/usr/bin/env bash

set -euo pipefail

# Only use colors if connected to a terminal
if [ -t 1 ]; then
    RED=$(printf '\e[31m')
    GREEN=$(printf '\e[32m')
    YELLOW=$(printf '\e[33m')
    BLUE=$(printf '\e[34m')
    RESET=$(printf '\e[m')
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    RESET=""
fi

DOTFILES_DIR=${DOTFILES_DIR:-~/.dotfiles}

println() {
    printf '%s\n' "$1"
}

success() {
    println "$GREEN$1$RESET"
}

info() {
    println "$BLUE$1$RESET"
}

warning() {
    println "$YELLOW$1$RESET"
}

print_header() {
    println "$GREEN"
    cat <<-'EOF'


 ▄████▄   ██▀███   ▄▄▄        █████▒▄▄▄█████▓▒██   ██▒   ▓█████▄  ▒█████  ▄▄▄█████▓  █████▒██▓ ██▓    ▓█████   ██████
▒██▀ ▀█  ▓██ ▒ ██▒▒████▄    ▓██   ▒ ▓  ██▒ ▓▒▒▒ █ █ ▒░   ▒██▀ ██▌▒██▒  ██▒▓  ██▒ ▓▒▓██   ▒▓██▒▓██▒    ▓█   ▀ ▒██    ▒
▒▓█    ▄ ▓██ ░▄█ ▒▒██  ▀█▄  ▒████ ░ ▒ ▓██░ ▒░░░  █   ░   ░██   █▌▒██░  ██▒▒ ▓██░ ▒░▒████ ░▒██▒▒██░    ▒███   ░ ▓██▄
▒▓▓▄ ▄██▒▒██▀▀█▄  ░██▄▄▄▄██ ░▓█▒  ░ ░ ▓██▓ ░  ░ █ █ ▒    ░▓█▄   ▌▒██   ██░░ ▓██▓ ░ ░▓█▒  ░░██░▒██░    ▒▓█  ▄   ▒   ██▒
▒ ▓███▀ ░░██▓ ▒██▒ ▓█   ▓██▒░▒█░      ▒██▒ ░ ▒██▒ ▒██▒   ░▒████▓ ░ ████▓▒░  ▒██▒ ░ ░▒█░   ░██░░██████▒░▒████▒▒██████▒▒
░ ░▒ ▒  ░░ ▒▓ ░▒▓░ ▒▒   ▓▒█░ ▒ ░      ▒ ░░   ▒▒ ░ ░▓ ░    ▒▒▓  ▒ ░ ▒░▒░▒░   ▒ ░░    ▒ ░   ░▓  ░ ▒░▓  ░░░ ▒░ ░▒ ▒▓▒ ▒ ░
  ░  ▒     ░▒ ░ ▒░  ▒   ▒▒ ░ ░          ░    ░░   ░▒ ░    ░ ▒  ▒   ░ ▒ ▒░     ░     ░      ▒ ░░ ░ ▒  ░ ░ ░  ░░ ░▒  ░ ░
░          ░░   ░   ░   ▒    ░ ░      ░       ░    ░      ░ ░  ░ ░ ░ ░ ▒    ░       ░ ░    ▒ ░  ░ ░      ░   ░  ░  ░
░ ░         ░           ░  ░                  ░    ░        ░        ░ ░                   ░      ░  ░   ░  ░      ░
░                                                         ░
EOF
    println "$RESET"
}

update_tag () {
    local LATEST_TAG=${LATEST_TAG:-false}
    if [[ "$LATEST_TAG" == "true" ]]; then
        pushd "$1" >& /dev/null
        git fetch --tags origin
        local commit=$(git rev-list --tags --max-count=1)
        git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $commit)
        popd >& /dev/null
    fi

}

install_plugin () {
    if [ -d "$2" ]; then
        info "$1 already installed"
        update_tag $2
        return 0
    fi

    info "Cloning $1"
    git clone --depth 1 "$3" "$2"
    success "$1 installed"
    update_tag $2

    return 0
}

link_dotfiles() {
    info "Linking config files"
    mkdir -p \
        ~/.config \
        ~/.local/share/fonts \
        ~/.tmux/plugins
    stow --verbose 2 --dotfiles --dir "$DOTFILES_DIR" --target "$HOME" config
    success "Config linked"
}

change_shell() {
    if [[ $SHELL == "/bin/zsh" ]]; then
        return 0
    fi
    warning "Changing default shell to /bin/zsh"
    chsh -s /bin/zsh
    success $SHELL
}

main() {
    print_header

    install_plugin "Dotfiles" $DOTFILES_DIR https://github.com/cr4ftx/dotfiles.git
    install_plugin "Oh My Zsh" ~/.oh-my-zsh https://github.com/ohmyzsh/ohmyzsh
    install_plugin "ZSH autosuggestions" ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
    install_plugin "ZSH syntax highlighting" ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
    install_plugin "FZF tab completion" ~/.fzf-tab-completion https://github.com/lincheney/fzf-tab-completion
    install_plugin "Powerlevel10k" ~/.oh-my-zsh/custom/themes/powerlevel10k https://github.com/romkatv/powerlevel10k.git
    install_plugin "FZF" ~/.fzf https://github.com/junegunn/fzf.git
    LATEST_TAG=true install_plugin "TPM" ~/.tmux/plugins/tpm https://github.com/tmux-plugins/tpm
    LATEST_TAG=true install_plugin "NVM" ~/.nvm https://github.com/nvm-sh/nvm.git
    ~/.fzf/install

    link_dotfiles
    change_shell

    success "Installation completed 🚀🔥${RED}❤️ "
    sleep 1
    exec /bin/zsh
}

main
