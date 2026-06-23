local M = {}

local pending_save = false

local function running_script_or_headless()
  for _, arg in ipairs(vim.v.argv) do
    if arg == '--headless' or arg == '-l' then
      return true
    end
  end

  return false
end

local function session_dir()
  local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':p')
  local key = vim.fn.sha256(cwd)
  return vim.fn.stdpath('state') .. '/sessions/' .. key
end

function M.session_file()
  return session_dir() .. '/Session.vim'
end

function M.save()
  local file = M.session_file()
  vim.fn.mkdir(vim.fn.fnamemodify(file, ':h'), 'p')
  pcall(vim.cmd, 'silent! mksession! ' .. vim.fn.fnameescape(file))
end

function M.schedule_save()
  if pending_save then
    return
  end

  pending_save = true
  vim.defer_fn(function()
    pending_save = false
    M.save()
  end, 1000)
end

function M.restore()
  if vim.fn.argc(-1) ~= 0 or running_script_or_headless() then
    return
  end

  local file = M.session_file()
  if vim.fn.filereadable(file) == 1 then
    vim.cmd('silent! source ' .. vim.fn.fnameescape(file))
  end
end

function M.setup()
  vim.opt.sessionoptions:append({
    'buffers',
    'curdir',
    'folds',
    'tabpages',
    'terminal',
    'winsize',
  })

  vim.api.nvim_create_autocmd('VimEnter', {
    group = vim.api.nvim_create_augroup('AutoSessionRestore', { clear = true }),
    nested = true,
    callback = M.restore,
  })

  local save_group = vim.api.nvim_create_augroup('AutoSessionSave', { clear = true })

  vim.api.nvim_create_autocmd('VimLeavePre', {
    group = save_group,
    callback = M.save,
  })

  vim.api.nvim_create_autocmd({
    'BufDelete',
    'BufWinEnter',
    'FocusLost',
    'TabEnter',
    'TabClosed',
    'WinClosed',
    'WinEnter',
  }, {
    group = save_group,
    callback = M.schedule_save,
  })
end

return M
