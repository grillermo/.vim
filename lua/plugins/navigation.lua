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
              ignored = false,
              layout = {
                preset = 'sidebar',
                preview = false,
              },
              actions = {
                nerdtree_root = nerdtree_root,
                nerdtree_menu = nerdtree_menu,
              },
              win = {
                list = {
                  keys = {
                    ['<CR>'] = 'confirm',
                    ['o'] = 'confirm',
                    ['l'] = 'confirm',
                    ['h'] = 'explorer_close',
                    ['x'] = 'explorer_close',
                    ['X'] = 'explorer_close_all',
                    ['u'] = 'explorer_up',
                    ['<BS>'] = 'explorer_up',
                    ['i'] = 'edit_split',
                    ['s'] = 'edit_vsplit',
                    ['t'] = 'tab',
                    ['r'] = 'explorer_update',
                    ['R'] = 'explorer_update',
                    ['m'] = 'nerdtree_menu',
                    ['C'] = 'nerdtree_root',
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

      telescope.setup {
        defaults = {
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
