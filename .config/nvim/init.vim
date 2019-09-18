" Config ---------------------------------------------------------------------

set encoding=utf-8
set fileencoding=utf-8
syntax on
set ttyfast
set lazyredraw
set cursorline
set nu
set rnu
set nowrap
set ai
set si
set smarttab
set clipboard=unnamed
set shiftwidth=2
autocmd FileType make setlocal shiftwidth=4 tabstop=4

" Plugins --------------------------------------------------------------------

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
Plug 'itchyny/lightline.vim'
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 ./install.py --ts-completer --rust-completer' }
Plug 'posva/vim-vue'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'arcticicestudio/nord-vim'

call plug#end()

" Plugin config --------------------------------------------------------------

call neomake#configure#automake('w')

let NERDTreeShowHidden = 1
map <silent> <C-s> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1

let g:user_emmet_install_global = 0
autocmd FileType html,css,jsx,tsx,vue EmmetInstall

let g:rustfmt_autosave = 1

let g:ale_fix_on_save = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'vue': ['eslint']
\}

let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_max_num_candidates = 20
let g:ycm_max_num_identifier_candidates = 10
let g:ycm_filetype_blacklist = {
\	'tagbar': 1,
\	'qf': 1,
\	'notes': 1,
\	'markdown': 1,
\	'unite': 1,
\	'text': 1,
\	'vimwiki': 1,
\	'pandoc': 1,
\	'infolog': 1,
\	'mail': 1
\}
let g:ycm_filepath_blacklist = {
\	'html': 1,
\	'jsx': 1,
\	'xml': 1,
\}

let g:lightline = {
\   'colorscheme': 'nord',
\}
colorscheme nord

" Keymapping -----------------------------------------------------------------

" Fuzzy find
nnoremap <C-P> :Files<CR>

" Thanks Lucas F. Costa for the advice
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
