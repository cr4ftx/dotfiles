# Dotfiles

> Greatly inspired by [Lucas F. Costa](https://github.com/lucasfcosta/dotfiles)

![Dotfiles](./dotfiles.png "Screenshot of this dotfiles")

## Prerequisites

### Ubuntu / Debian

```bash
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install curl git neovim zsh tmux fonts-powerline
```

[Color theme for GNOME terminal](https://github.com/arcticicestudio/nord-gnome-terminal#installation)

## Installation

```bash
git clone https://github.com/swanncastel/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./bootstrap.sh -is
```

[Follow ycm instructions](https://github.com/ycm-core/YouCompleteMe#linux-64-bit)

To use fzf outside of Vim
`~/.fzf/install`

## Key bindings

#### Git

* [See oh-my-zsh git plugin](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/git/#aliases)
* gdf = git difftool

#### Tmux

* Prefix has been changed for Ctrl+a
* [See tmux-pain-control](https://github.com/tmux-plugins/tmux-pain-control#bindings)
* [See tmux-sensible](https://github.com/tmux-plugins/tmux-sensible#key-bindings)

#### Vim

* <Ctrl+s> NERDTreeToggle
* <Ctrl+p> Fuzzy find
* <Ctrl+n> Start mulicursor

## TODO

* Key bindings for ycm GoTo, Refacto, FixIt...
