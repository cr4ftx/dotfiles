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
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

	# plug-vim
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	nvim +PlugClean! +qall
	nvim +silent +PlugInstall +qall

	# rustup
	curl https://sh.rustup.rs -sSf | sh
	rustup component add rustfmt
	rustup component add clippy

	# nvm
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash

	# deno
	curl -fsSL https://deno.land/x/install/install.sh | sh
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
