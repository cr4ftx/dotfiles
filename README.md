# Dotfiles

![Dotfiles](./dotfiles.png "Screenshot of this dotfiles")

> coc.vim is awesome ❤️

## Prerequisites

### Ubuntu

```bash
sudo add-apt-repository ppa:mmstick76/kitty
sudo apt update
sudo apt install curl git neovim zsh tmux kitty stow htop ripgrep
```

### Fedora

```bash
sudo dnf copr enable pschyska/kitty
sudo dnf install curl git neovim zsh tmux kitty stow htop ripgrep
```

### Arch based

```bash
sudo pacman -S curl git neovim zsh tmux kitty stow htop ripgrep
```

### MacOS

> Install brew https://docs.brew.sh/Installation

```bash
brew install neovim zsh tmux stow htop ripgrep kitty font-meslo-lg-nerd-font
```

## Installation

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/swanncastel/dotfiles/master/install.sh)"
```
