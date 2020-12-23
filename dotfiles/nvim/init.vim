" Title: NeoVim Configuration File
" Desc: A self-contained NeoVim configuration file
" Author: Jacobus Burger <therealjacoburger@gmail.com>
" Date: 2020-08-23





" +-------------+
" | ENVIRONMENT |
" +-------------+

" -- Environment variables
let snippets_dir = '.config/nvim/UltiSnips'
let snippets_ext = '.snippets'
let fixers = {
    \ 'python': ['black'],
\}
let linters = {
    \ 'python': ['flake8'],
    \ 'c': ['gcc'],
    \ 'cpp': ['g++'],
    \ 'haskell': ['hlint', 'ghc'],
\}

" -- Setup environment if not already installed
" TODO test that this script works on a new machine
if empty(glob('~/.config/nvim/autoload/plug.vim')) " install vim-plug
  " install vim-plug and run it upon entering vim
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall

  " create a user UltiSnips directory assuming it doesn't already exist
  execute '!mkdir ' . $HOME . '/' . snippets_dir . ' &2>/dev/null'
endif 

" -- Report any missing components
" report missing linters
for language in keys(fixers)
  for program in linters[language]
    if !executable(program)
      echo program . " linter for " . language . " is not installed!"
    endif
  endfor
endfor
" report missing formatters
for language in keys(fixers)
  for program in fixers[language]
    if !executable(program)
      echo program . " formatter for " . language . " is not installed!"
    endif
  endfor
endfor
" report missing snippet files
for lang in keys(linters)
  let file = $HOME
  let file .= '/' . snippets_dir . '/' . lang . snippets_ext
  if empty(glob(file))
    echo "snippet for for " . lang . " not found in snippets directory"
  endif
endfor





" +---------+
" | PLUGINS |
" +---------+
filetype off            " PLUGIN ENSURANCE
call plug#begin()
" -- Sytnax
Plug 'sheerun/vim-polyglot' " extended syntax highlighting
Plug 'dense-analysis/ale' " Asynchronous Lint Engine
" -- Snippets
Plug 'SirVer/ultisnips' " | Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
" -- Completion
Plug 'prabirshrestha/async.vim'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-highprio-pop'
" -- Language Specific
Plug 'kalekundert/vim-coiled-snake', { 'for': 'python' } " py folding++
Plug 'junegunn/limelight.vim', { 'for': 'markdown' }  " focus writing
" -- Quality of Life
Plug 'tmsvg/pear-tree' " smart pairs
Plug 'ludovicchabant/vim-gutentags' " automatic ctags
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter' " sets working directory to proj root
Plug 'preservim/nerdcommenter' " nerd commenter
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' } " visualize file tree
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' } " visualize undo tree
Plug 'mhinz/vim-signify' " indicate vcs diff
Plug 'itchyny/vim-gitbranch' " gitbranch#name for lightline
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim' | Plug 'mengelbrecht/lightline-bufferline'
Plug 'Konfekt/FastFold'
" Plug 'metakirby5/codi.vim' " interactive REPL scratchpad
Plug 'kevinhwang91/vim-ibus-sw' " ibus input method handling
" -- Themes
Plug 'sainnhe/edge'
Plug 'lifepillar/vim-solarized8'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'sickill/vim-monokai'
Plug 'haishanh/night-owl.vim'
call plug#end()
filetype plugin indent on

" - Theme Settings
set t_Co=256 termguicolors encoding=utf-8 fileencoding=utf-8
set background=dark
colorscheme gruvbox





" +----------------------+
" | CUSTOM ABBREVIATIONS |
" +----------------------+
iabbrev @@ therealjacoburger@gmail.com





" +--------------------+
" | STD VIMRC SETTINGS |
" +--------------------+

" --- standard settings
syntax enable
set nocompatible
set number relativenumber
set lazyredraw
set noshowmode showcmd
set backspace=indent,eol,start " backspace compatibility
set visualbell t_vb=
set hlsearch incsearch showmatch
set foldmethod=syntax
set expandtab smarttab
set undofile " enable persistent undo
set clipboard=unnamedplus
set autochdir
set updatetime=100
set timeoutlen=390 " make leader key delay faster
set colorcolumn=81 " show where the 80 column limit is visually
" set cursorline " highlight line of cursor (note: can cause lag)
set wrap linebreak nolist
set expandtab smarttab smartindent autoindent
set shiftwidth=2 tabstop=2 softtabstop=2





