return {
  -- Statusline
  {
    'itchyny/lightline.vim',
    config = function()
      vim.cmd([[
        function! LightlineProjectRoot()
          return fnamemodify(getcwd(), ':t')
        endfunction

        function! LightlinePromptSeparator()
          return FugitiveHead() ==# '' ? '' : '⮀'
        endfunction
      ]])

      vim.g.lightline = {
        colorscheme = 'prompt',
        separator = { left = '', right = '' },
        subseparator = { left = '', right = '' },
        active = {
          left = {
            { 'project_root' },
            { 'prompt_separator' },
            { 'gitbranch' },
            { 'mode', 'paste' },
            { 'readonly', 'relativepath', 'modified' },
            { 'lsp_status' },
          },
          right = {
            { 'filetype' },
            { 'percent', 'line', 'column', 'encoding' },
          },
        },
        component_function = {
          gitbranch = 'FugitiveHead',
          project_root = 'LightlineProjectRoot',
          prompt_separator = 'LightlinePromptSeparator',
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
