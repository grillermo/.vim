-- Claude Chat: sidebar hosting the interactive Claude Code TUI
-- https://github.com/codegik/claude-chat.nvim

-- Sends the last visual selection to the Claude Chat sidebar, formatted as:
--   {relative_path}#{start_line}:{end_line}
--   ```
--   {selected code}
--   ```
-- Uses nvim_paste (rather than chansend) so Neovim's terminal paste handling
-- brackets the text for the child process, landing all lines in the prompt
-- without submitting on the internal newlines.
local function send_visual_selection()
  local bufnr = vim.api.nvim_get_current_buf()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line, end_line = start_pos[2], end_pos[2]
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
  local code = table.concat(lines, "\n")

  local file = vim.api.nvim_buf_get_name(bufnr)
  local cwd = vim.fn.getcwd()
  local rel = (vim.fs.relpath and vim.fs.relpath(cwd, file)) or vim.fn.fnamemodify(file, ":.")

  local payload = string.format("%s#%d:%d\n```\n%s\n```\n", rel, start_line, end_line, code)

  local ui = require("claude-chat.ui")
  local started = ui.open()
  vim.defer_fn(function()
    vim.api.nvim_paste(payload, false, -1)
  end, started and 1500 or 0)
end

return {
  {
    "codegik/claude-chat.nvim",
    cmd = { "ClaudeChat", "ClaudeChatReset", "ClaudeChatFile", "ClaudeChatContinue", "ClaudeChatSessions" },
    keys = {
      { "<leader>ai", "<cmd>ClaudeChat<cr>", desc = "Claude Chat: toggle sidebar" },
      { "<leader>af", "<cmd>ClaudeChatFile<cr>", desc = "Claude Chat: add current file" },
      { "<leader>ca", send_visual_selection, mode = "v", desc = "Claude Chat: send selection" },
    },
    config = function()
      require("claude-chat").setup()
    end,
  },
}
