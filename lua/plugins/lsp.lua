return {
  -- LSP configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      require('lsp_config')
    end,
  },

  -- Completion engine
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require('completion')
    end,
  },

  -- Snippet engine
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
  },

  -- Snippet completion source
  'saadparwaiz1/cmp_luasnip',

  -- LSP completion source
  'hrsh7th/cmp-nvim-lsp',

  -- Buffer completion source
  'hrsh7th/cmp-buffer',

  -- Path completion source
  'hrsh7th/cmp-path',
}
