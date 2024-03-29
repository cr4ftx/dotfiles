#!/usr/bin/env bash

set -euo pipefail

DEST_DIR=${DEST_DIR:-~/.dotfiles}

println() {
    printf '\n%s\n' "$1"
}

print_header() {
    println "$BOLD"
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

install_dotfiles() {
    if [ ! -d "$DEST_DIR" ]; then
        println "${GREEN}Cloning Dotfiles${RESET}"
        git clone --recurse-submodules https://github.com/swanncastel/dotfiles.git "$DEST_DIR"
    fi
}

link_dotfiles() {
    println "${BLUE}Linking config files${RESET}"
    mkdir -p \
        ~/.config \
        ~/.local/share/fonts \
        ~/.tmux/plugins
    stow --verbose 2 --dotfiles --dir "$DEST_DIR" --target "$HOME" config
}

install_powerlevel10k () {
    if [[ -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]]; then
        return 0
    fi

    println "${GREEN}Cloning Powerlevel10k${RESET}"
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
}

install_nvm() {
    if [[ -d ~/.nvm ]]; then
        println "${BLUE}NVM is already installed${RESET}"
        return 0
    fi

    read -rp "${BOLD}Install nvm and node 18 [yN]? ${RESET}"

    if [[ $REPLY =~ ^[yY]$ ]]; then
        println "${GREEN}Installing nvm and node 18${RESET}"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    fi
}

change_shell() {
    if [[ $SHELL == "/bin/zsh" ]]; then
        return 0
    fi
    println "${YELLOW}Changing default shell to zsh...${RESET}"
    chsh -s /bin/zsh
}

main() {
    # Only use colors if connected to a terminal
    if [ -t 1 ]; then
        RED=$(printf '\033[31m')
        GREEN=$(printf '\033[32m')
        YELLOW=$(printf '\033[33m')
        BLUE=$(printf '\033[34m')
        BOLD=$(printf '\033[1m')
        RESET=$(printf '\033[m')
    else
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        BOLD=""
        RESET=""
    fi

    print_header
    install_dotfiles
    link_dotfiles
    install_powerlevel10k
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    change_shell
    install_nvm

    println "${GREEN}Installation completed 🚀🔥${RED}❤️${RESET}"
    sleep 1

    exec /bin/zsh
}

main
