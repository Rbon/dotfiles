" Bootstrap Plug
let autoload_plug_path = stdpath('config') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path
call plug#begin('~/.vim/plugged')

" PLUGINS
Plug 'altercation/vim-colors-solarized'

call plug#end()


set nocompatible " be iMproved
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
set laststatus=1 " show statusline only if more than one buffer
set textwidth=80 " line wrap
colorscheme solarized
syntax enable " self explanatory


" KEYBINDS
noremap  <C-c>           <Nop>
noremap  <leader>r            :source ~/.config/nvim/init.vim<CR>
noremap  <silent> <C-a>"          <Esc>:vnew<CR>
tnoremap <silent> <C-a>"     <C-\><C-n>:vnew<CR>
noremap  <silent> <C-a>=          <Esc>:new<CR>
tnoremap <silent> <C-a>=     <C-\><C-n>:new<CR>
noremap  <silent> <C-a>z          <Esc>:tabnew %<CR> " 'zoom'
noremap  <silent> <C-a><C-c>      <Esc>:tabnew<CR>:terminal<CR>i
tnoremap <silent> <C-a><C-c> <C-\><C-n>:tabnew<CR>:terminal<CR>i
noremap  <silent> <C-a>h          <Esc><C-w>h
tnoremap <silent> <C-a>h     <C-\><C-n><C-w>h
noremap  <silent> <C-a><C-h>      <Esc>:tabprevious<CR>
tnoremap <silent> <C-a><C-h> <C-\><C-n>:tabprevious<CR>
noremap  <silent> <C-a>j          <Esc><C-w>j
tnoremap <silent> <C-a>j     <C-\><C-n><C-w>j
noremap  <silent> <C-a><C-j>      <Esc><C-w>j
tnoremap <silent> <C-a><C-j> <C-\><C-n><C-w>j
noremap  <silent> <C-a>k          <Esc><C-w>k
tnoremap <silent> <C-a>k     <C-\><C-n><C-w>k
noremap  <silent> <C-a><C-k>      <Esc><C-w>k
tnoremap <silent> <C-a><C-k> <C-\><C-n><C-w>k
noremap  <silent> <C-a>l          <Esc><C-w>l
tnoremap <silent> <C-a>l     <C-\><C-n><C-w>l
noremap  <silent> <C-a><C-l>      <Esc>:tabnext<CR>
tnoremap <silent> <C-a><C-l> <C-\><C-n>:tabnext<CR>
noremap  <C-a>Q          <Esc>:quit<CR>
tnoremap <C-a>Q     <C-\><C-n>:quit<CR>
noremap  <C-s>           <Esc>:w<CR>
noremap  <C-o>           <Esc>:edit<space>
tnoremap <C-o>      <C-\><C-n>:edit<space>
tnoremap <leader>e  <C-\><C-n>


" TABS
hi TabLineSel term=bold cterm=none ctermfg=Red ctermbg=7 " current tab
hi TabLine term=none cterm=none ctermfg=10 ctermbg=7 " other tabs
hi TabWinNumSel term=bold cterm=bold ctermfg=90 ctermbg=30
hi TabNumSel term=bold cterm=bold ctermfg=16 ctermbg=30

hi TabLineFill term=none cterm=none ctermfg=16 ctermbg=7 "empty space after tabs
hi TabWinNum term=bold cterm=bold ctermfg=90 ctermbg=145
hi TabNum term=bold cterm=bold ctermfg=17 ctermbg=145
" hi StatusLine ctermbg=2 ctermfg=2

set statusline=
set statusline+=\ %f
set statusline+=\ \line:\ %l

let tab1=""
let tab2=""
let tab3=""
let tab4=""
let tab5=""

function! GetBarInfo(buf, tabnum)
  let tabNames = [g:tab1,g:tab2,g:tab3,g:tab4,g:tab5]
  let name = tabNames[a:tabnum - 1]
  if name == ""
    return bufname(a:buf)
  else
    return name
  endif
endfunction

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
      let g:barInfo = GetBarInfo(bufnr, i)
      let file = g:barInfo
      " let file = bufname(bufnr)

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
    let s .= " "
    return s
  endfunction

  set stal=2
  set tabline=%!MyTabLine()
endif

let tablineTimer = timer_start(2000, 'RefreshTabline', {'repeat': -1})

func! RefreshTabline(timer)
  set tabline=%!MyTabLine()
endfunc
