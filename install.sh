#!/usr/bin/env bash

setup_colors() {
    # Only use colors if connected to a terminal
    if [ -t 1 ]; then
        RED=$(println '\033[31m')
        GREEN=$(println '\033[32m')
        YELLOW=$(println '\033[33m')
        BLUE=$(println '\033[34m')
        BOLD=$(println '\033[1m')
        RESET=$(println '\033[m')
    else
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        BOLD=""
        RESET=""
    fi
}

println() {
    printf "$@\n"
}

print_header() {
    printf $BOLD
    cat <<-'EOF'

    ____                           _           _       _    __ _ _
   / ___|_      ____ _ _ __  _ __ ( )___    __| | ___ | |_ / _(_) | ___  ___
   \___ \ \ /\ / / _` | '_ \| '_ \|// __|  / _` |/ _ \| __| |_| | |/ _ \/ __|
    ___) \ V  V / (_| | | | | | | | \__ \ | (_| | (_) | |_|  _| | |  __/\__ \
   |____/ \_/\_/ \__,_|_| |_|_| |_| |___/  \__,_|\___/ \__|_| |_|_|\___||___/

EOF
    printf $RESET
}

install_oh_my_zsh() {
    if [ ! -d ~/.oh-my-zsh ]; then
        println "${GREEN}\nCloning Oh My Zsh${RESET}"
        git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
        println "${GREEN}\nCloning Powerlevel10k${RESET}"
        git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
    else
        println "${BLUE}\nOh My Zsh already installed${RESET}"
    fi
}

install_tmux_plugin_manager() {
    TPM_HOME="$HOME/.tmux/plugins/tpm"
    if [[ ! -d $TPM_HOME ]]; then
        println "${GREEN}\nCloning tmux plugins manager${RESET}"
        git clone https://github.com/tmux-plugins/tpm $TPM_HOME
    else
	    println "${BLUE}\nTPM already installed in $TPM_HOME${RESET}"
    fi

}

install_plug_vim() {
    if [[ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]]; then
        println "${GREEN}\nInstalling Plug Vim${RESET}"
        curl -fLo "${XDG_DATA_HOME:-~/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
	    println "${BLUE}\nPlug Vim is already installed${RESET}"
    fi
}

install_rust_toolchain() {
    if [[ ! -d ~/.cargo ]]; then
        echo ""
        read -p "Install rustup [yN] ? "
        if [[ $REPLY =~ ^[yY]$ ]]; then
            println "${GREEN}Installing rust toolchain${RESET}"
            curl https://sh.rustup.rs -sSf | sh
            source ~/.cargo/env
            rustup component add rustfmt
            rustup component add clippy
        fi
    else
	    println "${BLUE}\nRustup is already installed${RESET}"
    fi
}

install_nvm() {
    if [[ ! -d ~/.nvm ]]; then
	echo ""
	read -p "${BOLD}Install nvm [yN] ? ${RESET}"
	    if [[ $REPLY =~ ^[yY]$ ]]; then
            println "${GREEN}Installing nvm and node12${RESET}"
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
            source ~/.nvm/nvm.sh
            nvm install 12
        fi
    else
	    println "${BLUE}\nNVM is already installed${RESET}"
    fi
}

install_deno() {
    if [[ ! -d ~/.deno ]]; then
        echo ""
        read -p "Install deno [yN]? "
        if [[ $REPLY =~ ^[yY]$ ]]; then
            println "${GREEN}Installing deno${RESET}"
            curl -fsSL https://deno.land/x/install/install.sh | sh
        fi
    else
	    println "${BLUE}\nDeno is already installed${RESET}"
    fi
}

main() {
    setup_colors
    print_header
    install_oh_my_zsh
    install_tmux_plugin_manager
    install_plug_vim
    install_rust_toolchain
    install_nvm
    install_deno

    println "${BLUE}\nLinking config files${RESET}"
    mkdir -p "$HOME/.config/nvim"
    mkdir -p "$HOME/.local/share/fonts"
    stow . -v

    if [[ $SHELL != "/bin/zsh" ]]; then
        println "${YELLOW}\nChanging default shell to zsh...${RESET}"
        chsh -s /bin/zsh
    fi

    if [[ ! -d ~/.config/nvim/plugged ]]; then
        nvim +PlugInstall +qa
    fi

    println "${GREEN}\nInstallation completed 🚀🔥❤️${RESET}"
}

main
