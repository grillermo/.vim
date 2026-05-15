-- Set mapleader BEFORE loading lazy.nvim
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Load settings
require('config.options')
require('config.autocmds')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require('lazy').setup('plugins', {
  defaults = { lazy = false },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

-- Load keymaps last (after plugins may register their own)
require('config.keymaps')

-- Set colorscheme
vim.cmd.colorscheme('gruvbox')
