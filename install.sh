#!/bin/bash

mkdir -p ~/.local/share/nvim/backup

stow -D dot-config
stow -D tmux
stow -D ansible
stow -D zsh
stow -D stow-bin
stow -D tldr

stow dot-config
stow tmux
stow ansible
stow zsh
stow stow-bin
stow tldr
