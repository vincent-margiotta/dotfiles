#!/usr/bin/env bash

function __stow() {
  STOW=$(which stow)
  [ "$?" == 0 ] || { echo 'Please install GNU Stow'; exit 2; }

  VERBOSITY=1; TARGET="$HOME"
  "$STOW" --dotfiles --restow --verbose="$VERBOSITY" --target="$TARGET" "$@"
}

__stow aliases
__stow functions
__stow git
__stow oh-my-zsh
__stow tmux
__stow vim
__stow zsh
