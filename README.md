# dotfiles

Personal dotfiles and macOS bootstrap scripts for setting up a development environment.

This repository is organized around a Zsh-based shell setup, Homebrew-managed applications, macOS defaults, editor/terminal settings, and small utility scripts.

## Overview

```text
.
├── ghostty/       # Ghostty terminal configuration
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

### 1. Clone this repository

```zsh
git clone https://github.com/kkensuke/dotfiles.git ~/Desktop/github/dotfiles
cd ~/Desktop/github/dotfiles
```

### 2. Install Xcode Command Line Tools

```zsh
sh setup/1_xcode.sh
```

### 3. Install Homebrew

```zsh
sh setup/2_homebrew.sh
```

### 4. Install packages and applications

The recommended source of truth is `setup/.Brewfile`:

```zsh
brew bundle --file setup/.Brewfile
```

The Brewfile manages CLI tools, GUI applications, Mac App Store apps, and VS Code extensions.

`setup/3_brew_install.sh` is an alternative/manual install script. Review it before running it because it also contains GitHub CLI authentication and repository-deletion alias setup.

### 5. Create symbolic links

```zsh
sh setup/4_lns.sh
```

This links the files in `home/`, the Zsh environment file, xbar plugins, Automator workflows, and selected application-support directories.

### 6. Apply macOS defaults

```zsh
sh setup/5_mac.sh
```

Review this script before running it. It changes system preferences and restarts Finder/Dock.

### 7. Set file-extension associations

```zsh
sh setup/6_extension.sh
```

This configures selected file types to open in VS Code.

### 8. Set Zsh as the login shell

If needed:

```zsh
chsh -s "$(which zsh)"
```

Restart the terminal after installation.

## Zsh

Zsh is configured through `ZDOTDIR`.

`zsh/.zshenv` sets environment variables and paths, including:

- `LANG=ja_JP.UTF-8`
- `ZDOTDIR=$HOME/Desktop/github/dotfiles/zsh`
- color settings for `ls`
- Homebrew/C++ related paths

`zsh/.zshrc` loads modular configuration files for prompt, completion, fzf, aliases, and other shell extensions.

Keep secrets such as API keys in `zsh/.api_keys` and do not commit them.

## Homebrew

Main packages, GUI applications, Mac App Store apps, and VS Code extensions are managed in:

```text
setup/.Brewfile
```

Install everything from the Brewfile:

```zsh
brew bundle --file setup/.Brewfile
```

Update the Brewfile from the current machine:

```zsh
brew bundle dump --force --file setup/.Brewfile
```

Because the Brewfile reflects the author's working environment, review it before installing everything on a new machine.

## macOS settings

`setup/5_mac.sh` applies macOS defaults for areas such as:

- keyboard repeat and Japanese input settings
- trackpad behavior
- menu bar spacing
- Dock layout and animation
- Finder display options
- screenshot behavior
- Launchpad animation
- default application behavior

The script contains system-level and user-folder changes, so read it before execution.

## Symbolic links

`setup/4_lns.sh` creates symbolic links for:

- files under `home/` into `$HOME`
- `zsh/.zshenv` into `$HOME/.zshenv`
- xbar plugins
- Automator workflows under `~/Library/Services/`
- selected application-support directories

The script uses `ln -sf`, so existing links/files at the target paths may be replaced. It also references other directories outside this repository, such as an `espanso` checkout and a Zotero application-support directory.

## Ghostty

Ghostty configuration is stored in:

```text
ghostty/config.ghostty
```

Copy or link it to the Ghostty configuration location you use on your machine.

## Vim

Install `vim-plug` and link `.vimrc`:

```zsh
sh vim/vim-plug_setup.sh
```

## Optional setup scripts

Additional scripts under `setup/` cover machine-specific or optional configuration, including:

- `enable_TouchID_for_sudo.sh` — enable Touch ID authentication for `sudo`
- `cryptomator_cli.sh` — Cryptomator CLI-related setup
- `latex.sh` — LaTeX-related setup

Review each script before running it.

## Notes

- This repository is primarily designed for the author's own macOS environment.
- Some scripts contain machine-specific absolute paths.
- Read each setup script before running it on a new machine.
- Run bootstrap scripts step by step rather than all at once.
- Prefer `setup/.Brewfile` when reproducing the package/application environment.
