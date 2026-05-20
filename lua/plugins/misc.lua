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

  -- Claude Code integration
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  }
}
