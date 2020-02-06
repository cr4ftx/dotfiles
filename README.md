# Dotfiles

![Dotfiles](./dotfiles.png "Screenshot of this dotfiles")

> coc.vim is awesome ❤️

## Prerequisites

### Ubuntu / Debian

```bash
sudo apt install curl git neovim zsh tmux fonts-powerline ack-grep
```

[Color theme for GNOME terminal](https://github.com/arcticicestudio/nord-gnome-terminal#installation)

## Installation

```bash
git clone https://github.com/swanncastel/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./bootstrap.sh -is
```

To use fzf outside of Vim
`~/.fzf/install`

## TODO

-   update screenshot
-   test coc-yaml
-   test coc-lists to replace fzf
-   test coc-explorer (uses LSP and contains icons out of the box)
