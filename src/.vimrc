"" Vundle stuffdsdss
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-ruby/vim-ruby'
" Plugin 'vim-utils/vim-ruby-fold'
Plugin 'scrooloose/nerdcommenter'
Plugin 'sjl/gundo.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-endwise'
Plugin 'jiangmiao/auto-pairs'
Plugin 'bitc/vim-bad-whitespace'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"" End of Vundle stuff


syntax enable
set background=dark
colorscheme solarized
set mouse=a
set tabstop=2
set softtabstop=2
set expandtab
filetype indent on
set number
set showcmd
set cursorline
set foldenable
set foldlevelstart=10
set foldnestmax=10
nnoremap <space> za
set colorcolumn=81
highlight ColorColumn ctermbg=0 guibg=lightgrey

autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
runtime macros/matchit.vim

"" Global stuff
let g:AutoPairs={'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`','|':'|'}

"" Keybinds
nmap <C-s>     :w<CR>    " save
nmap <C-w>     :q<CR>    " quit
nmap <C-z>     :undo<CR> " undo
nmap <C-z>     :redo<CR> " redo
nmap <C-e>     <leader>cc
nmap <leader>u :GundoToggle<CR>
nmap <C-b>      <Plug>EraseBadWhiteSpace
