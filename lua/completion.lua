local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  preselect = cmp.PreselectMode.Item,
  mapping = cmp.mapping.preset.insert({
    -- Tab: accept selected (or first) completion, like VSCode
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm({ select = true })
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- Shift-Tab: previous item or snippet jump back
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),

    -- Enter: accept selected completion
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- Ctrl-Space: trigger completion manually
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Ctrl-e: dismiss completion menu
    ['<C-e>'] = cmp.mapping.abort(),

    -- Arrow keys to browse
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Up>'] = cmp.mapping.select_prev_item(),

    -- Scroll docs in completion detail window
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  }, {
    { name = 'buffer', keyword_length = 3 },
  }),
  formatting = {
    format = function(entry, vim_item)
      local source_names = {
        nvim_lsp = '[LSP]',
        luasnip = '[Snip]',
        buffer = '[Buf]',
        path = '[Path]',
      }
      vim_item.menu = source_names[entry.source.name] or ''
      return vim_item
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
})
