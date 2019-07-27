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
set background=dark " for solorized-dark
colorscheme solarized

set colorcolumn=81 " make a column at the 81st char

" color of said column
highlight ColorColumn ctermbg=0


" KEYBINDS
map <leader>r :source ~/.vimrc<CR>
map <C-w>"    :vnew<space>
map <C-w>=    :new<space>
map <C-t>     <Nop>
map <C-t>n    <Esc>:tabedit<space>
map <C-t>l    <Esc>:tabnext<CR>
map <C-t>h    <Esc>:tabprevious<CR>
map <C-s>     <Esc>:w<CR>
