#!/usr/bin/env bash

println() {
    printf "$@\n"
}

print_header() {
    echo $BOLD
    cat <<-'EOF'

    ____                           _           _       _    __ _ _
   / ___|_      ____ _ _ __  _ __ ( )___    __| | ___ | |_ / _(_) | ___  ___
   \___ \ \ /\ / / _` | '_ \| '_ \|// __|  / _` |/ _ \| __| |_| | |/ _ \/ __|
    ___) \ V  V / (_| | | | | | | | \__ \ | (_| | (_) | |_|  _| | |  __/\__ \
   |____/ \_/\_/ \__,_|_| |_|_| |_| |___/  \__,_|\___/ \__|_| |_|_|\___||___/

EOF
    echo $RESET
}

install_dotfiles() {
    if [ ! -d ~/.dotfiles ]; then
        println "${GREEN}\nCloning Dotfiles${RESET}"
        git clone https://github.com/swanncastel/dotfiles.git ~/.dotfiles || exit 1
        cd ~/.dotfiles git submodule update --init
    fi
}

link_dotfiles() {
    println "${BLUE}\nLinking config files${RESET}"
    mkdir -p ~/.config/nvim ~/.local/share/fonts/NerdFonts
    cd ~/.dotfiles && stow . -vv
}

install_oh_my_zsh() {
    if [ -d ~/.oh-my-zsh ]; then
        println "${BLUE}\nOh My Zsh already installed${RESET}"
        return 0
    fi

    println "${GREEN}\nCloning Oh My Zsh${RESET}"
    git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
    println "${GREEN}\nCloning Powerlevel10k${RESET}"
    git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
}

install_plug_vim() {
    local PLUG_FILE="$HOME/.local/share/nvim/site/autoload/plug.vim"
    if [[ -f $PLUG_FILE ]]; then
	    println "${BLUE}\nPlug Vim is already installed${RESET}"
        return 0
    fi

    println "${GREEN}\nInstalling Plug Vim${RESET}"
    curl -fLo $PLUG_FILE --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
        && nvim +PlugInstall +qa
}

install_rust_toolchain() {
    if [[ -d ~/.cargo ]]; then
	    println "${BLUE}\nRustup is already installed${RESET}"
        return 0
    fi

    echo ""; read -p "Install rustup [yN] ? "
    if [[ $REPLY =~ ^[yY]$ ]]; then
        println "${GREEN}Installing rust toolchain${RESET}"
        curl https://sh.rustup.rs -sSf | sh
        source ~/.cargo/env
        rustup component add rustfmt
        rustup component add clippy
    fi
}

install_nvm() {
    if [[ -d ~/.nvm ]]; then
	    println "${BLUE}\nNVM is already installed${RESET}"
        return 0
    fi

    echo ""; read -p "${BOLD}Install nvm and node12 [yN]? ${RESET}"
    if [[ $REPLY =~ ^[yY]$ ]]; then
        println "${GREEN}Installing nvm and node12${RESET}"
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
        source ~/.nvm/nvm.sh
        nvm install 14
    fi
}

install_deno() {
    if [[ -d ~/.deno ]]; then
	    println "${BLUE}\nDeno is already installed${RESET}"
        return 0
    fi

    echo ""; read -p "Install deno [yN]? "
    if [[ $REPLY =~ ^[yY]$ ]]; then
        println "${GREEN}Installing deno${RESET}"
        curl -fsSL https://deno.land/x/install/install.sh | sh
    fi
}

change_shell() {
    if [[ $SHELL != "/bin/zsh" ]]; then
        println "${YELLOW}\nChanging default shell to zsh...${RESET}"
        chsh -s /bin/zsh
    fi
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
    install_oh_my_zsh
    install_plug_vim
    change_shell
    install_rust_toolchain
    install_nvm
    install_deno

    println "${GREEN}\nInstallation completed, you might need to log out for the chsh to take effect 🚀🔥${RED}❤️${RESET}"
}

main
