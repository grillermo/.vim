return {
  -- Ack.vim (search using ag/rg)
  {
    'mileszs/ack.vim',
    config = function()
      vim.g.ackprg = 'rg --vimgrep --smart-case --sort=path'
      vim.g.ack_use_cword_for_empty_search = 1
      vim.cmd('cnoreabbrev Ack Ack!')
    end,
  },

  -- Ripgrep integration
  {
    'jremmen/vim-ripgrep',
    config = function()
      vim.g.rg_command = 'rg --vimgrep --smart-case --sort=path'
    end,
  },

  -- Easy grep (search and replace)
  {
    'dkprice/vim-easygrep',
    config = function()
      vim.g.EasyGrepRecursive = 1
    end,
  },
}
