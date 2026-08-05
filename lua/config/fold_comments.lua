local M = {}

-- Folds every run of consecutive comment lines in the current buffer,
-- leaving the rest of the buffer's folds untouched.
function M.fold_comments(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local win = vim.fn.bufwinid(bufnr)
  if win == -1 then
    return
  end

  local function is_comment_line(lnum)
    local line = vim.fn.getbufline(bufnr, lnum)[1] or ''
    local col = line:find('%S')
    if not col then
      return false
    end

    -- Neovim's built-in ftplugins highlight most languages via Treesitter,
    -- so check captures first and only fall back to legacy :syntax.
    local ok, captures = pcall(vim.treesitter.get_captures_at_pos, bufnr, lnum - 1, col - 1)
    if ok and captures and #captures > 0 then
      for _, capture in ipairs(captures) do
        if capture.capture:match('comment') then
          return true
        end
      end
      return false
    end

    local id = vim.fn.synID(lnum, col, 1)
    local name = vim.fn.synIDattr(vim.fn.synIDtrans(id), 'name')
    return name ~= '' and name:match('Comment') ~= nil
  end

  vim.api.nvim_win_call(win, function()
    -- Manual folds (created below) require 'foldmethod' to be "manual".
    vim.wo[win].foldmethod = 'manual'

    local line_count = vim.api.nvim_buf_line_count(bufnr)
    local start_line = nil

    local function close_run(from, to)
      vim.cmd(string.format('%d,%dfold', from, to))
    end

    for lnum = 1, line_count do
      if is_comment_line(lnum) then
        start_line = start_line or lnum
      else
        if start_line then
          close_run(start_line, lnum - 1)
        end
        start_line = nil
      end
    end
    if start_line then
      close_run(start_line, line_count)
    end
  end)
end

return M
