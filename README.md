# Dotfiles

![Dotfiles](./dotfiles.png "Screenshot of this dotfiles")

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

> Install brew https://docs.brew.sh/Installation

```bash
brew cask install alacritty
brew install neovim ack zsh tmux stow alacritty fd htop
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
