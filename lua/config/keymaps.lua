-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Exit terminal mode with Esc
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

vim.keymap.set("x", "(", ':<C-u>lua require("config.visual_surround").add("(", ")")<CR>', { desc = "Surround with ()" })
vim.keymap.set("x", "[", ':<C-u>lua require("config.visual_surround").add("[", "]")<CR>', { desc = "Surround with []" })
vim.keymap.set("x", "{", ':<C-u>lua require("config.visual_surround").add("{", "}")<CR>', { desc = "Surround with {}" })
vim.keymap.set("x", "'", ':<C-u>lua require("config.visual_surround").add("\x27", "\x27")<CR>', { desc = "Surround with single quotes" })
vim.keymap.set("x", '"', ':<C-u>lua require("config.visual_surround").add("\\\"", "\\\"")<CR>', { desc = "Surround with double quotes" })
vim.keymap.set("x", ")", ':<C-u>lua require("config.visual_surround").remove("(", ")")<CR>', { desc = "Remove () surround" })
vim.keymap.set("x", "]", ':<C-u>lua require("config.visual_surround").remove("[", "]")<CR>', { desc = "Remove [] surround" })
vim.keymap.set("x", "}", ':<C-u>lua require("config.visual_surround").remove("{", "}")<CR>', { desc = "Remove {} surround" })

-- Toggle the file explorer like VS Code's Command+B shortcut
vim.keymap.set("n", "<D-b>", function()
  Snacks.explorer({ cwd = LazyVim.root() })
end, { desc = "Toggle file explorer" })

-- Toggle the coder/claudecode.nvim terminal window on the right.
vim.keymap.set("n", "<D-M-b>", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude Code window" })

-- Navigate and act on command-line completions with the arrow keys
vim.keymap.set("c", "<Down>", "<C-n>", { remap = true, desc = "Next command-line completion" })
vim.keymap.set("c", "<Up>", "<C-p>", { remap = true, desc = "Previous command-line completion" })
vim.keymap.set("c", "<Right>", "<C-y>", { remap = true, desc = "Accept command-line completion" })
vim.keymap.set("c", "<Left>", "<C-e>", { remap = true, desc = "Cancel command-line completion" })

-- Toggle a terminal opened with the equivalent of :split followed by :terminal
local terminal_buf

vim.keymap.set({ "n", "t" }, "<D-j>", function()
  if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
    local terminal_wins = vim.fn.win_findbuf(terminal_buf)
    if #terminal_wins > 0 then
      vim.api.nvim_win_close(terminal_wins[1], true)
      return
    end
  end

  vim.cmd("split")
  if terminal_buf and vim.api.nvim_buf_is_valid(terminal_buf) then
    vim.api.nvim_win_set_buf(0, terminal_buf)
  else
    vim.cmd("terminal")
    terminal_buf = vim.api.nvim_get_current_buf()
  end
  vim.api.nvim_win_set_height(0, 15)
end, { desc = "Toggle terminal" })

-- Shortcut window navigation from within the terminal
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { silent = true })
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { silent = true })
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { silent = true })
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { silent = true })
