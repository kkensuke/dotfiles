# Dotfiles

## Structure
![zsh-dir](./img/dotfiles.png)


## Zsh settings
- Set zsh as your login shell:
    ```zsh
    chsh -s $(which zsh)
    ```

- In `.zshenv`, set `zsh/` as `ZDOTDIR`.
    ```zsh
    export ZDOTDIR="$HOME/path/to/dotfiles/zsh"
    ```

- And make the alias of `.zshenv` in your home directory.
    ```zsh
    ln -s ~/path/to/dotfiles/zsh/.zshenv ~/.zshenv
    ```

- Install `zsh` plugins.
    ```zsh
    brew install zsh-autosuggestions
    brew install zsh-completions
    brew install zsh-git-prompt
    ```

## Others
- Install `coreutils`, `gh` and `tree`.

    ```zsh
    brew install coreutils
    brew install gh
    brew install tree
    ```

- Change language setting in `.zshenv`. You can check available locale with `locale -a`.

    ```zsh
    export LANG=ja_JP.UTF-8
    ```

---
The details of my `zsh/` are described in [Zsh](https://kkensuke.github.io/myjb-en/pages/basic/zsh.html) and [Alias](https://kkensuke.github.io/myjb-en/pages/basic/alias.html).
