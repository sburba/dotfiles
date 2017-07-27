:imap jk <Esc>

filetype plugin indent on

" Make tab be 4 spaces always
set tabstop=4
set shiftwidth=4
set expandtab

" Visual line movements
nnoremap j gj
nnoremap k gk

" Simplify window split commands
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Make searching incremental and highlight
:set incsearch
:set hlsearch

" Molokai color scheme
set t_Co=16
colorscheme molokai
let g:molokai_original = 1

" Make searching incremental and highlight
:set incsearch
:set hlsearch

" Case insensitive search by default
set ignorecase

" All copies go to the system clipboard
:set clipboard=unnamedplus

autocmd VimLeave * call system("xsel -ib", getreg('+'))
autocmd VimLeave * call system("xsel -ip", getreg('*'))

