# Dotfiles

![Dotfiles](./dotfiles.png "Screenshot of this dotfiles")

> coc.vim is awesome ❤️

## Prerequisites

```bash
sudo apt install curl git neovim zsh tmux ack-grep alacritty stow
```

[nerd font](https://github.com/ryanoasis/nerd-fonts#font-installation)

## Installation

```bash
git clone https://github.com/swanncastel/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh && stow . -v
```

To use fzf outside of Vim
`~/.fzf/install`
