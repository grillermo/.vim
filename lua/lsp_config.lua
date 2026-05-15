-- LSP capabilities from nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Ruby (ruby-lsp via rbenv)
vim.lsp.config('ruby_lsp', {
  cmd = { os.getenv("HOME") .. "/.rbenv/shims/ruby-lsp" },
  capabilities = capabilities,
  init_options = {
    enabledFeatures = {
      "completion",
      "definition",
      "hover",
      "diagnostics",
      "documentSymbols",
      "formatting",
      "codeActions",
    },
  },
})

-- Python (pyright)
vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  capabilities = capabilities,
})

-- TypeScript / JavaScript
vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  capabilities = capabilities,
})

vim.lsp.enable({ 'ruby_lsp', 'pyright', 'ts_ls' })

-- Keymaps (activate when LSP attaches)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    -- Refresh lightline to show LSP status
    vim.cmd('call lightline#update()')
  end,
})
