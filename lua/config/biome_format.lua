local M = {}

local system = function(command, opts)
  return vim.system(command, opts):wait()
end

function M._set_system(fn)
  system = fn or function(command, opts)
    return vim.system(command, opts):wait()
  end
end

function M.project_root(file)
  return vim.fs.root(file, { 'biome.json', 'biome.jsonc' })
end

local function biome_executable(root)
  local local_bin = vim.fs.joinpath(root, 'node_modules', '.bin', 'biome')
  if vim.fn.executable(local_bin) == 1 then
    return { local_bin }
  end

  if vim.fn.executable('npx') == 1 then
    return { 'npx', '--no-install', 'biome' }
  end

  return nil
end

function M.format_file(file)
  local root = M.project_root(file)

  if not root then
    return false
  end

  local biome = biome_executable(root)
  if not biome then
    vim.notify('Biome format skipped: biome was not found in node_modules/.bin or npx', vim.log.levels.WARN)
    return false
  end

  local command = vim.list_extend(vim.deepcopy(biome), { 'check', '--write', file })

  local ok, result = pcall(system, command, { cwd = root, text = true })
  if not ok then
    vim.notify(('Biome format failed to start %s: %s'):format(command[1], result), vim.log.levels.ERROR)
    return false
  end

  -- `biome check --write` still applies formatting fixes and exits nonzero
  -- when unrelated lint errors remain, so a nonzero exit is not a failure.
  return true
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
