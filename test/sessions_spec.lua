package.loaded['config.sessions'] = nil

local sessions = require('config.sessions')

local tmp = vim.fn.tempname()
vim.fn.mkdir(tmp .. '/project-a', 'p')
vim.fn.mkdir(tmp .. '/project-b', 'p')

local original_cwd = vim.fn.getcwd()
local original_state = vim.env.XDG_STATE_HOME
vim.env.XDG_STATE_HOME = tmp .. '/state'

vim.cmd.cd(tmp .. '/project-a')
local project_a_session = sessions.session_file()

vim.cmd.cd(tmp .. '/project-b')
local project_b_session = sessions.session_file()

assert(project_a_session ~= project_b_session, 'expected one session file per working directory')
assert(project_a_session:match('/sessions/'), 'expected session files under the sessions state directory')
assert(project_a_session:match('/Session%.vim$'), 'expected a standard Session.vim file name')

sessions.setup()

local restore_autocmds = vim.api.nvim_get_autocmds({ group = 'AutoSessionRestore', event = 'VimEnter' })
local save_autocmds = vim.api.nvim_get_autocmds({ group = 'AutoSessionSave' })

assert(#restore_autocmds == 1, 'expected one VimEnter restore autocmd')
assert(#save_autocmds >= 1, 'expected save autocmds for session persistence')

vim.fn.writefile({ 'one' }, 'one.txt')
vim.fn.writefile({ 'two' }, 'two.txt')
vim.fn.writefile({ 'three' }, 'three.txt')

vim.cmd.edit('one.txt')
vim.cmd.vsplit('two.txt')
vim.cmd.split('three.txt')

sessions.save()
vim.cmd.only()

assert(vim.fn.winnr('$') == 1, 'expected one window after collapsing the test layout')

vim.cmd('source ' .. vim.fn.fnameescape(sessions.session_file()))

assert(vim.fn.winnr('$') == 3, 'expected saved session to restore three windows')

vim.cmd.cd(original_cwd)
vim.env.XDG_STATE_HOME = original_state
vim.fn.delete(tmp, 'rf')
