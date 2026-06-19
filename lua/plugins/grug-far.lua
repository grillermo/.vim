return {
  {
    'MagicDuck/grug-far.nvim',
    cmd = { 'GrugFar', 'GrugFarWithin' },
    opts = {},
    keys = {
      { '<leader>sr', '<cmd>GrugFar<cr>', desc = 'Search and replace' },
      { '<leader>sR', '<cmd>GrugFarWithin<cr>', mode = { 'n', 'x' }, desc = 'Search and replace within range' },
    },
  },
}
