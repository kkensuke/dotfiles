inoremap jj <Esc>

nnoremap <C-t> :NERDTreeToggle<CR>


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

" Show line number
set number
" Show current position
set ruler
" Emphasize the current line
set cursorline
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
