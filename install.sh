#!/bin/bash

mkdir -p ~/.local/share/nvim/backup

stow -D dot-config
stow -D tmux
stow -D zsh

stow --verbose=5 dot-config
stow tmux
stow zsh
