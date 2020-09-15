# Dotfiles

![Dotfiles](./dotfiles.png 'Screenshot of this dotfiles')

> coc.vim is awesome ❤️

## Prerequisites

### Ubuntu

```bash
sudo add-apt-repository ppa:mmstick76/alacritty
sudo apt update
sudo apt install curl git neovim zsh tmux ack-grep alacritty stow fd-find
```

### MacOS

> install brew https://docs.brew.sh/Installation

```bash
brew cask install alacritty
brew install neovim ack zsh tmux stow alacritty fd
```

## Installation

```bash
git clone https://github.com/swanncastel/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && stow . -v && ./install.sh
chsh
```

The first time you run tmux hit <crtl+a I>
