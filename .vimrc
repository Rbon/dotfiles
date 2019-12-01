" set nocompatible              " be iMproved, required
                        " filetype off                  " required

" set the runtime path to include Vundle and initialize
                        " set rtp+=~/.vim/bundle/Vundle.vim
                                                " call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
                        " Plugin 'VundleVim/Vundle.vim'

                                                " Plugin 'gcmt/taboo.vim'

" All of your Plugins must be added before the following line
                        " call vundle#end()            " required
                                                " filetype plugin indent on    " required
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

set guioptions-=e
set guioptions-=m
set guioptions-=T
set guifont=Hasklig\ Medium\ 16
set nocompatible " be iMproved
syntax enable " self explanatory
set expandtab " turns <Tab> into spaces
set softtabstop=2 " set tab width to 2 spaces (works with backspace too!)
set list " show some shitespace characters
set listchars=tab:──,trail:·,extends:>,precedes:<, " whitespace char mappings
set encoding=utf-8 " placebo
set showcmd " makes leader commands visible
set splitright " makes new vertical windows spawn on the right
set splitbelow " similar
set scrolloff=3 " Keep 3 lines below and above the cursor
set background=light " for solorized
set shell=/bin/zsh
" colorscheme solarized
set laststatus=2
" set statusline=%{strftime('%H\:%M')}

set colorcolumn=81 " make a column at the 81st char

" color of said column
highlight ColorColumn ctermbg=7


" KEYBINDS
map      <leader>r :source ~/.vimrc<CR>
map      <C-w>"    :vnew<CR>
map      <C-w>z    :tabnew %<CR>
map      <C-w>=    :new<CR>
map      <C-t>     <Nop>
map      <C-t>n    <Esc>:tabnew<CR>
map      <C-t>l    <Esc>:tabnext<CR>
map      <C-t>h    <Esc>:tabprevious<CR>
map      <C-s>     <Esc>:w<CR>
map      <C-o>     :edit<space>
map      <C-t>r    :TabooRename<space>
map      <C-t>R    :TabooReset<CR>
tnoremap <leader>e <C-\><C-n>
tnoremap <C-t>n    <C-\><C-n>:tabnew<CR>
tnoremap <C-t>l    <C-\><C-n>:tabnext<CR>
tnoremap <C-t>h    <C-\><C-n>:tabprevious<CR>

" TABS

hi TabLineSel term=bold cterm=none ctermfg=Red ctermbg=7 " current tab
hi TabLine term=none cterm=none ctermfg=10 ctermbg=7 " other tabs
hi TabWinNumSel term=bold cterm=bold ctermfg=90 ctermbg=30
hi TabNumSel term=bold cterm=bold ctermfg=16 ctermbg=30

hi TabLineFill term=none cterm=none ctermfg=16 ctermbg=7 "empty space after tabs
hi TabWinNum term=bold cterm=bold ctermfg=90 ctermbg=145
hi TabNum term=bold cterm=bold ctermfg=16 ctermbg=145
hi StatusLine ctermbg=10 ctermfg=7

set statusline=
set statusline+=\ %f
set statusline+=\ \line:\ %l

let barInfo=" "

if exists("+showtabline")
  function! MyTabLine()
    let s = ''
    let wn = ''
    let t = tabpagenr()
    let i = 1

    while i <= tabpagenr('$')
      let buflist = tabpagebuflist(i)
      let winnr = tabpagewinnr(i)
      "let s .= '%' . i . 'T'
      "let s .= (i == t ? '%1*' : '%2*')
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
      let s .= ' '
      "let wn = tabpagewinnr(i,'$')
      "let s .= (i== t ? '%#TabNumSel#' : '%#TabNum#')
      "let s .= i

      if tabpagewinnr(i,'$') > 1
        "let s .= '.'
        "let s .= (i== t ? '%#TabWinNumSel#' : '%#TabWinNum#')
        "let s .= (tabpagewinnr(i,'$') > 1 ? wn : '')
      end

      "let s .= ' %*'
      let bufnr = buflist[winnr - 1]
      let file = bufname(bufnr)
      let buftype = getbufvar(bufnr, 'buftype')

      if buftype == 'nofile'
        if file =~ '\/.'
          let file = substitute(file, '.*\/\ze.', '', '')
        endif
      else
        let file = fnamemodify(file, ':p:t')
      endif

      if file == ''
        let file = '[No Name]'
      endif

      let s .= file
      let s .= (i == t ? '%m' : '')
      let s .= ' '
      let i = i + 1

    endwhile

    let s .= '%T%#TabLineFill#%='
    let s .= strftime('%I:%M %p %B %d, %Y ')
    let s .= g:barInfo
    let s .= " "
    return s
  endfunction

  set stal=2
  set tabline=%!MyTabLine()
endif

let tablineTimer = timer_start(2000, 'RefreshTabline', {'repeat': -1})

func RefreshTabline(timer)
  set tabline=%!MyTabLine()
endfunc

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

