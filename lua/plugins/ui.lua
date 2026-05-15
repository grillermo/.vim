return {
  -- Statusline
  {
    'itchyny/lightline.vim',
    config = function()
      vim.g.lightline = {
        colorscheme = 'wombat',
        active = {
          left = {
            { 'mode', 'paste' },
            { 'gitbranch', 'readonly', 'relativepath', 'modified' },
            { 'lsp_status' },
          },
          right = {
            { 'filetype' },
            { 'percent', 'line', 'column', 'encoding' },
          },
        },
        component_function = {
          gitbranch = 'FugitiveHead',
          lsp_status = 'LspStatus',
        },
        inactive = {
          left = { { 'absolutepath' } },
          right = { {} },
        },
      }
    end,
  },

  -- Colorscheme (gruvbox)
  {
    'morhetz/gruvbox',
    priority = 1000,
  },

  -- Color highlighting (e.g., #ff0000 shows as red)
  'lilydjwg/colorizer',

  -- Indent guides
  {
    'nathanaelkane/vim-indent-guides',
    config = function()
      vim.g.indent_guides_start_level = 2
      vim.g.indent_guides_guide_size = 1
    end,
  },

  -- Git gutter (show git diff in gutter)
  'airblade/vim-gitgutter',
}
