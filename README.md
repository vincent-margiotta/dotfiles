# Simple Dotfile Management

Manages my dotfiles in a flexible, straight-forward fashion. The repository
consists of my dotfiles and a linker script.

Feel free to copy/fork this repository and any configuration files you find
within it. There are no secrets or sensitive data contained within.

## Linker Features

* Creates parent directories as required
* Links relative to the `$DOTFILES` environment variable (default: `$HOME`)
* Overwrites existing links

## Linker Limitations

* Links only regular files
* Links one file per invocation

## Linker Usage

To invoke the linker pass it a repository dotfile on the command line:

```shell
$ ./link.sh [PATH TO DOTFILE IN REPOSITORY]
```

The linker creates a symlink to the repository dotfile and will automatically
create any parent directories as necessary. Where the dotfile is linked to is
based on the repository dotfile's name. Two rules are applied by the linker:

1. Top-level direcory names are ignored
2. All instances of `dot-` are converted to `.`

For example, if you have some dotfiles in your repository like

```
.
├── README.md
├── bash
│   └── dot-bashrc
└── link.sh

1 directory, 3 files
```

To link your Bash configuration dotfile, run the following:

```shell
$ ./link.sh bash/dot-bashrc
Linking bash/dot-bashrc as /Users/vince/.bashrc
```

## Frequently Asked Questions

**Why not use [dotbot|GNU stow|any other dotfile manager]?**

I've used several dotfiles managers in the past with varying success.
Generally, I found them overly complex for my uses.

**Can you add support for linking multiple files per invocation?**

Yes, but I won't. Currently, the linker script does one thing well and I'd like
to keep it that way.

What I've discovered over the years is that the time spent linking my dotfiles
is never the bottleneck, but rather the time spent thinking about and
experiment with how I want to configure my system was more important to me.

## Other Dotfile Managers

[dotbot](https://github.com/anishathalye/dotbot) - A great tool with many
features. I used it for years before deciding to switch to something with no
external dependencies.

[GNU Stow](https://www.gnu.org/software/stow/) - Another great tool. However,
it wasn't made to manage dotfiles. Because of the different versions of GNU
Stow out there, I couldn't always manage my dotfiles consistently on every
system I'd encounter. This is what lead me to create the simple POSIX shell
script to manage my dotfiles in this repository.
