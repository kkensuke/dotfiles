inoremap jj <Esc>

" Ctrl+t to use NERDTree
nnoremap <C-t> :NERDTreeToggle<CR>
" Spacebar to type ':' in normal mode
nnoremap <space> :
" You can split the window in Vim by typing :split or :vsplit.
" Move between windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Set to auto read when a file is changed from the outside
set autoread
" Turn backup off
set nowritebackup
set nobackup
set noswapfile

" Ignore case when searching
set ignorecase
" Shows the search matches as you type
set incsearch
" Highlight search
set hlsearch
" Enable regular expressions in search
set magic

" Set colorscheme
" mkdir -p ~/.vim/colors; cd ~/.vim/colors; git clone https://github.com/tomasr/molokai
colorscheme molokai
" Show the mode you are on the last line.
set showmode
" Clear status line when vimrc is reloaded
set statusline=
" Status line left side
set statusline+=\ %F\ %M\ %Y\ %R
" Status line right side.
set statusline+=%=row:\ %l\ col:\ %c\ percent:\ %p%%\ \ 
" Show the status on the second to last line
set laststatus=2

" Show line number
set number
" Show current position
set ruler
" Emphasize the current line
set cursorline
set cursorcolumn
" Set spell check
set spell
" Tab completion
set wildmenu
" Move cursor to the adjacent line
set whichwrap=b,s,h,l,<,>,[,],~

" Expand tab
set expandtab
" Set tab width
set tabstop=4
set softtabstop=4
" Keep indent
set autoindent
" Add new indent
set smartindent
" Set smartindent width
set shiftwidth=4

" Remove scrollbar
set guioptions+=R
" buffer scroll
set mouse=a
" Syntax highlight
syntax on
" No error bell
set noerrorbells
" Show matching brackets
set showmatch matchtime=1
" Show trailing whitespace
set listchars=tab:^\ ,trail:~
" add to clipboard when yanking
set guioptions+=a


call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

Plug 'honza/vim-snippets'

" On-demand loading
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" File system explorer for the Vim editor
Plug 'preservim/nerdtree'

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
