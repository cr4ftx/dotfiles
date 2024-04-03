# Dotfiles

![Dotfiles](./dotfiles.png "Screenshot of this dotfiles")

## Prerequisites

### Ubuntu

```bash
sudo add-apt-repository ppa:mmstick76/kitty
sudo apt update
sudo apt install kitty alacritty
sudo apt install curl git neovim zsh tmux stow ripgrep
```

### Fedora

```bash
sudo dnf copr enable pschyska/kitty
sudo kitty alacritty
sudo dnf install curl git neovim zsh tmux stow ripgrep
```

### Arch based

```bash
sudo pacman -S git-delta bat eza
sudo pacman -S kitty alacritty
sudo pacman -S curl git neovim zsh tmux stow ripgrep
```

### MacOS

> Install brew https://docs.brew.sh/Installation

```bash
brew install gawk grep gnu-sed coreutils # for fzf tab completion
brew install git-delta bat eza # better git highlighting, cat and ls
brew install kitty alacritty # better terminal emulator
brew install curl git neovim zsh tmux stow ripgrep
```

## Installation

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/cr4ftx/dotfiles/master/install.sh)"
# or custom destination dir
bash -c "DOTFILES_DIR=[PATH_FOLDER] $(curl -fsSL https://raw.githubusercontent.com/cr4ftx/dotfiles/master/install.sh)"
# for bat custom theme
bat cache --build
```
