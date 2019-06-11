#!/usr/bin/env bash

function doSync() {
    rsync --exclude ".git/" \
        --exclude "README.md" \
        --exclude "bootstrap.sh" \
        --exclude ".editorconfig" \
        -avh --no-perms . ~;
}

function doInstall() {
	# oh-my-zsh
	if [ -z $ZSH ]; then
		echo exit | sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
		git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
	else
		echo "Skipping Oh My Zsh installation"
	fi

	# plug-vim
	if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
		curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
			https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	else
		echo "Skipping Plug Vim installation"
	fi
	nvim +PlugClean! +qall
	nvim +silent +PlugInstall +qall

	# rustup
	if [ ! -d $HOME/.cargo ]; then
		curl https://sh.rustup.rs -sSf | sh
		rustup component add rustfmt
		rustup component add clippy
	else
		echo "Skipping rustup installation"
	fi

	# nvm
	if [ -z $NVM_DIR ]; then
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
	else
		echo "Skipping NVM installation"
	fi

	# deno
	if [ ! -d $HOME/.deno ]; then
		curl -fsSL https://deno.land/x/install/install.sh | sh
	else
		echo "Skipping Deno installation"
	fi
}

doAll() {
    doInstall
    doSync
}

doHelp() {
    echo "Usage: $(basename "$0") [options]" >&2
    echo
	echo "   -i, --install          Install extra software (oh-my-zsh, rustup, nvm, deno...)"
    echo "   -s, --sync             Synchronizes dotfiles to home directory"
    echo "   -a, --all              Does all of the above"
    echo
    exit 1
}

if [ $# -eq 0 ]; then
    doHelp
else
    for i in "$@"
    do
        case $i in
            -i|--install)
                doInstall
                shift
                ;;
            -s|--sync)
                doSync
                shift
                ;;
            -a|--all)
                doAll
                shift
                ;;
            *)
                doHelp
                shift
                ;;
        esac
    done
fi
