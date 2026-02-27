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
[ -n "$DOTFILES_HOME" ] && TARGET="$DOTFILES_HOME"

DRY_RUN=0
FORCE=0

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run) DRY_RUN=1; shift ;;
    --force) FORCE=1; shift ;;
    --help|-h)
      printf '%s\n' "Usage: $0 [--dry-run] [--force] PATH/TO/DOTFILE"
      exit 0
      ;;
    --) shift; break ;;
    -*) printf '%s\n' "Unknown option: $1"; exit 2 ;;
    *) break ;;
  esac
done

# Handle error cases
[ "$#" -gt 0 ]            || { printf '%s\n' "You must supply a dotfile.";   exit 2; }
[ -f "$1" ]               || { printf '%s\n' "Can only link regular files."; exit 2; }

case "$TARGET" in
  "~") TARGET="$HOME" ;;
  "~/"*) TARGET="$HOME/${TARGET#~/}" ;;
esac
[ -d "$TARGET" ] || { printf '%s\n' "TARGET is not a directory."; exit 1; }
TARGET="$(cd "$TARGET" && pwd)"

LINKER="$(command -v ln)" || { printf '%s\n' "No supported linker found!"; exit 1; }

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

# The Magic Sauce
case "$1" in
  */*) RELPATH="${1#*/}" ;;
  *) RELPATH="$1" ;;
esac
DOTFILE="$(printf '%s' "$RELPATH" | sed 's/dot-/./g')"
FULLPATH="$TARGET/$DOTFILE"
PARENT="$(dirname "$FULLPATH")"

[ -d "$PARENT" ] || { mkdir -p "$PARENT"; printf '%s\n' "Created parent $PARENT"; }

if [ -e "$FULLPATH" ] && [ ! -L "$FULLPATH" ] && [ "$FORCE" -ne 1 ]; then
  printf '%s\n' "Refusing to overwrite non-symlink: $FULLPATH"
  printf '%s\n' "Use --force to replace it with a symlink."
  exit 1
fi

# Echo and return exit code 0 only if the link succeeds.
CMD="$LINKER -fs \"$SCRIPT_DIR/$1\" \"$FULLPATH\""
printf '%s\n' "$CMD"

[ "$DRY_RUN" -eq 1 ] && exit 0

"$LINKER" -fs "$SCRIPT_DIR/$1" "$FULLPATH" && printf '%s\n' "Linked $1 to $FULLPATH" && exit 0
