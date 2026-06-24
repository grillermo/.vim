return {
  -- File explorer (snacks)
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = function()
      local function nerdtree_root(picker, item)
        if not item then
          return
        end
        local root = item.dir and item.file or vim.fs.dirname(item.file)
        picker:set_cwd(root)
        picker:find()
      end

      local function nerdtree_root_and_chdir(picker, item)
        nerdtree_root(picker, item)
        vim.api.nvim_set_current_dir(picker:cwd())
      end

      local function nerdtree_confirm(picker, item, action)
        if not item then
          return
        end
        if item.dir then
          if picker.input.filter.meta.searching then
            picker.input:set('', '')
            picker:set_cwd(item.file)
            picker:find()
          else
            require('snacks.explorer.tree'):toggle(item.file)
            picker:find()
          end
          return
        end
        Snacks.picker.actions.jump(picker, item, action)
      end

      local function nerdtree_menu(picker)
        local actions = {
          { label = 'Add', action = 'explorer_add' },
          { label = 'Delete', action = 'explorer_del' },
          { label = 'Rename', action = 'explorer_rename' },
          { label = 'Copy', action = 'explorer_copy' },
          { label = 'Move', action = 'explorer_move' },
          { label = 'Yank', action = 'explorer_yank' },
          { label = 'Paste', action = 'explorer_paste' },
          { label = 'Open Externally', action = 'explorer_open' },
          { label = 'Refresh', action = 'explorer_update' },
        }

        vim.ui.select(actions, {
          prompt = 'Explorer action',
          format_item = function(choice)
            return choice.label
          end,
        }, function(choice)
          if choice then
            picker:action(choice.action)
          end
        end)
      end

      return {
        explorer = {
          enabled = true,
          replace_netrw = true,
        },
        picker = {
          enabled = true,
          sources = {
            explorer = {
              cmd = 'rg',
              follow_file = false,
              hidden = true,
              ignored = true,
              sort = {
                fields = { 'score:desc', 'dir', '#file', '#text', 'idx' },
              },
              layout = {
                preset = 'sidebar',
                preview = false,
              },
              actions = {
                confirm = nerdtree_confirm,
                nerdtree_root = nerdtree_root,
                nerdtree_root_and_chdir = nerdtree_root_and_chdir,
                nerdtree_menu = nerdtree_menu,
              },
              win = {
                input = {
                  keys = {
                    ['<C-n>'] = 'cancel',
                  },
                },
                list = {
                  keys = {
                    ['<CR>'] = 'confirm',
                    ['<C-n>'] = 'cancel',
                    ['<Space>'] = 'select_and_next',
                    ['<S-Space>'] = 'select_and_prev',
                    ['<Tab>'] = {
                      function()
                        vim.api.nvim_feedkeys(
                          vim.api.nvim_replace_termcodes('<C-w>l', true, false, true),
                          'n',
                          false
                        )
                      end,
                      mode = { 'n', 'i' },
                    },
                    ['<S-Tab>'] = false,
                    ['o'] = 'confirm',
                    ['l'] = 'confirm',
                    ['h'] = 'explorer_close',
                    ['x'] = 'explorer_close',
                    ['X'] = 'explorer_close_all',
                    ['u'] = 'explorer_up',
                    ['U'] = 'explorer_up',
                    ['<BS>'] = 'explorer_up',
                    ['i'] = 'edit_split',
                    ['s'] = 'edit_vsplit',
                    ['t'] = 'tab',
                    ['r'] = 'explorer_update',
                    ['R'] = function(picker)
                      require('snacks.explorer.actions').update(picker, { refresh = true })
                    end,
                    ['m'] = 'nerdtree_menu',
                    ['C'] = 'nerdtree_root_and_chdir',
                    ['I'] = 'toggle_hidden',
                    ['q'] = 'cancel',
                  },
                },
              },
            },
          },
        },
      }
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
