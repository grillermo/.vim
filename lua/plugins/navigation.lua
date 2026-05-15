return {
  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      telescope.setup {
        defaults = {
          mappings = {
            i = {
              ['<C-c>'] = actions.close,
              ['<Esc>'] = actions.close,
            },
          },
          file_ignore_patterns = { 'node_modules', '.git', '.ruby-lsp' },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      }
    end,
  },

  -- File explorer (neo-tree)
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('neo-tree').setup {
        close_if_last_window = false,
        popup_border_style = 'solid',
        enable_git_status = true,
        enable_diagnostics = true,
        default_component_configs = {
          indent = {
            indent_size = 2,
            padding = 1,
            with_markers = true,
            indent_marker = '│',
            last_indent_marker = '└',
            highlight = 'NeoTreeIndentMarker',
            with_expanders = nil,
            expander_collapsed = '',
            expander_expanded = '',
            expander_highlight = 'NeoTreeExpander',
          },
          icon = {
            folder_closed = '▸',
            folder_open = '▾',
            folder_empty = '○',
            default = '',
          },
          modified = {
            symbol = '[+]',
            highlight = 'NeoTreeModified',
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = 'NeoTreeFileName',
          },
          git_status = {
            symbols = {
              added = '✓',
              deleted = '✕',
              modified = '●',
              renamed = '»',
              untracked = '?',
              ignored = '◌',
              unstaged = '◌',
              staged = '✓',
              conflict = '!',
            },
          },
        },
        window = {
          position = 'left',
          width = 60,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ['<space>'] = 'toggle_node',
            ['<2-LeftMouse>'] = 'open',
            ['<cr>'] = 'open',
            ['S'] = 'open_split',
            ['s'] = 'open_vsplit',
            ['C'] = 'close_node',
            ['z'] = 'close_all_nodes',
            ['a'] = { 'add', config = { show_path = 'none' } },
            ['A'] = { 'add_directory', config = { show_path = 'none' } },
            ['d'] = 'delete',
            ['r'] = 'rename',
            ['y'] = 'copy_to_clipboard',
            ['x'] = 'cut_to_clipboard',
            ['p'] = 'paste_from_clipboard',
            ['c'] = 'copy',
            ['m'] = 'move',
            ['q'] = 'close_window',
            ['R'] = 'refresh',
            ['?'] = 'show_help',
            ['<'] = 'prev_source',
            ['>'] = 'next_source',
            ['i'] = 'show_file_details',
          },
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = true,
          },
          follow_current_file = {
            enabled = false,
          },
          group_empty_dirs = false,
          use_libuv_file_watcher = false,
        },
        buffers = {
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
        },
        git_status = {
          window = {
            position = 'float',
          },
        },
        document_symbols = {
          follow_cursor = false,
          client_filters = 'scopes',
          renderers = {
            document_symbols = {
              filter_kind = {
                default = nil,
                exclude = {},
              },
            },
          },
        },
      }
    end,
  },

  -- Easy motion (search/jump)
  'easymotion/vim-easymotion',

  -- Remember last cursor position
  'farmergreg/vim-lastplace',
}
