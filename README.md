# Dotfiles

![zsh-dir](./img/dotfiles.png)

In .zshenv, set `zsh/` as `ZDOTDIR`
```zsh
export ZDOTDIR="$HOME/path/to/zsh"
```

And make the alias of `.zshenv` in the home directory

```zsh
ln -s ~/path/to/zsh/.zshenv ~/.zshenv
```