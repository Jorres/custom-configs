#!/bin/bash

mkdir -p ~/.local/share/nvim/backup

stow ./nvim-config
stow ./tmux
stow ./zsh