" +-----------------+
" | CUSTOM MAPPINGS |
" +-----------------+

" map leader key to ';'
let mapleader = ';'

" nmap <leader>wj <C-w>j
" nmap <leader>wk <C-w>k

" buffer switching
" TODO eliminate this
nmap <leader><space>1 <Plug>lightline#bufferline#go(1)
nmap <leader><space> :bn<CR>

" konomi code habit breaker
noremap <up> <nop>
inoremap <up> <nop>
noremap <down> <nop>
inoremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" esc key habit breaker
noremap ii <esc>
inoremap ii <esc>

" FZF navigation mappings
nmap <C-p> :Files<CR>
nmap <leader><space><space> :Buffers<CR>
nmap <C-a> :Ag<CR>
" tags?





" +------------------------+
" | VIMRC HELPER FUNCTIONS |
" +------------------------+
" TODO





" +---------------------+
" |  LANGUAGE SETTINGS  |
" +---------------------+

" --- Special rules
autocmd FileType markdown setlocal spell
autocmd FileType asm set filetype=nasm
autocmd BufNewFile,BufRead *.asm set filetype=nasm
autocmd BufNewFile,BufRead *.h set filetype=c

" --- Indentation rules
" 2-space tabs
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType scss setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType haskell setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType *sh setlocal shiftwidth=2 tabstop=2 softtabstop=2 nofoldenable
" 4-space tabs
autocmd FileType cs setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType lua setlocal shiftwidth=4 tabstop=4 softtabstop=4
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4
" 8-space tabs
autocmd FileType asm setlocal shiftwidth=8 tabstop=8 softtabstop=8
autocmd FileType c setlocal shiftwidth=8 tabstop=8 softtabstop=8
autocmd FileType cpp setlocal shiftwidth=8 tabstop=8 softtabstop=8





" +-----------------------+
" | Plugin Configurations |
" +-----------------------+

" -- FZF
let g:fzf_preview_window = 'right:60%'
let g:fzf_buffers_jump = 1
let g:fzf_tags_command = 'ctags -R'
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--preview', 'bat --color always --style full {}']}, <bang>0)

" -- NCM2
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,noselect,menuone

" -- ALE
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_fixers = fixers
let g:ale_linters = linters
let g:ale_c_gcc_options = '-std=c99 -Wall -Wextra'
let g:ale_cpp_gcc_options = '-std=c++98 -Wall -Wextra'
let g:ale_haskell_ghc_options = ''
let g:ale_haskell_hlint_options = ''

" -- NerdTree
nmap <F8> :NERDTreeToggle<CR>

" -- Undotree
nmap <F9> :UndotreeToggle<CR> :wincmd w<CR>
let g:undotree_DiffAutoOpen = 0

" -- NerdComments
let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCustomDelimiters = {
      \ 'c': {'left': '//'},
\}

" -- Autocompletion and Snippets 
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:UltiSnipsExpandTrigger = '<leader><leader>'
let g:UltiSnipsSnippetsDir = $HOME . '/' . snippets_dir

" -- Pear Tree
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
let g:pear_tree_map_special_keys = 1
let g:pear_tree_repeatable_expand = 0

" -- Limelight
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 3

" -- Lightline
let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left': [
    \               ['mode', 'paste'],
    \               ['gitbranch', 'readonly', 'modified'],
    \               ['filename']
    \           ],
    \   'right': [
    \               [ 'lineinfo' ],
    \               [ 'percent' ],
    \               [ 'filetype', 'fileencoding', 'charvaluehex' ]
    \            ]
    \ },
    \ 'inactive': {
    \   'left': [ [ 'gitbranch', 'filename' ] ],
    \   'right': [ [ 'lineinfo', 'fileencoding', 'filetype' ] ],
    \ },
    \ 'tab': {
    \   'active': [ 'tabnum', 'filename', 'modified' ],
    \ },
    \ 'tabline': {
    \   'left': [ ['buffers'] ],
    \   'right': [ [ ] ],
    \ },
    \ 'component_function': {
    \   'gitbranch': 'gitbranch#name'
    \ },
    \ 'component_expand': {
    \   'buffers': 'lightline#bufferline#buffers'
    \ },
    \ 'component_type': {
    \   'buffers': 'tabsel'
    \ },
\ }
