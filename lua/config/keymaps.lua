local keymap = vim.keymap.set
local noremap = { noremap = true }
local silent = { silent = true }
local silent_noremap = { noremap = true, silent = true }

-- Utility for multimode mappings
local function noremap_all(key, cmd)
  keymap({ 'n', 'v' }, key, cmd, noremap)
end

-- Basic remapping
keymap('n', ';', ':', noremap) -- Save pinky from shift

-- Splitjoin mappings
keymap('n', '<leader>V', ':SplitjoinJoin<CR>', silent_noremap)
keymap('n', '<leader>v', ':SplitjoinSplit<CR>', silent_noremap)

-- JavaScript
keymap('n', '<leader>js', ':!eslint --fix %<CR>', silent_noremap)

-- RSpec
keymap('n', '<leader>rf', ':w<CR>:RunItermSpec<CR>', silent_noremap)
keymap('n', '<leader>rc', ':w<CR>:RunItermSpecLine<CR>', silent_noremap)

-- Switch (toggle between patterns)
keymap('n', '<leader>s', ':Switch<CR>', silent_noremap)

-- XML Tidy
keymap('v', '<leader>h', ':!tidy -q -i -xml --force-output 1 --char-encoding utf8<CR>', silent_noremap)
keymap('n', '<leader>h', ':!tidy -q -i -xml --force-output 1 --char-encoding utf8<CR>', silent_noremap)

-- Telescope fuzzy finder
local function telescope_find_files()
  require('telescope.builtin').find_files()
end
local function telescope_oldfiles()
  require('telescope.builtin').oldfiles()
end
local function telescope_live_grep()
  require('telescope.builtin').live_grep()
end
local function telescope_grep_string()
  require('telescope.builtin').grep_string()
end
local function telescope_current_buffer()
  require('telescope.builtin').current_buffer_fuzzy_find()
end

keymap('n', '<C-p>', telescope_find_files, silent_noremap)
keymap('n', '<leader>o', telescope_find_files, silent_noremap) -- Backup mapping
keymap('n', '<leader>m', telescope_oldfiles, silent_noremap) -- MRU
keymap('n', '<leader>l', telescope_current_buffer, silent_noremap)
keymap('n', '\\', telescope_grep_string, silent_noremap) -- grep word under cursor
keymap('n', 'K', telescope_grep_string, silent_noremap) -- grep word under cursor

-- neo-tree file browser
keymap('n', '<C-n>', ':Neotree toggle<CR>', silent_noremap)

-- Undo tree
keymap('n', '<leader>g', ':UndotreeToggle<CR>', silent_noremap)

-- YAML path copy (macOS)
if vim.fn.has('mac') == 1 or vim.fn.has('gui_macvim') == 1 then
  keymap('n', '<leader>cy', ':YamlGetFullPath<CR>', silent_noremap)
end

-- Force Y to yank (some plugins override)
keymap('n', 'Y', 'Y', noremap)

-- EasyAlign
keymap('v', '<leader><SPACE>', '<Plug>(EasyAlign)', {})

-- Close all buffers
keymap('n', '<leader>bd', ':bufdo bdelete<CR>', silent_noremap)

-- Disable ex mode
keymap('n', 'Q', '<Nop>', noremap)

-- Foldlevel shortcuts
keymap('n', '<leader>f1', ':set foldlevel=1<CR>', silent_noremap)
keymap('n', '<leader>f2', ':set foldlevel=2<CR>', silent_noremap)
keymap('n', '<leader>f3', ':set foldlevel=3<CR>', silent_noremap)
keymap('n', '<leader>f4', ':set foldlevel=4<CR>', silent_noremap)
keymap('n', '<leader>f5', ':set foldlevel=5<CR>', silent_noremap)

-- Paste behavior
keymap('x', 'p', '"_dP', noremap) -- Paste without overwriting

-- Disable middle mouse paste
keymap('n', '<MiddleMouse>', '<LeftMouse>', noremap)

-- Backspace in normal mode
keymap('n', '<Backspace>', 'd<Left>', noremap)

-- Faster scrolling
keymap('n', '<C-e>', '3<C-e>', noremap)
keymap('n', '<C-y>', '3<C-y>', noremap)

-- Quickfix navigation
keymap('n', '<leader>qn', ':cnext<CR>', silent_noremap)
keymap('n', '<leader>qp', ':cprevious<CR>', silent_noremap)

-- Window navigation
keymap('n', '<Tab>', '<C-w>w', silent_noremap)
keymap('n', '<S-Tab>', '<C-w>W', silent_noremap)

-- Alt key window navigation (macOS special keys)
keymap('n', '∆', '<C-w>j', noremap) -- Option+j
keymap('n', '˚', '<C-w>k', noremap) -- Option+k
keymap('n', '¬', '<C-w>l', noremap) -- Option+l
keymap('n', '˙', '<C-w>h', noremap) -- Option+h

