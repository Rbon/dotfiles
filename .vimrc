set nocompatible " be iMproved
syntax enable " self explanatory
set expandtab " turns <Tab> into spaces
set softtabstop=2 " set tab width to 2 spaces (works with backspace too!)
set list " show some shitespace characters
set listchars=tab:──,trail:·,extends:>,precedes:<, " whitespace char mappings
set encoding=utf-8 " placebo
set showcmd " makes leader commands visible
set splitright " makes new vertical windows spawn on the right
set scrolloff=3 " Keep 3 lines below and above the cursor
set background=light " for solorized-dark
colorscheme solarized

set colorcolumn=81 " make a column at the 81st char

" color of said column
highlight ColorColumn ctermbg=7


" KEYBINDS
map <leader>r :source ~/.vimrc<CR>
map <C-w>"    :vnew<space>
map <C-w>=    :new<space>
map <C-t>     <Nop>
map <C-t>n    <Esc>:tabedit<space>
map <C-t>l    <Esc>:tabnext<CR>
map <C-t>h    <Esc>:tabprevious<CR>
map <C-s>     <Esc>:w<CR>

" TABS

hi TabLineSel term=bold cterm=none ctermfg=Red ctermbg=7 " current tab
hi TabLine term=none cterm=none ctermfg=10 ctermbg=7 " other tabs
hi TabWinNumSel term=bold cterm=bold ctermfg=90 ctermbg=30
hi TabNumSel term=bold cterm=bold ctermfg=16 ctermbg=30

hi TabLineFill term=none cterm=none ctermfg=16 ctermbg=7 "empty space after tabs
hi TabWinNum term=bold cterm=bold ctermfg=90 ctermbg=145
hi TabNum term=bold cterm=bold ctermfg=16 ctermbg=145

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
        return s
    endfunction
    set stal=2
    set tabline=%!MyTabLine()
endif
