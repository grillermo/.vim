-- Find the path to your rbenv ruby-lsp binary
-- You can verify this path by running `which ruby-lsp` in your terminal
local ruby_lsp_binary = "/Users/grillermo/.rbenv/shims/ruby-lsp"

vim.lsp.config('ruby_lsp', {
  -- Use the direct shim path instead of "bundle exec"
  cmd = { ruby_lsp_binary },
  init_options = {
    enabledFeatures = {
      "completion",
      "definition",
      "hover",
      "diagnostics",
      "documentSymbols",
    },
    enabledAddons = {
      "ruby-lsp-rails",
      "ruby-lsp-rspec"
    },
    featuresConfiguration = {
      inlayHint = {
        enable = true
      }
    },
    -- This tells ruby-lsp to use its own isolated bundle for add-ons
    -- rather than your project's Gemfile
    -- bundleGemfile = os.getenv("HOME") .. "/.config/ruby-lsp/Gemfile"
  },
})

vim.lsp.enable('ruby_lsp')

-- Use Tab to navigate the completion menu
vim.keymap.set('i', '<Tab>', function()
  return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true })

-- Use Shift-Tab to go backwards
vim.keymap.set('i', '<S-Tab>', function()
  return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true })

vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show RSpec Documentation" })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Jump to Matcher/Shared Example" })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "RSpec Refactor/Fixes" })
