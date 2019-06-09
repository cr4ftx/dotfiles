#!/usr/bin/env bash

apt update
apt upgrade -y

apt install zsh
chsh -s /bin/zsh

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

apt install vim
apt install neovim
nvim +PlugClean! +qall
nvim +silent +PlugInstall +qall

apt autoremove -y
