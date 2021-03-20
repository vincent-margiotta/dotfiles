# Non-sophisticated Dotfile Management

Manage my dotfiles in a sane, straight-forward fashion. Please feel free to
copy/fork this repository and any configuration files you find within it. There
are no secrets or sensitive data, but there are a number of functions I've
found useful.

## Usage

The linking mechanism is intentionally narrowly scoped. The following are true:

* Will **not** link directories
* Will **not** link more than one dotfile per invocation
* Will remove the top-most directory from source files
* Will create parent directories as necessary
* Will overwrite existing links
* Will convert all instances of the prefix `dot-` to `.`

Suppose your repository looks like the following:

```
.
├── README.md
├── bar
│   └── dot-bazrc
├── foo
│   └── dot-config
│       └── baz
└── link.sh

3 directories, 4 files
```

Then `link.sh` can be used as in the following:

```
$ ./link.sh foo/dot-config/baz
Linking foo/dot-config/baz as /Users/vince/.config/baz...

$ ./link.sh bar/dot-bazrc
Linking bar/dot-bazrc as /Users/vince/.bazrc...
```


## History

Besides being simpler, this solution solves a few problems I've had with
previous tools.

Beginning with [dotbot](https://github.com/anishathalye/dotbot) which is great
but quite a bit sophisticated.

Next I tried [GNU Stow](https://www.gnu.org/software/stow/), which is almost
perfect except that I disliked that the source dotfiles (ie, the configuration
files contained within this repository) had to named in their hidden form. Some
versions of GNU Stow support the `--dotfile` flag, which transform the source
files named like `dot-` to its "hidden" form. Unfortunately, it appeared that
this transformation only applied to the basename, which means if there are any
other parts of the filepath that should be hidden, then they need to be named
as such in the source repository (ie, this repository). For example
`.config/dot-foo`.  This meant that these files and directories would be hidden
while browsing my repository. Minor, but annoying.

The more crippling issue with GNU Stow is actually that only __some__ versions
of the command support the `--dotfile` flag. This meant that to support
multiple systems, I'd need to implement that feature myself. While I was at it,
I may as well switch to using the `link` command directly, since GNU Stow was
not actually designed for dotfile management after all. Thus, this repository
(in its current form) was born.