-- Indent in normal mode
keymap('n', '<C-l>', '>>', noremap)
keymap('n', '<C-h>', '<<', noremap)

-- Line operations
keymap('n', '<C-X>', 'Ydd', noremap) -- Cut line
keymap('n', '<S-v>', 'g^v$', noremap) -- Select line excluding EOL

-- Tab behavior in visual mode
keymap('v', '<Tab>', '>gv', noremap)
keymap('v', '<S-Tab>', '<gv', noremap)

-- Buffer navigation
keymap('n', '<C-Tab>', ':bnext<CR>', silent_noremap)
keymap('n', '<C-S-Tab>', ':bprevious<CR>', silent_noremap)

-- Insert mode cursor movement
keymap('i', '<C-l>', '<Right>', noremap)
keymap('i', '<C-k>', '<Up>', noremap)
keymap('i', '<C-j>', '<Down>', noremap)
keymap('i', '<C-h>', '<Left>', noremap)

-- Insert/normal mode line wrapping
keymap('i', '<Down>', '<C-o>gj', noremap)
keymap('i', '<Up>', '<C-o>gk', noremap)

-- Quickfix with CR
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    keymap('n', '<CR>', '<CR>', { buffer = true })
  end,
})

-- Restore CR to newline in normal mode
keymap('n', '<CR>', 'o<Backspace><Esc>', noremap)

-- Visual mode tweaks
keymap('v', '$', '$<left>', noremap) -- $ doesn't select EOL
keymap('v', 'w', 'e', noremap) -- w behaves like e in visual

-- * search without jumping
keymap('n', '*', '"syiw<Esc>:let @/ = @s<CR>', silent_noremap)

-- Grep with leader-backslash (override above \)
-- Already mapped above via Telescope

-- Copy file paths (macOS)
if vim.fn.has('mac') == 1 or vim.fn.has('gui_macvim') == 1 then
  keymap('n', '<leader>cr', ':let @*=expand("%")<CR>', silent_noremap) -- relative path
  keymap('n', '<leader>cl', ':let @*=expand("%:p")<CR>', silent_noremap) -- absolute path
end

-- Indent 2/4 spaces
keymap('n', '<leader>i4', function()
  vim.notify('Indenting with 4 spaces', vim.log.levels.INFO)
  vim.opt.shiftwidth = 4
  vim.opt.tabstop = 4
  vim.opt.softtabstop = 4
end, silent_noremap)
keymap('n', '<leader>i2', function()
  vim.notify('Indenting with 2 spaces', vim.log.levels.INFO)
  vim.opt.shiftwidth = 2
  vim.opt.tabstop = 2
  vim.opt.softtabstop = 2
end, silent_noremap)

-- Rubocop
keymap('n', '<leader>rub', function()
  vim.cmd('!rubocop -A %')
end, silent_noremap)

-- Copy current ruby file
keymap('n', '<leader>crub', function()
  vim.cmd('!ruby /Users/grillermo/c/tandem/tandem-scripts/utils/copy_to_clipboard.rb %')
end, silent_noremap)

-- Save shortcuts (macOS)
if vim.fn.has('gui_running') == 1 then
  keymap('n', '<D-s>', ':update!<CR>', silent_noremap)
  keymap('n', '<D-c>', '<C-c>', noremap)
  keymap('n', '<D-v>', '<C-v>', noremap)
  keymap('i', '<D-v>', '<C-v>', noremap)
  keymap('v', '<D-c>', '"+y<CR>', noremap)
end

-- Windows/other systems save
keymap('n', '<C-s>', ':update!<CR>', silent_noremap)

-- Command mode navigation
keymap('c', '<C-A>', '<Home>', noremap)

-- Line move functions (C-k/C-j)
local function move_line_up()
  local line = vim.fn.line('.')
  local move_arg
  if line - vim.v.count1 - 1 < 0 then
    move_arg = '0'
  else
    move_arg = '.-' .. (vim.v.count1 + 1)
  end
  vim.cmd('silent! move ' .. move_arg)
  vim.cmd('normal! ' .. vim.fn.virtcol('.') .. '|')
end

local function move_line_down()
  local line = vim.fn.line('.')
  local move_arg
  if line + vim.v.count1 > vim.fn.line('$') then
    move_arg = '$'
  else
    move_arg = '.+' .. vim.v.count1
  end
  vim.cmd('silent! move ' .. move_arg)
  vim.cmd('normal! ' .. vim.fn.virtcol('.') .. '|')
end

keymap('n', '<C-k>', move_line_up, silent_noremap)
keymap('n', '<C-j>', move_line_down, silent_noremap)
