#!/bin/bash

mkdir -p ~/.local/share/nvim/backup

stow -D dot-config
stow -D tmux
stow -D zsh
stow -D stow-bin
stow -D vim

stow dot-config
stow tmux
stow zsh
stow stow-bin
stow vim
