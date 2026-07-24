# dotfiles

Personal dotfiles and macOS bootstrap scripts for setting up a development environment.

This repository is organized around a Zsh-based shell setup, Homebrew-managed applications, macOS defaults, editor settings, and small utility scripts.

## Overview

```text
.
├── home/          # Dotfiles linked directly into $HOME
├── zsh/           # Zsh configuration loaded via ZDOTDIR
│   ├── aliases/   # Command aliases and shell functions
│   └── settings/  # Prompt, completion, fzf, and extension settings
├── setup/         # macOS/bootstrap scripts and Brewfile
├── vim/           # Vim configuration and vim-plug setup
├── vscode/        # VS Code settings
├── script/        # Automator workflows, xbar plugins, and helper scripts
└── img/           # Images used by documentation
```

## Requirements

- macOS
- Git
- Xcode Command Line Tools
- Homebrew
- Zsh

The setup scripts assume this repository is cloned to:

```zsh
~/Desktop/github/dotfiles
```

If you clone it somewhere else, update hard-coded paths before running the scripts, especially in `zsh/.zshenv` and `setup/4_lns.sh`.

## Installation

Clone the repository:

```zsh
git clone https://github.com/kkensuke/dotfiles.git ~/Desktop/github/dotfiles
cd ~/Desktop/github/dotfiles
```

Install Xcode Command Line Tools:

```zsh
sh setup/1_xcode.sh
```

Install Homebrew:

```zsh
sh setup/2_homebrew.sh
```

Install packages and applications from the Brewfile:

```zsh
brew bundle --file setup/.Brewfile
```

Create symbolic links:

```zsh
sh setup/4_lns.sh
```

Apply macOS defaults:

```zsh
sh setup/5_mac.sh
```

Set file-extension associations for VS Code:

```zsh
sh setup/6_extension.sh
```

Set Zsh as the login shell if needed:

```zsh
chsh -s $(which zsh)
```

Restart the terminal after installation.

## Zsh

Zsh is configured through `ZDOTDIR`.

`zsh/.zshenv` sets:

- `LANG=ja_JP.UTF-8`
- `ZDOTDIR=$HOME/Desktop/github/dotfiles/zsh`
- color settings for `ls`
- Homebrew/C++ related paths

`zsh/.zshrc` loads modular configuration files in this order:

1. `settings/prompt.sh`
2. `settings/extensions.sh`
3. `settings/.fzf.zsh`
4. `aliases/basic.sh`
5. `aliases/mac.sh`
6. `aliases/git.sh`
7. `aliases/python.sh`
8. `aliases/latex.sh`
9. `aliases/encrypt.sh`
10. `aliases/others.sh`
11. `aliases/timer.sh`
12. `zsh/.api_keys` if it exists
13. `$HOME/.local/bin/env` if it exists

Keep secrets such as API keys in `zsh/.api_keys` and do not commit them.

## Homebrew

Main packages, GUI applications, Mac App Store apps, and VS Code extensions are managed in:

```text
setup/.Brewfile
```

To install everything from the Brewfile:

```zsh
brew bundle --file setup/.Brewfile
```

To update the Brewfile from the current machine:

```zsh
brew bundle dump --force --file setup/.Brewfile
```

## macOS settings

`setup/5_mac.sh` applies macOS defaults for:

- keyboard repeat and Japanese input settings
- trackpad behavior
- menu bar spacing
- Dock layout and animation
- Finder display options
- screenshot behavior
- Launchpad animation
- default application behavior

Review the script before running it. It changes system preferences, restarts Finder/Dock, and contains commands that affect default user folders.

## Symbolic links

`setup/4_lns.sh` creates symbolic links for:

- files under `home/` into `$HOME`
- `zsh/.zshenv` into `$HOME/.zshenv`
- xbar plugins
- Automator workflows under `~/Library/Services/`
- selected application support directories

The script uses `ln -sf`, so existing links/files at the target paths may be replaced.

## Vim

Install `vim-plug` and link `.vimrc`:

```zsh
sh vim/vim-plug_setup.sh
```

## Notes

- This repository is primarily designed for the author's own macOS environment.
- Some scripts contain machine-specific absolute paths.
- Read each setup script before running it on a new machine.
- Run bootstrap scripts step by step rather than all at once.
