#!/usr/bin/env bash

function __stow() {
    $(which stow) --verbose=1 \
	    	  --target="$HOME" \
		  --dotfiles \
		  --restow "$1"
}

__stow alacritty
__stow aliases
__stow chunkwm
__stow functions
__stow git
__stow oh-my-zsh
__stow skhd
__stow tmux
__stow vim
__stow zsh
