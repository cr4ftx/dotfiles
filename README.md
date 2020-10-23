# Dotfiles

![Dotfiles](./dotfiles.png 'Screenshot of this dotfiles')

> coc.vim is awesome ❤️

## Prerequisites

### Ubuntu

```bash
sudo add-apt-repository ppa:mmstick76/alacritty
sudo apt update
sudo apt install curl git neovim zsh tmux ack alacritty stow fd-find htop
```

### Fedora

```bash
sudo dnf copr enable pschyska/alacritty
sudo dnf install curl git neovim zsh tmux ack alacritty stow fd-find htop
```

### MacOS

> install brew https://docs.brew.sh/Installation

```bash
brew cask install alacritty
brew install neovim ack zsh tmux stow alacritty fd htop
```

## Installation

```bash
git clone https://github.com/swanncastel/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

- The first time you run tmux hit crtl+a shift+i to install tmux plugins.
- Run vim and CoC will install coc extentions.
