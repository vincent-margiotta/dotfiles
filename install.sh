#!/usr/bin/env bash

##
# Non-sophisticated dotfile management.
#
# Transform any path prefixed with `dot-` to its hidden form,
# preserving its type.

##
# Install dotfiles into home directory
TARGET="$HOME"

# It's unlikely `ln` won't be installed, but check anyway.
LINKER="$(which ln)"

# This works on individual dotfiles.
[ "$#" -gt 0 ] || { echo "Supply a dotfile."; exit 2; }

# Convert the `dot-` prefix to its hidden form.
DOTFILE="$(echo "$1" | sed s/dot-/./ -)"

# Create symbolic links, overwriting any existing files.
echo Linking "$1" as "$TARGET/$DOTFILE"...
"$LINKER" -rs "$1" "$TARGET/$DOTFILE"
