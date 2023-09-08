local g = vim.g
local set = vim.opt
local autocmd = vim.api.nvim_create_autocmd

-------------
-- General
-------------
set.fileencoding = "utf-8"
set.undofile = true
set.swapfile = true
set.mouse = "a"
set.mousemodel = "popup"
set.mousefocus = true
set.mousehide = true
set.clipboard = "unnamedplus"
set.backspace = "indent,eol,start"
set.completeopt = "menuone,noinsert,noselect"
set.ignorecase = true
set.smartcase = true
set.showmatch = true
set.spelllang = "en_ca"

---------------------
-- USER EXPEREINCE
---------------------
set.termguicolors = true
set.wrap = true
set.wrapmargin = 80
-- set.textwidth = 0  -- set to 80 for hard newline break
set.linebreak = true
set.breakindent = true
set.showbreak = '>> '
set.colorcolumn = "80"
set.formatoptions = set.formatoptions + "t"
set.number = true
set.relativenumber = true
set.linespace = 3
set.showmode = false
set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"
set.splitright = true
set.splitbelow = true
set.lazyredraw = true
set.timeoutlen = 300
set.updatetime = 100

-----------------
-- INDENTATION
-----------------
vim.cmd [[filetype plugin indent on]]
set.smartindent = true
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2
set.expandtab = true
set.smarttab = true
set.autoindent = true

-- 2 space tabs
autocmd('Filetype', {
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript', 'yaml', 'lua', '*sh' },
  command = 'setlocal shiftwidth=2 tabstop=2 softtabstop=2',
})
autocmd('Filetype', {
  pattern = { 'hs', 'vim', 'pl' },
  command = 'setlocal shiftwidth=2 tabstop=2 softtabstop=2',
})
autocmd('Filetype', {
  pattern = { 'txt', 'md', 'markdown', 'tex', 'latex', 'bib' },
  command = 'setlocal shiftwidth=2 tabstop=2 softtabstop=2',
})
-- 4 space tabs
autocmd('Filetype', {
  pattern = { 'cs', 'java', 'py' },
  command = 'setlocal shiftwidth=4 tabstop=4 softtabstop=4',
})
-- 8 space tabs
autocmd('Filetype', {
  pattern = { 'asm', 'c', 'cpp' },
  command = 'setlocal shiftwidth=8 tabstop=8 softtabstop=8',
})

--------------
-- Filetypes
--------------
g.filetype_pl = "prolog"
vim.g.python3_host_prog = '$HOME/.virtualenvs/neovim3/bin/python'
-- spelling
autocmd('Filetype', {
  pattern = { 'txt', 'md', 'markdown', 'tex', 'latex', 'bib' },
  command = 'setlocal spell',
})
