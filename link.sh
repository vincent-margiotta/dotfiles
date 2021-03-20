#!/usr/bin/env bash

##
# Non-sophisticated dotfile management.
#
# Transform any path elements prefixed with `dot-` to their hidden form.
# The top-most directory is removed before linkage.
#
# For example, the path `foo/dot-foo/config/dot-foorc` becomes
# `.foo/config/.foorc` after linkage.

# Error cases
[ "$#" -gt 0 ] || { echo "Supply a dotfile. "; exit 2; }
[ -f "$1" ] || { echo "Can only link regular files. "; exit 2; }

TARGET="$HOME"  # Default to installing into $HOME unless an override is set.
[ -e "$DOTFILE_TARGET" ] && TARGET="$DOTFILE_TARGET"

LINKER="$(command -v ln)" # Brief sanity check that the `ln` binary exists.
[ "$?" -eq 0 ] || { echo "No supported linker found! "; exit 1; }

# The Magic Sauce.
DOTFILE="$(echo "$1" | cut -d '/' -f2- | sed 's/dot-/./g')"

FULLPATH="$TARGET/$DOTFILE"
PARENT="$(dirname $FULLPATH)"

[ -d "$PARENT" ] || { mkdir -p "$PARENT"; echo "Created parent $PARENT"; }

# Echo and return exit code 0 only if the link succeeds.
"$LINKER" -fs "$PWD/$1" "$FULLPATH" && echo "Linked $1 to $FULLPATH" && exit 0

