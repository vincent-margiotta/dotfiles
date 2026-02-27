# Simple Dotfile Management

This repo manages dotfiles with a single POSIX `sh` script. The idea is
intentionally small: dotfiles live in the repo, and a linker script creates
symlinks into your home directory (or another target) based on a naming
convention.

There are no secrets or sensitive data in this repo. Feel free to copy or fork.

## Linker Features

* Creates parent directories as needed
* Links relative to `$DOTFILES_HOME` (default: `$HOME`)
* Overwrites existing symlinks by default
* Refuses to overwrite non-symlinks unless `--force` is provided
* Prints the exact `ln -fs ...` action before executing
* Supports `--dry-run` to preview actions

## Linker Limitations

* Links only regular files
* Links one file per invocation

## Usage

To link a single dotfile, pass its repo path to `link.sh`:

```shell
$ ./link.sh [PATH TO DOTFILE IN REPOSITORY]
```

The linker applies two rules to compute the target path:

1. The top-level directory name is ignored
2. Every occurrence of `dot-` is converted to `.`

Example repo structure:

```
.
├── README.md
├── bash
│   └── dot-bashrc
└── link.sh

1 directory, 3 files
```

Example link:

```shell
$ ./link.sh bash/dot-bashrc
ln -fs "/path/to/repo/bash/dot-bashrc" "/Users/user/.bashrc"
Linked bash/dot-bashrc to /Users/user/.bashrc
```

### Flags

Dry run:

```shell
$ ./link.sh --dry-run bash/dot-bashrc
ln -fs "/path/to/repo/bash/dot-bashrc" "/Users/user/.bashrc"
```

Force overwrite of a non-symlink:

```shell
$ ./link.sh --force bash/dot-bashrc
```

## FAQ

**Why not use dotbot, GNU Stow, or another dotfile manager?**

I've used several dotfile managers in the past. They were more complex than I
needed, so I replaced them with a small script that does exactly one thing.

**Can you add support for linking multiple files per invocation?**

Yes, but I won't. The script is intentionally focused on one file at a time.
The bottleneck is deciding on configuration, not the linking itself. And
anyway the script could be wrapped easily.

## Other Dotfile Managers

[dotbot](https://github.com/anishathalye/dotbot) - A great tool with many
features. I used it for years before deciding to switch.

[GNU Stow](https://www.gnu.org/software/stow/) - Another great tool. However,
it wasn't made to manage dotfiles. Because of the different versions of GNU
Stow out there, I couldn't always manage my dotfiles consistently on every
system I'd encountered. This is what led me to create the simple POSIX shell
script to manage my dotfiles in this repository.
