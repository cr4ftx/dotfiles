#!/usr/bin/env bash

installOhMyZsh() {
    if [ ! -d $HOME/.oh-my-zsh ]; then
        echo exit | sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
    else
        echo "Oh My Zsh already installed in $HOME/.oh-my-zsh"
    fi
}

installTmuxPluginManager() {
    local tpm_home="$HOME/.tmux/plugins/tpm"

    if [[ ! -d $tpm_home ]]; then
        git clone https://github.com/tmux-plugins/tpm $tpm_home
    else
        echo "TPM already installed in $tpm_home"
    fi
}

installPlugVim() {
    if [[ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]]; then
        curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        echo "Plug Vim is already installed"
    fi
}

installRustup() {
    read -p "Install rustup [yN] ?"

    if [[ ! -d $HOME/.cargo && $REPLY =~ ^[yY]$ ]]; then
        curl https://sh.rustup.rs -sSf | sh
        . $HOME/.cargo/env
        rustup component add rustfmt
        rustup component add clippy
    else
        echo "Skipping rustup installation"
    fi
}

installNvm() {
    read -p "Install nvm [yN] ?"

    if [[ ! -d $HOME/.nvm && $REPLY =~ ^[yY]$ ]]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
    else
        echo "Skipping NVM installation"
    fi
}

installDeno() {
    read -p "Install deno [yN] ?"

    if [[ ! -d $HOME/.deno && $REPLY =~ ^[yY]$ ]]; then
        curl -fsSL https://deno.land/x/install/install.sh | sh
    else
        echo "Skipping Deno installation"
    fi
}

doInstall() {
    installOhMyZsh
    installTmuxPluginManager
    installPlugVim
    installRustup
    installNvm
    installDeno
}

doSync() {
    rsync --exclude ".git/" \
        --exclude "README.md" \
        --exclude "bootstrap.sh" \
        --exclude ".editorconfig" \
        -avh --no-perms . ~;

    nvim +PlugClean! +qa
    nvim +silent +PlugInstall +qa
}

usage() {
    echo "Usage: $(basename "$0") [flags]" >&2
    echo
    echo "   -i           Install extra software (oh-my-zsh, rustup, plug-vim, deno...)"
    echo "   -s           Synchronize dotfiles to home directory"
    echo "   -u           Update vim plugins"
    echo
    exit 1
}

if [ $# -eq 0 ]; then
    usage
else
    while getopts "isu" option; do
        case $option in
            i) doInstall;;
            s) doSync;;
            u) nvim +PlugUpdate +qa;;
            \?) usage;;
        esac
    done
fi
