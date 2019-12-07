" Bootstrap Plug
let autoload_plug_path = stdpath('config') . '/site/autoload/plug.vim'
if !filereadable(autoload_plug_path)
  silent execute '!curl -fLo ' . autoload_plug_path . '  --create-dirs 
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet autoload_plug_path

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'altercation/vim-colors-solarized'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

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