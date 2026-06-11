local M = {}

local system = function(command, opts)
  return vim.system(command, opts):wait()
end

function M._set_system(fn)
  system = fn or function(command, opts)
    return vim.system(command, opts):wait()
  end
end

local function gemfile_includes_rubocop(name, path)
  if name ~= 'Gemfile' then
    return false
  end

  local gemfile = vim.fs.joinpath(path, name)
  local lines = vim.fn.readfile(gemfile)

  for _, line in ipairs(lines) do
    if line:match('rubocop') then
      return true
    end
  end

  return false
end

function M.project_root(file)
  return vim.fs.root(file, {
    { '.rubocop.yml', '.rubocop_todo.yml' },
    gemfile_includes_rubocop,
  })
end

function M.format_file(file)
  local root = M.project_root(file)

  if not root then
    return false
  end

  local result = system({ 'rubocop', '-A', file }, { cwd = root, text = true })

  return result.code == 0
end

function M.format_buffer(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  local file = vim.api.nvim_buf_get_name(bufnr)
  if file == '' then
    return
  end

  if not M.format_file(file) then
    return
  end

  if vim.api.nvim_buf_is_valid(bufnr) and not vim.bo[bufnr].modified then
    vim.api.nvim_buf_call(bufnr, function()
      vim.cmd('silent! edit!')
    end)
  end
end

return M
