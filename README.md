# Neovim Configuration

Personal Neovim setup focused on fast navigation, language tooling (Ruby/Python/TypeScript), and keyboard-first editing.

## Overview

- Plugin manager: `lazy.nvim`
- Leader key: `,`
- Main colorscheme: `gruvbox`
- Core stack:
  - LSP: `nvim-lspconfig` + `ruby_lsp` / `pyright` / `ts_ls`
  - Completion: `nvim-cmp` + `LuaSnip`
  - Navigation: `snacks.nvim` explorer + `telescope.nvim`
  - UI: `lightline`, `gitgutter`, `colorizer`

## Architecture

### Startup flow

1. [`init.lua`](./init.lua) sets `mapleader` and `maplocalleader`.
2. Loads base config:
   - [`lua/config/options.lua`](./lua/config/options.lua)
   - [`lua/config/autocmds.lua`](./lua/config/autocmds.lua)
3. Bootstraps `lazy.nvim` if missing.
4. Calls `require('lazy').setup('plugins', ...)` to load plugin specs from `lua/plugins/`.
5. Loads keymaps last via [`lua/config/keymaps.lua`](./lua/config/keymaps.lua).
6. Applies `gruvbox` colorscheme.

### Directory structure

```text
.
├── init.lua
├── lazy-lock.json
└── lua
    ├── config
    │   ├── autocmds.lua
    │   ├── keymaps.lua
    │   └── options.lua
    ├── completion.lua
    ├── lsp_config.lua
    ├── initialize.lua
    ├── ts_setup.lua
    └── plugins
        ├── editing.lua
        ├── git.lua
        ├── javascript.lua
        ├── lsp.lua
        ├── misc.lua
        ├── navigation.lua
        ├── ruby.lua
        ├── search.lua
        └── ui.lua
```

## Features

### Core editor behavior

From [`lua/config/options.lua`](./lua/config/options.lua):

- Line numbers enabled, wrapping disabled
- Persistent undo (`undofile`) at `~/.vim/undodir`
- Case-insensitive search with smart-case
- 4-space default indentation (language overrides via autocmds)
- `colorcolumn=119`
- Clipboard uses `unnamed`
- Syntax folding enabled (`foldmethod=syntax`)

From [`lua/config/autocmds.lua`](./lua/config/autocmds.lua):

- Auto-save on `FocusLost` and `BufLeave`
- Auto-create missing directories on write
- Filetype indentation overrides:
  - 2 spaces: Ruby, JS/TS, YAML, SCSS/SASS, HAML
  - 4 spaces: Python, ERB
- Python new-file shebang insertion

### Plugin organization

#### Navigation (`lua/plugins/navigation.lua`)

- `folke/snacks.nvim` as file explorer (NERDTree-like keybindings)
- `telescope.nvim` + `telescope-fzf-native.nvim` for fuzzy finding
- `vim-easymotion` for jump navigation
- `vim-lastplace` to restore cursor position

#### LSP and completion (`lua/plugins/lsp.lua`)

- `nvim-lspconfig` configured in [`lua/lsp_config.lua`](./lua/lsp_config.lua)
- `nvim-cmp` configured in [`lua/completion.lua`](./lua/completion.lua)
- `LuaSnip` snippet support
- Active servers:
  - `ruby_lsp` (via `~/.rbenv/shims/ruby-lsp`)
  - `pyright`
  - `ts_ls` (`typescript-language-server`)

#### Editing utilities (`lua/plugins/editing.lua`)

- Split/join transformations (`splitjoin.vim`)
- Toggle syntax/forms (`switch.vim`)
- Text objects and surround/comment tooling (`vim-surround`, `vim-commentary`, etc.)
- Quickfix open behavior enhancements (`QFEnter`)
- File operation commands (`vim-eunuch`)

#### Search (`lua/plugins/search.lua`)

- `ack.vim` configured to run `rg --vimgrep`
- `vim-ripgrep`
- `vim-easygrep` recursive grep support

#### UI (`lua/plugins/ui.lua`)

- `lightline.vim` statusline with Git branch and LSP status hooks
- `gruvbox` default theme
- `gitgutter` inline Git diff indicators
- `colorizer` + indent guides

#### Language-specific

- JavaScript/TypeScript syntax/indent plugins in [`lua/plugins/javascript.lua`](./lua/plugins/javascript.lua)
- Ruby-focused plugins in [`lua/plugins/ruby.lua`](./lua/plugins/ruby.lua) including RuboCop integration and iTerm RSpec runner

#### Misc (`lua/plugins/misc.lua`)

- `vim-wakatime`
- `editorconfig-vim`
- `undotree`
- `vim-pandoc` + syntax
- `claudecode.nvim` integrations and keymaps

## Keymaps (high-signal)

From [`lua/config/keymaps.lua`](./lua/config/keymaps.lua):

- Files/search:
  - `<C-p>` or `<leader>o`: find files (Telescope)
  - `<C-S-p>`: find files, including `.gitignore`-ignored files (Telescope)
  - `<leader>m`: recent files
  - `<leader>l`: fuzzy find in current buffer
  - `K` and `\\`: grep word under cursor (Telescope)
  - `<C-n>`: open `Snacks.explorer()`
- LSP (on attach):
  - `gd`, `gr`, `K`, `<leader>ca`, `<leader>rn`, `[d`, `]d`
- Testing/linting:
  - `<leader>rf`: run RSpec file (iTerm)
  - `<leader>rc`: run RSpec line (iTerm)
  - `<leader>js`: run `eslint --fix %`
  - `<leader>rub`: run `rubocop -A %`
- Editing:
  - `<leader>v` / `<leader>V`: split/join
  - `<leader>g`: toggle undo tree
  - `<leader>i2` / `<leader>i4`: switch indent width

## External dependencies

This config expects several tools to be installed on your machine:

- `git` (for plugin bootstrap)
- `rg` (ripgrep) for search + explorer integration
- `make` (for `telescope-fzf-native` and `LuaSnip` build step)
- Language servers:
  - `ruby-lsp` (through rbenv shim path)
  - `pyright-langserver`
  - `typescript-language-server`
- Optional command integrations used by keymaps/plugins:
  - `eslint`
  - `rubocop`
  - `tidy`

## Lockfile

- [`lazy-lock.json`](./lazy-lock.json) pins plugin versions for reproducible installs.

## Notes

- [`lua/initialize.lua`](./lua/initialize.lua) and [`lua/ts_setup.lua`](./lua/ts_setup.lua) are present but not loaded by `init.lua` (currently inactive in startup path).
