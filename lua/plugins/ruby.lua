return {
  -- Rubocop integration
  {
    'ngmy/vim-rubocop',
  },

  -- Toggle between hash syntaxes and block styles
  'jgdavey/vim-blockle',

  -- Ruby text objects (e.g., ar, ir for Ruby blocks)
  {
    'rhysd/vim-textobj-ruby',
    dependencies = { 'kana/vim-textobj-user' },
  },

  -- Run RSpec from Vim via iTerm
  'grillermo/vim-iterm-rspec',

  -- Python code folding (also works for Ruby)
  'tmhedberg/SimpylFold',
}
