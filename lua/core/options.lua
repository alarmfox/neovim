vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- tabs and indentation
opt.expandtab = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2

opt.relativenumber = true
opt.number = true
opt.wrap = true


-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

-- termgui forr colors
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start" --allow backspace on indent, end of line and insert mode start

-- clipboard
opt.clipboard:append("unnamedplus") -- system clipboard as default registeer
