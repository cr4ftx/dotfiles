# Dotfiles

![Dotfiles](./dotfiles.png 'Screenshot of this dotfiles')

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

### MacOS

> install brew

#### Install

```bash
brew cask install alacritty vscodium spotify
brew install neovim ack zsh tmux stow alacritty
```

#### Install nerd font

```bash
brew tap homebrew/cask-fonts
brew cask install font-meslo-lg-nerd-font
```
