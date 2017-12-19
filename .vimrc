
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
Plugin 'lrvick/Conque-Shell'
Plugin 'gcmt/taboo.vim'
Plugin 'altercation/vim-colors-solarized'

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
set clipboard=unnamedplus
" set wildmode=longest,list,full
" set wildmenu
set splitright
set scrolloff=3 " Keep 3 lines below and above the cursor

"" Global stuff
let g:AutoPairs={'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`','|':'|'}

" Keybinds {
nnoremap <C-s>      :w<CR>
inoremap <C-s>      <Esc>:wa<CR>
nnoremap <C-q>      :q<CR>
nnoremap <C-z>      :undo<CR>
nnoremap <leader>u  :GundoToggle<CR>
nnoremap <C-b>      <Plug>EraseBadWhiteSpace
nnoremap <C-w>"     :vnew<space>
nnoremap <C-w>=     :new<space>
nnoremap <leader>r  :source ~/.vimrc<CR>
nnoremap <C-t>      <Nop>
nnoremap <C-t>n     :tabedit<space>
nnoremap <C-t>l     :tabnext<CR>
nnoremap <C-t>h     :tabprevious<CR>
nnoremap <C-t>r     :TabooRename<space>
nnoremap <C-t><S-r> :TabooReset<CR>
nnoremap <S-j>      <C-d>
nnoremap <S-k>      <C-u>
nnoremap <C-p>      o<Esc>p
" nnoremap <C-o>n    :
nnoremap <space>   za

let g:lasttab = 1
nmap <C-t><Tab> :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
" }

" setg:taboo_tab_format:

"" Comments
let NERDSpaceDelims=1
" map  <C-e> <leader>c<space>
" imap <C-e> <Esc><leader>c<space>i
" vmap <C-e> <leader>c<space>
