-- Basic config
vim.opt.compatible = false
vim.opt.number = true
vim.opt.wrap = false
vim.opt.shiftwidth = 4
vim.opt.swapfile = false
vim.opt.backspace = 'indent,eol,start'
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.lazyredraw = true
vim.opt.ignorecase = true
vim.opt.history = 1000
vim.opt.ruler = true
vim.opt.scrolloff = 3
vim.opt.startofline = false
vim.opt.title = true
vim.opt.cmdheight = 2
vim.opt.showmatch = true
vim.opt.iskeyword:append { '_', '$', '@', '%', '#' }
vim.opt.cursorcolumn = true
vim.opt.virtualedit = 'onemore'
vim.opt.hidden = true
vim.opt.wildmenu = true

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- UI
vim.opt.showtabline = 0
vim.opt.shortmess:append 'atIA'
vim.opt.laststatus = 2
vim.opt.colorcolumn = '119'

-- Search
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.wrapscan = true
vim.opt.smartcase = true
vim.opt.magic = true

-- Folds
vim.opt.foldmethod = 'syntax'
vim.opt.foldlevelstart = 2

-- Undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.vim/undodir')
vim.opt.undolevels = 1000
vim.opt.undoreload = 1000

-- Performance
vim.opt.cursorline = false
vim.opt.relativenumber = false
vim.opt.regexpengine = 0
vim.opt.maxmempattern = 2000000

-- Dark mode
vim.opt.background = 'dark'

-- Clipboard
vim.opt.clipboard = 'unnamed'

-- Filetype plugin indent
vim.cmd.filetype('plugin', 'indent', 'on')
