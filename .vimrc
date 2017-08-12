"" Vundle stuff
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
" Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-endwise'
Plugin 'jiangmiao/auto-pairs'
Plugin 'bitc/vim-bad-whitespace'
Plugin 'tpope/vim-surround'
Plugin 'vim-orgmode'
Plugin 'speeddating.vim'

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
colorscheme default
" set mouse=a
set number
set showcmd
" set cursorline
set tabstop=2 expandtab shiftwidth=2

"" folding stuff
"set foldenable
"set foldlevelstart=10
"set foldnestmax=10
set foldmethod=manual
" nnoremap <space> za
" augroup AutoSaveFolds
  " autocmd!
  " autocmd BufWinLeave * mkview
  " autocmd BufWinEnter * silent loadview
" augroup END
" autocmd InsertEnter * let w:last_fdm=&foldmethod | setlocal foldmethod=manual
" autocmd InsertLeave * let &l:foldmethod=w:last_fdm

"" tab completion
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:set dictionary="/usr/dict/words"

"" misc
set colorcolumn=81
highlight ColorColumn ctermbg=0 guibg=lightgrey
" autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
runtime macros/matchit.vim
set clipboard+=unnamed
" set wildmode=longest,list,full
" set wildmenu
set splitright

"" Global stuff
let g:AutoPairs={'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`','|':'|'}

"" Keybinds
nmap <C-s>     :w<CR>
nmap <C-q>     :q<CR>
nmap <C-z>     :undo<CR>
nmap <leader>u :GundoToggle<CR>
nmap <C-b>     <Plug>EraseBadWhiteSpace
nmap <C-w>n    :vnew<space>
nmap <C-n>     :vnew<space>
nmap <leader>r :source ~/.vimrc<CR>

"" Comments
let NERDSpaceDelims=1
" map  <C-e> <leader>c<space>
" imap <C-e> <Esc><leader>c<space>i
" vmap <C-e> <leader>c<space>
