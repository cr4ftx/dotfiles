# Dotfiles

![Dotfiles](./dotfiles.png "Screenshot of this dotfiles")

## Prerequisites

### Ubuntu

```bash
sudo add-apt-repository ppa:mmstick76/kitty
sudo apt update
sudo apt install curl git neovim zsh tmux kitty stow ripgrep
```

### Fedora

```bash
sudo dnf copr enable pschyska/kitty
sudo dnf install curl git neovim zsh tmux kitty stow ripgrep
```

### Arch based

```bash
sudo pacman -S curl git neovim zsh tmux kitty stow ripgrep
```

### MacOS

> Install brew https://docs.brew.sh/Installation

```bash
brew install neovim zsh tmux stow ripgrep kitty font-meslo-lg-nerd-font
```

## Installation

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/swanncastel/dotfiles/master/install.sh)"
```
