local M = {}

local system = function(command, opts)
  return vim.system(command, opts):wait()
end

local function ruby_manager_executable(name)
  local home = vim.uv.os_homedir()
  if not home or home == '' then
    return nil
  end

  for _, candidate in ipairs({
    vim.fs.joinpath(home, '.rbenv', 'shims', name),
    vim.fs.joinpath(home, '.asdf', 'shims', name),
    vim.fs.joinpath(home, '.mise', 'shims', name),
  }) do
    if vim.fn.executable(candidate) == 1 then
      return candidate
    end
  end

  return nil
end

local function executable_path(name)
  local path = ruby_manager_executable(name) or vim.fn.exepath(name)
  return path ~= '' and path or nil
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
  if vim.fn.filereadable(gemfile) == 0 then
    return false
  end

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

  local command
  local bundle = gemfile_includes_rubocop('Gemfile', root) and executable_path('bundle')
  if bundle then
    command = { bundle, 'exec', 'rubocop', '-A', file }
  else
    local rubocop = executable_path('rubocop')
    if not rubocop then
      vim.notify('Ruby format skipped: rubocop was not found in PATH or Ruby manager shims', vim.log.levels.WARN)
      return false
    end

    command = { rubocop, '-A', file }
  end

  local ok, result = pcall(system, command, { cwd = root, text = true })
  if not ok then
    vim.notify(('Ruby format failed to start %s: %s'):format(command[1], result), vim.log.levels.ERROR)
    return false
  end

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
