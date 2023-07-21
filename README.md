# Dotfiles

## Appearance

![terminal](./img/terminal.png)

## Structure
![zsh-dir](./img/dotfiles.png)

## Settings
Set zsh as your login shell:
```bash
chsh -s $(which zsh)
```

In `.zshenv`, set `zsh/` as `ZDOTDIR`.
```zsh
export ZDOTDIR="$HOME/path/to/zsh"
```

And make the alias of `.zshenv` in your home directory.

```zsh
ln -s ~/path/to/dotfiles/zsh/.zshenv ~/.zshenv
```

---
The details of my `zsh/` are described in [Zsh](https://kkensuke.github.io/myjb/pages/basic/zsh.html) and [Alias](https://kkensuke.github.io/myjb/pages/basic/alias.html).
