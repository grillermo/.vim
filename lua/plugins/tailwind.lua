return {
  {
    'laytan/tailwind-sorter.nvim',
    dependencies = {
      {
        'nvim-treesitter/nvim-treesitter',
        branch = 'master',
        build = ':TSUpdate',
        config = function()
          require('nvim-treesitter.configs').setup({
            ensure_installed = {
              'embedded_template',
              'html',
            },
          })
        end,
      },
      'nvim-lua/plenary.nvim',
    },
    build = 'cd formatter && npm ci && npm run build',
    config = function()
      local tsutil = require('tailwind-sorter.tsutil')
      local util = require('tailwind-sorter.util')
      local parsers = require('nvim-treesitter.parsers')

      -- Normalize Neovim 0.11 capture lists and add ERB content-node support.
      local function capture_nodes(capture)
        if type(capture) == 'table' then
          return capture
        end

        return { capture }
      end

      local function capture_offset(query, pattern, id)
        if not query.info.patterns[pattern] then
          return nil
        end

        for _, pred in pairs(query.info.patterns[pattern]) do
          if pred[2] == id and pred[1] == 'offset!' then
            return {
              start_row = tonumber(pred[3]),
              start_col = tonumber(pred[4]),
              end_row = tonumber(pred[5]),
              end_col = tonumber(pred[6]),
            }
          end
        end

        return nil
      end

      local function add_class_attribute_matches(matches, bufnr, node)
        local text = vim.treesitter.get_node_text(node, bufnr)

        for _, quote in ipairs({ '"', "'" }) do
          local init = 1
          local pattern = 'class%s*=%s*' .. quote .. '([^' .. quote .. ']*)' .. quote

          while true do
            local start_pos, end_pos = text:find(pattern, init)

            if not start_pos then
              break
            end

            local value_start = text:find(quote, start_pos, true) + 1
            local value_end = end_pos - 1

            table.insert(matches, {
              node = node,
              buf = bufnr,
              offset = {
                start_col = value_start,
                end_col = value_end,
              },
            })

            init = end_pos + 1
          end
        end
      end

      local function add_embedded_template_matches(matches, bufnr, node)
        if node:type() == 'content' then
          add_class_attribute_matches(matches, bufnr, node)
        end

        for child in node:iter_children() do
          add_embedded_template_matches(matches, bufnr, child)
        end
      end

      local function match_position(match)
        local row, col = match.node:range()
        local offset = match.offset and match.offset.start_col or 0

        return row, col + offset
      end

      local function node_range(bufnr, node)
        local start_row, start_col, end_row, end_col = node:range()
        local line_count = vim.api.nvim_buf_line_count(bufnr)

        if end_row >= line_count then
          end_row = line_count - 1
          end_col = #vim.api.nvim_buf_get_lines(bufnr, end_row, end_row + 1, false)[1]
        end

        return start_row, start_col, end_row, end_col
      end

      local function buffer_position_for_text_index(start_row, start_col, text, index)
        local prefix = text:sub(1, index - 1)
        local lines = vim.split(prefix, '\n', { plain = true })

        if #lines == 1 then
          return start_row, start_col + #lines[1]
        end

        return start_row + #lines - 1, #lines[#lines]
      end

      tsutil.get_query_matches = function(buf)
        local bufnr = buf or vim.api.nvim_get_current_buf()
        local parser = parsers.get_parser(bufnr)
        local matches = {}

        if not parser then
          return matches
        end

        parser:parse()

        parser:for_each_tree(function(tree, lang_tree)
          if lang_tree:lang() == 'embedded_template' then
            add_embedded_template_matches(matches, bufnr, tree:root())
          end

          local query = tsutil.get_query(lang_tree:lang(), 'tailwind')

          if not query then
            return
          end

          for pattern, match, _ in query:iter_matches(tree:root(), bufnr, 0, -1) do
            if match then
              for id, capture in pairs(match) do
                if query.captures[id] == 'tailwind' then
                  for _, node in ipairs(capture_nodes(capture)) do
                    table.insert(matches, {
                      node = node,
                      buf = bufnr,
                      offset = capture_offset(query, pattern, id),
                    })
                  end
                end
              end
            end
          end
        end)

        table.sort(matches, function(left, right)
          local left_row, left_col = match_position(left)
          local right_row, right_col = match_position(right)

          if left_row == right_row then
            return left_col < right_col
          end

          return left_row < right_row
        end)

        return matches
      end

      tsutil.put_new_node_text = function(match, text)
        local original = vim.treesitter.get_node_text(match.node, match.buf)

        if match.offset then
          if tsutil.get_match_text(match) == text then
            return
          end

          local start_row, start_col = match.node:range()
          local replace_start_row, replace_start_col =
            buffer_position_for_text_index(start_row, start_col, original, match.offset.start_col)
          local replace_end_row, replace_end_col =
            buffer_position_for_text_index(start_row, start_col, original, match.offset.end_col + 1)

          vim.api.nvim_buf_set_text(
            match.buf,
            replace_start_row,
            replace_start_col,
            replace_end_row,
            replace_end_col,
            util.split_lines(text)
          )

          return
        end

        text = tsutil.replace_match_text(match, text)

        if original == text then
          return
        end

        local lines = util.split_lines(text)
        local start_row, start_col, end_row, end_col = node_range(match.buf, match.node)

        vim.api.nvim_buf_set_text(match.buf, start_row, start_col, end_row, end_col, lines)
      end

      local on_save_pattern = {
        '*.html',
        '*.erb',
        '*.html.erb',
        '*.js',
        '*.jsx',
        '*.tsx',
        '*.twig',
        '*.hbs',
        '*.php',
        '*.heex',
        '*.astro',
      }

      local tailwind_sorter = require('tailwind-sorter')

      tailwind_sorter.setup({
        -- Guarded autocmd below avoids double-runs when *.html.erb also matches *.erb.
        on_save_enabled = false,
        on_save_pattern = on_save_pattern,
        trim_spaces = true,
      })

      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('tailwind-sorter-on-save', { clear = true }),
        pattern = on_save_pattern,
        callback = function(args)
          if vim.b[args.buf].tailwind_sorter_sorting then
            return
          end

          vim.b[args.buf].tailwind_sorter_sorting = true

          local ok, err = pcall(tailwind_sorter.sort, args.buf)

          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(args.buf) then
              vim.b[args.buf].tailwind_sorter_sorting = nil
            end
          end)

          if not ok then
            error(err)
          end
        end,
      })
    end,
  },
}
