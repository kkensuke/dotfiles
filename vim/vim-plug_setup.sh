curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

[[ ! -f ~/.vimrc ]] && ln -s ~/My\ Drive/app/github/dotfiles/vim/.vimrc ~/.vimrc; vim -s PlugInstall.keys ~/.vimrc