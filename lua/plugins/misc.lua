return {
  -- Time tracking
  'wakatime/vim-wakatime',

  -- EditorConfig support
  'editorconfig/editorconfig-vim',

  -- Undo tree visualization
  {
    'mbbill/undotree',
    config = function()
      -- Configured via keymaps.lua
    end,
  },

  -- Pandoc integration
  {
    'vim-pandoc/vim-pandoc',
    dependencies = { 'vim-pandoc/vim-pandoc-syntax' },
  },

  -- Pandoc syntax highlighting
  'vim-pandoc/vim-pandoc-syntax',

  -- HAML syntax and indentation
  'tpope/vim-haml',

  -- Horizon colorscheme (alternative)
  'ntk148v/vim-horizon',

  -- Dune build system syntax
  'figitaki/vim-dune',

  -- YAML helper (path navigation)
  'lmeijvogel/vim-yaml-helper',
}
