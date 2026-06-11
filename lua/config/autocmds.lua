local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Auto-save on focus lost
autocmd('FocusLost', {
  command = 'silent! wa!',
})

-- Auto-save when changing buffer
autocmd('BufLeave', {
  command = 'silent! wa!',
})

-- Add shebang to new Python files
augroup('Shebang', { clear = true })
autocmd('BufNewFile', {
  group = 'Shebang',
  pattern = '*.py',
  command = '0put = \"#!/usr/bin/env python\" | put = \"# encoding: UTF-8\" | $',
})

-- Create directory if it doesn't exist when writing
autocmd('BufWritePre', {
  pattern = '*',
  callback = function()
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- Format Ruby files with RuboCop when the project root opts in
autocmd('BufWritePost', {
  group = augroup('RubyFormat', { clear = true }),
  pattern = { '*.rb', '*.ruby', '*.rake', 'Gemfile', 'Rakefile' },
  callback = function(args)
    require('config.ruby_format').format_buffer(args.buf)
  end,
})

-- Filetype-specific indentation
local function set_indent(ft, size)
  autocmd('BufNewFile', {
    pattern = ft,
    callback = function()
      vim.opt.tabstop = size
      vim.opt.shiftwidth = size
      vim.opt.softtabstop = size
    end,
  })
  autocmd('BufRead', {
    pattern = ft,
    callback = function()
      vim.opt.tabstop = size
      vim.opt.shiftwidth = size
      vim.opt.softtabstop = size
    end,
  })
end

-- Python: 4 spaces
set_indent('*.py', 4)

-- Ruby/Ruby on Rails: 2 spaces
set_indent('*.rb', 2)
set_indent('*.ruby', 2)

-- SASS/SCSS: 2 spaces
set_indent('*.sass', 2)
set_indent('*.scss', 2)

-- YAML: 2 spaces
set_indent('*.yml', 2)
set_indent('*.yaml', 2)

-- HAML: 2 spaces
set_indent('*.haml', 2)

-- ERB/EJS: 4 spaces
set_indent('*.erb', 4)

-- JavaScript: 2 spaces
set_indent('*.js', 2)

-- TypeScript: 2 spaces
set_indent('*.ts', 2)
set_indent('*.tsx', 2)

-- GUI (Neovide) specific commands
if vim.fn.has('gui_running') == 1 then
  vim.g.neovide_input_use_logo = 1
end

-- Quickfix buffer special handling
autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    -- CR already restored in keymaps.lua
  end,
})

-- Jquery/Underscore syntax detection
autocmd('BufReadPre', {
  pattern = '*.js',
  callback = function()
    vim.b.javascript_lib_use_jquery = 1
    vim.b.javascript_lib_use_underscore = 1
  end,
})
