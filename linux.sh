#!/usr/bin/env bash

apt update
apt upgrade -y

apt install zsh
chsh -s /bin/zsh

apt install vim
apt install neovim
nvim +PlugClean! +qall
nvim +silent +PlugInstall +qall

apt autoremove -y
