curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

[[ ! -f ~/.vimrc ]] && ln -s $DOTFILES/vim/.vimrc ~/.vimrc; vim -s $DOTFILES/vim/PlugInstall.keys ~/.vimrc