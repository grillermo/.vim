local ruby_format = require('config.ruby_format')

local tmp = vim.fn.tempname()
vim.fn.mkdir(tmp .. '/with-rubocop/app/models', 'p')
vim.fn.mkdir(tmp .. '/without-rubocop/app/models', 'p')
vim.fn.writefile({}, tmp .. '/with-rubocop/.rubocop.yml')

local with_rubocop = tmp .. '/with-rubocop/app/models/user.rb'
local without_rubocop = tmp .. '/without-rubocop/app/models/user.rb'
vim.fn.writefile({ 'class User', 'end' }, with_rubocop)
vim.fn.writefile({ 'class User', 'end' }, without_rubocop)

local commands = {}
ruby_format._set_system(function(command)
  table.insert(commands, command)
  return { code = 0 }
end)

ruby_format.format_file(with_rubocop)
assert(#commands == 1, 'expected RuboCop to run when .rubocop.yml exists at project root')
assert(commands[1][1] == 'rubocop', 'expected rubocop executable')
assert(commands[1][2] == '-A', 'expected autocorrect mode')
assert(commands[1][3] == with_rubocop, 'expected current Ruby file path')

ruby_format.format_file(without_rubocop)
assert(#commands == 1, 'expected RuboCop not to run without a project root marker')

ruby_format._set_system(nil)
vim.fn.delete(tmp, 'rf')
