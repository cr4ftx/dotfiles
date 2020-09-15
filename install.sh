#!/usr/bin/env bash

if [ ! -d $HOME/.oh-my-zsh ]; then
    echo exit | sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
else
    echo "Oh My Zsh already installed"
fi

TPM_HOME="$HOME/.tmux/plugins/tpm"
if [[ ! -d $TPM_HOME ]]; then
    git clone https://github.com/tmux-plugins/tpm $TPM_HOME
else
    echo "TPM already installed in $TPM_HOME"
fi

if [[ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ]]; then
    curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo "Plug Vim is already installed"
fi

if [[ ! -d $HOME/.cargo ]]; then
    read -p "Install rustup [yN] ? "
    if [[ $REPLY =~ ^[yY]$ ]]; then
        curl https://sh.rustup.rs -sSf | sh
        . $HOME/.cargo/env
        rustup component add rustfmt
        rustup component add clippy
    fi
else
    echo "Rustup is already installed"
fi

if [[ ! -d $HOME/.nvm ]]; then
    read -p "Install nvm [yN] ? "
        if [[ $REPLY =~ ^[yY]$ ]]; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
        source $HOME/.nvm/nvm.sh
        nvm install 12
    fi
else
    echo "NVM is already installed"
fi

if [[ ! -d $HOME/.deno ]]; then
    read -p "Install deno [yN] ? "
    if [[ $REPLY =~ ^[yY]$ ]]; then
        curl -fsSL https://deno.land/x/install/install.sh | sh
    fi
else
    echo "Deno is already installed"
fi

nvim +PlugInstall +qa
