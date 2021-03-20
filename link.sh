#!/usr/bin/env bash

##
# Non-sophisticated dotfile management.
#
# Transform any path elements prefixed with `dot-` to its hidden form
# preserving its file type. The top-most directory used by this repository is
# removed before linkage.
#
# For example, the path `foo/dot-foo/config/dot-barrc` becomes
# `.foo/config/.barrc` after linkage.

# Install dotfiles into home directory.
# TODO: Make this configurable.
TARGET="$HOME"

# It's unlikely `ln` won't be installed, but check anyway.
LINKER="$(command -v ln)"
[ "$?" -eq 0 ] || { echo "No supported linker found! "; exit 1; }

# This works on individual dotfiles.
[ "$#" -gt 0 ] || { echo "Supply a dotfile. "; exit 2; }

# Abort if the dotfile is just a directory.
[ -d "$1" ] && { echo "Cannot link directories. "; exit 2; }

# Convert the `dot-` prefix to its hidden form & remove the top-most directory.
# Also the linked dotfile must refer to an absolute path or else the link will
# not function.
DOTFILE="$(echo "$1" | sed 's/dot-/./g' | cut -d '/' -f2-)"

# Create the parent directory, if it does not exist.
PARENT="$(dirname $TARGET/$DOTFILE)"
[ -d "$PARENT" ] || { echo "Creating parent directory. "; mkdir -p "$PARENT"; }

# Create symbolic links, overwriting any existing files.
#
# There are annoying differences between GNU and BSD ln, so we need to switch
# on which is installed.
echo Linking "$1" as "$TARGET/$DOTFILE"...
if [ "$(uname -s)" == "Darwin" ]; then
  "$LINKER" -fs "$PWD/$1" "$TARGET/$DOTFILE"
else
  "$LINKER" -rs "$PWD/$1" "$TARGET/$DOTFILE"
fi

