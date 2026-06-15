return {
  -- Split/join lines (gS to split, gJ to join)
  {
    'AndrewRadev/splitjoin.vim',
    config = function()
      vim.g.splitjoin_split_mapping = ''
      vim.g.splitjoin_join_mapping = ''
      vim.g.splitjoin_ruby_curly_braces = 0
      vim.g.splitjoin_quiet = 1
      vim.g.splitjoin_ruby_hanging_args = 0
      vim.g.splitjoin_ruby_options_as_arguments = 1
    end,
  },

  -- Switch between different patterns (e.g., if/unless, true/false)
  {
    'AndrewRadev/switch.vim',
    config = function()
      vim.g.switch_custom_definitions = {
        {
          ['\\<\\(\\k\\+\\): '] = "\\1 => ",
        },
      }
    end,
  },

  -- Surround text with quotes, brackets, etc.
  'tpope/vim-surround',

  -- Comment/uncomment
  'tpope/vim-commentary',

  -- Auto-insert end/endif/etc.
  'tpope/vim-endwise',

  -- Enable repeat (.) with plugin maps
  'tpope/vim-repeat',

  -- Unimpaired mappings (e.g., [b, ]b for buffer nav)
  'tpope/vim-unimpaired',

  -- Easy alignment (e.g., align on = sign)
  {
    'junegunn/vim-easy-align',
    config = function()
      -- <leader><SPACE> in visual mode mapped in keymaps.lua
    end,
  },

  -- Delete trailing whitespace
  {
    'inkarkat/vim-DeleteTrailingWhitespace',
    dependencies = { 'inkarkat/vim-ingo-library' },
  },

  -- Navigate quickfix results with splits
  {
    'yssl/QFEnter',
    config = function()
      vim.g.qfenter_keymap = {}
      vim.g.qfenter_keymap.vopen = { '<C-v>' }
      vim.g.qfenter_keymap.hopen = { '<C-CR>', '<C-s>', '<C-x>' }
      vim.g.qfenter_keymap.topen = { '<C-t>' }
    end,
  },

  -- Indent object (text object for indentation level)
  'michaeljsmith/vim-indent-object',

  -- Text object user (dependency for custom text objects)
  'kana/vim-textobj-user',

  -- % matching for brackets, HTML tags, language keywords
  {
    'andymass/vim-matchup',
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = 'popup' }
    end,
  },

  -- Enhanced file operations (e.g., :Rename, :Delete, :Chmod)
  'tpope/vim-eunuch',
}
