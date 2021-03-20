#!/usr/bin/env bash

##
# Install dotfiles into home directory
TARGET="$HOME"
LINKER="$(which ln)"

[ "$#" -gt 0 ] || { echo "Supply a dotfile."; exit 2; }
DOTFILE="$(echo "$1" | sed s/dot-/./ -)"
echo Linking "$1" as "$TARGET/$DOTFILE"...
"$LINKER" -rs "$1" "$TARGET/$DOTFILE"
