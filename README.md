# Dotfiles

![Dotfiles](./dotfiles.png "Screenshot of this dotfiles")

> coc.vim is awesome ❤️

## Prerequisites

### Ubuntu

```bash
sudo add-apt-repository ppa:mmstick76/alacritty
sudo apt update
sudo apt install curl git neovim zsh tmux alacritty stow htop ripgrep
```

### Fedora

```bash
sudo dnf copr enable pschyska/alacritty
sudo dnf install curl git neovim zsh tmux alacritty stow htop ripgrep
```

### Arch based

```bash
sudo pacman -S curl git neovim zsh tmux alacritty stow htop ripgrep
```

### MacOS

> Install brew https://docs.brew.sh/Installation

```bash
brew install neovim zsh tmux stow alacritty htop ripgrep alacritty font-meslo-lg-nerd-font
```

## Installation

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/swanncastel/dotfiles/master/install.sh)"
```

## Config

### coc-java

> In order to get lombok working with eclipse.jdt.ls

```json
# coc-settings.json
{
    "java.jdt.ls.vmargs": "-javaagent:/path/to/lombok.jar"
}
```
