" Config

set encoding=utf-8
set fileencoding=utf-8
syntax on

set ttyfast
set lazyredraw

set cursorline
set number
set nowrap

set ai
set si
set smarttab

" Plugins

call plug#begin()

Plug 'neomake/neomake'

Plug 'editorconfig/editorconfig-vim'

Plug 'pangloss/vim-javascript'

Plug 'leafgarland/typescript-vim'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'mattn/emmet-vim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'rust-lang/rust.vim'

Plug 'terryma/vim-multiple-cursors'

Plug 'w0rp/ale'

call plug#end()

" Plugin config

call neomake#configure#automake('w')

let NERDTreeShowHidden=1
map <silent> <C-s> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen=1

let g:user_emmet_install_global = 0
autocmd FileType html,css,jsx,tsx,vue EmmetInstall

let g:rustfmt_autosave = 1

let g:ale_fix_on_save = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}

" Keymapping

nnoremap <C-P> :Files<CR>

" dont use arrowkeys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" really, just dont
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
