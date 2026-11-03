local M = {}

local function marks()
  local first, last = vim.fn.getpos("'<"), vim.fn.getpos("'>")
  if first[2] > last[2] or (first[2] == last[2] and first[3] > last[3]) then
    first, last = last, first
  end
  return first[2], first[3], last[2], last[3]
end

local function text(row, start_col, end_col)
  return table.concat(vim.api.nvim_buf_get_text(0, row - 1, start_col, row - 1, end_col, {}), "")
end

local function reselect(start_row, start_col, end_row, end_col)
  vim.fn.setpos("'<", { 0, start_row, start_col, 0 })
  vim.fn.setpos("'>", { 0, end_row, end_col, 0 })
  vim.cmd("normal! gv")
end

function M.add(open, close)
  local start_row, start_col, end_row, end_col = marks()
  vim.api.nvim_buf_set_text(0, end_row - 1, end_col, end_row - 1, end_col, { close })
  vim.api.nvim_buf_set_text(0, start_row - 1, start_col - 1, start_row - 1, start_col - 1, { open })
  reselect(start_row, start_col + #open, end_row, end_col + (start_row == end_row and #open or 0))
end

function M.remove(open, close)
  local start_row, start_col, end_row, end_col = marks()
  local before = start_col > #open and text(start_row, start_col - #open - 1, start_col - 1) or ""
  local after = text(end_row, end_col, end_col + #close)
  local includes_pair = text(start_row, start_col - 1, start_col - 1 + #open) == open
    and text(end_row, end_col - #close, end_col) == close

  if before == open and after == close then
    vim.api.nvim_buf_set_text(0, end_row - 1, end_col, end_row - 1, end_col + #close, {})
    vim.api.nvim_buf_set_text(0, start_row - 1, start_col - #open - 1, start_row - 1, start_col - 1, {})
    reselect(start_row, start_col - #open, end_row, end_col - (start_row == end_row and #open or 0))
  elseif includes_pair then
    vim.api.nvim_buf_set_text(0, end_row - 1, end_col - #close, end_row - 1, end_col, {})
    vim.api.nvim_buf_set_text(0, start_row - 1, start_col - 1, start_row - 1, start_col - 1 + #open, {})
    reselect(start_row, start_col, end_row, end_col - #close - (start_row == end_row and #open or 0))
  else
    vim.notify("Selection is not enclosed by the requested pair", vim.log.levels.WARN)
  end
end

return M
