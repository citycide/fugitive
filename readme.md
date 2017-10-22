# fugitive &middot; ![nimble](https://img.shields.io/badge/available%20on-nimble-yellow.svg?style=flat-square) ![license](https://img.shields.io/github/license/citycide/fugitive.svg?style=flat-square)

> Simple command line tool to make git more intuitive, along with useful GitHub addons.

fugitive provides new or alternative commands to use with git, and also
adds a few helpful tools for GitHub repositories.

It's similar to [`git-extras`][gitextras] but is designed to be more
portable. `git-extras` is written entirely as a set of shell scripts,
which means platform support outside Unix is at best hit or miss.

On the other hand, fugitive is written in [Nim][nim] to allow for better
portability. Other benefits are that Nim is super fast, flexible, and more
readable than the often cryptic bash syntax.

[Git Town][gittown] is a project with similar goals written in Go.

## installation

Linux x64 and Windows x64 prebuilt binaries are available from
[releases](https://github.com/citycide/fugitive/releases). Download the release
for your system and extract the binary within to somewhere in your `$PATH`.

> macOS builds aren't ready yet but are a future goal

If you have [Nim][nim] and [Nimble][nimble] installed
( and `~/.nimble/bin` is in your path ), you can also simply run:

```shell
nimble install fugitive
```

This will make `fugitive` available to you anywhere.

## usage

```shell
Usage: fugitive [command] [...args] (...options)

Commands:
  age       <username>           Display the age of the profile for <username>
  alias     [name [--remove|-r]] [expansion]
                                 List, add, or remove git aliases
  clone     <...repos>           Alias for `fugitive mirror`
  install   [--override|-o] [--force|-y]
                                 Alias various fugitive commands as git subcommands
  lock      <...files>           Prevent changes to the specified files from being tracked
  mirror    <...repos>           Wrapper around `git clone` with various URL shorthands
  open      [repo]               Open the current or specified repository's homepage
  repos     <username>           Display the number of public repos for <username>
  summary                        Summarize git repository statistics
  undo      [#] [--hard|-h]      Undo the last commit ( or last # commits )
  uninstall                      Remove git aliases added by `install`
  unlock    <...files>           Resume tracking changes to these locked files
  unstage   <...files>           Remove files from the git stage area

Options:
  --help, -h       Show this help message
  --version, -v    Output the fugitive version number
```

Some commands require that a GitHub username be configured, to allow
for useful shorthands like `fugitive open trilogy` - which, if you're
**[@citycide](https://github.com/citycide)**, will open [trilogy](https://github.com/citycide/trilogy).
These commands ( currently including `open` & `mirror` ), will prompt
for a username if one hasn't yet been configured.

## alias installation

After installation, you can make some of fugitive's commands more
accessible by running `fugitive install`, which will attach them
to git as subcommands, making `git undo == fugitive undo`.

Commands installed to git include:

```
alias
lock
mirror
open
summary
undo
unlock
unstage
```

Existing aliases are safe as fugitive will not override them unless
the `--override` ( or `-o` ) flag is explicitly passed.

If you want to remove these installed aliases, use `fugitive uninstall`.
Only aliases that fugitive installed and match the fugitive command will
be removed.

> Note the `mirror` command - git commands can't be overridden, so while
`fugitive clone` is possible it can't be aliased as a git subcommand.
Therefore `fugitive mirror` is the main command and the one that will
be attached to git, while `clone` is just an alias for convenience.

## building

To build fugitive from source you'll need to have [Nim][nim] installed,
and should also have [Nimble][nimble], Nim's package manager.

> currently, building should work on most platforms. cross-compilation
  (building for other platforms than the current one) is only tested on
  a unix system

1. Clone the repo: `git clone https://github.com/citycide/fugitive.git`
2. Move into the newly cloned directory: `cd fugitive`
3. Install dependencies: `nimble install`
4. Compile for your platform: `nimble build`
5. Compile for other platforms: run `nimble tasks` for available commands
6. Compile all release versions: `nimble release`
   - this will generate and package prebuilt binaries for all supported
     cross-compile targets

## contributing

You can check the [issues](https://github.com/citycide/fugitive/issues) for
anything unresolved, search for a problem you're encountering, or open a new
one. Pull requests for improvements are also welcome.

## license

MIT © [Bo Lingen / citycide](https://github.com/citycide)

[gitextras]: https://github.com/tj/git-extras
[nim]: https://nim-lang.org
[nimble]: https://github.com/nim-lang/nimble
[gittown]: https://github.com/Originate/git-town