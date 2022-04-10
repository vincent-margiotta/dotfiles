#!/usr/bin/env sh

##
# Simple dotfile management.
#
# Apply two rules to files before creating the symlink:
# 1. Top-level directory names are ignored
# 2. All instances of `dot-` are converted to `.`
#
# For example, the dotfile `bash/dot-bashrc` becomes `~/.bashrc`.

TARGET="$HOME"  # Default to installing into $HOME unless an override is set.
[ -n "$DOTFILES" ] && TARGET="$DOTFILES"

# Handle error cases
[ "$#" -gt 0 ]            || { echo "You must supply a dotfile. ";   exit 2; }
[ -f "$1" ]               || { echo "Can only link regular files. "; exit 2; }
[ -d "$TARGET" ]          || { echo "TARGET is not a directory. ";   exit 1; }
LINKER="$(command -v ln)" || { echo "No supported linker found! ";   exit 1; }

# The Magic Sauce
DOTFILE="$(echo "$1" | cut -d '/' -f2- | sed 's/dot-/./g')"
FULLPATH="$TARGET/$DOTFILE"
PARENT="$(dirname "$FULLPATH")"

[ -d "$PARENT" ] || { mkdir -p "$PARENT"; echo "Created parent $PARENT"; }

# Echo and return exit code 0 only if the link succeeds.
"$LINKER" -fs "$PWD/$1" "$FULLPATH" && echo "Linked $1 to $FULLPATH" && exit 0
