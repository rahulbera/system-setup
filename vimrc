" Gotta be first
set nocompatible

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/syntastic'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'
Plugin 'vim-airline/vim-airline'
Plugin 'craigemery/vim-autotag'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'michalbachowski/vim-wombat256mod'
Plugin 'notpratheek/vim-luna'
Plugin 'marciomazza/vim-brogrammer-theme'
Plugin 'scwood/vim-hybrid'
Plugin 'mhartington/oceanic-next'
Plugin 'wellsjo/wellsokai.vim'
call vundle#end()

filetype plugin indent on

"Uncomment to open tagbar automatically whenever possible
autocmd BufEnter * nested :call tagbar#autoopen(0)

"----- bling/vim-airline settings -----
" Always show statusbar
"set laststatus=2
"Fancy arrow symbols, requires a patched font
" To install a patched font, run over to
"     https://github.com/abertsch/Menlo-for-Powerline
" download all the .ttf files, double-click on them and click "Install"
" Finally, uncomment the next line
"let g:airline_powerline_fonts = 1
" Show PASTE if in paste mode
"let g:airline_detect_paste=1
" Show airline for tabs too
"let g:airline#extensions#tabline#enabled = 1

let g:airline_theme = 'molokai'
let g:molokai_original = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
set laststatus=2
set ttimeoutlen=50

syntax on
set background=dark
set number
colo wellsokai
set title
set wrap
set incsearch
set hlsearch
set cindent

nmap <F8> :TagbarToggle<CR>
nmap <silent> <F7> :NERDTreeTabsToggle<CR>
nmap <C-N> :tabnew<CR>
imap <C-N> :tabnew<CR>
nmap <F6> :tabn<CR>
imap <F6> :tabn<CR>
nmap <F5> :tabp<CR>
imap <F5> :tabp<CR>

inoremap <c-s> <c-o>:Update<CR>

set t_Co=256
