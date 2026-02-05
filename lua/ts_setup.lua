-- ~/.config/nvim/lua/ts_setup.lua
local lspconfig = require("lspconfig")

require("typescript-tools").setup({
  settings = {
    -- spawn additional tsserver instance to calculate diagnostics on it
    separate_diagnostic_server = true,
    -- publish_diagnostic_on = "insert_leave",
    expose_as_code_action = "all",
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayFunctionParameterTypeHints = true,
    },
  },
})

-- Minimal cmp setup to make the LSP actually usable
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  })
})
