return {
  -- File explorer (nerdtree)
  {
    'preservim/nerdtree',
    lazy = false,
    init = function()
      vim.g.NERDTreeShowHidden = 1
      vim.g.NERDTreeQuitOnOpen = 0
      vim.g.NERDTreeAutoDeleteBuffer = 1
      vim.g.NERDTreeMinimalUI = 1
    end,
    config = function()
      -- 'C' in snacks changed the explorer root AND cwd together; NERDTree's
      -- default 'C' only changes the tree root, so replicate the combo here.
      vim.cmd([[
        function! NerdtreeRootAndChdir(node) abort
          call b:NERDTree.changeRoot(a:node)
          call a:node.path.changeToDir()
        endfunction
      ]])
      vim.fn.NERDTreeAddKeyMap {
        key = 'C',
        scope = 'Node',
        callback = 'NerdtreeRootAndChdir',
        override = 1,
      }

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'nerdtree',
        callback = function(args)
          local buf = args.buf
          local function alias(lhs, rhs)
            vim.keymap.set('n', lhs, rhs, { buffer = buf, remap = true, nowait = true })
          end
          -- muscle memory from the snacks explorer setup
          alias('l', 'o') -- open/toggle (snacks: confirm)
          alias('h', 'x') -- close dir (snacks: explorer_close)
          alias('<BS>', 'u') -- up a directory (snacks: explorer_up)
          alias('<C-n>', 'q') -- close the tree (snacks: cancel)
          vim.keymap.set('n', '<Tab>', '<C-w>l', { buffer = buf, nowait = true })
        end,
      })
    end,
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      local function case_insensitive_substr_matcher()
        local sorters = require('telescope.sorters')
        local utils = require('telescope.utils')

        local function search_terms(prompt)
          return utils.max_split(prompt:lower(), '%s')
        end

        return sorters.Sorter:new {
          highlighter = function(_, prompt, display)
            local highlights = {}
            local lower_display = display:lower()

            for _, word in pairs(search_terms(prompt)) do
              local hl_start, hl_end = lower_display:find(word, 1, true)
              if hl_start then
                table.insert(highlights, { start = hl_start, finish = hl_end })
              end
            end

            return highlights
          end,

          scoring_function = function(_, prompt, _, entry)
            if #prompt == 0 then
              return 1
            end

            local display = entry.ordinal:lower()
            local matched = 0
            local total_search_terms = 0

            for _, word in pairs(search_terms(prompt)) do
              total_search_terms = total_search_terms + 1
              if display:find(word, 1, true) then
                matched = matched + 1
              end
            end

            return matched == total_search_terms and (entry.index or 1) or -1
          end,
        }
      end

      telescope.setup {
        defaults = {
          layout_config = {
            width = 0.92,
            height = 0.92,
          },
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
          },
          mappings = {
            i = {
              ['<C-c>'] = actions.close,
              ['<Esc>'] = actions.close,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-s>'] = actions.select_horizontal,
            },
            n = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
            },
          },
          file_ignore_patterns = { 'node_modules', '.git', '.ruby-lsp' },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
          live_grep = {
            sorter = case_insensitive_substr_matcher(),
          },
          grep_string = {
            sorter = case_insensitive_substr_matcher(),
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case',
          },
        },
      }

      telescope.load_extension('fzf')
    end,
  },

  -- Easy motion (search/jump)
  'easymotion/vim-easymotion',

  -- Remember last cursor position
  'farmergreg/vim-lastplace',
}
