#local !/usr/bin/env bash

##
# Non-sophisticated dotfile management.
#
# Transform any path elements prefixed with `dot-` to its hidden form
# preserving its file type. The top-most directory used by this repository is
# removed before linkage.
#
# For example, the path `foo/dot-foo/config/dot-foorc` becomes
# `.foo/config/.foorc` after linkage.

if [ -z "$DOTFILE_TARGET" ]; then
  # Default to installing into $HOME if an override is unset.
  TARGET="$HOME"
else
  TARGET="$DOTFILE_TARGET"
fi

# Brief sanity check that the `ln` binary exists.
LINKER="$(command -v ln)"
[ "$?" -eq 0 ] || { echo "No supported linker found! "; exit 1; }

[ "$#" -gt 0 ] || { echo "Supply a dotfile. "; exit 2; }     # This works on individual dotfiles.
[ -d "$1" ] && { echo "Cannot link directories. "; exit 2; } # Abort if the dotfile is just a directory.

# The Magic Sauce.
DOTFILE="$(echo "$1" | cut -d '/' -f2- | sed 's/dot-/./g')"

PARENT="$(dirname $TARGET/$DOTFILE)"
# Create the parent directory, if it does not exist.
[ -d "$PARENT" ] || { mkdir -p "$PARENT"; echo "Created parent $PARENT"; }

# Create symbolic links, overwriting any existing files.
FULLPATH="$TARGET/$DOTFILE"
"$LINKER" -fs "$PWD/$1" "$FULLPATH" && echo "Linked $1 to $FULLPATH" && exit 0

