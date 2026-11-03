return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  event = "VeryLazy",
  opts = {
    terminal = {
      split_side = "right",
      split_width_percentage = 0.35,
    },
  },
  keys = {
    { "<D-M-b>", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code window" },
    { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code window" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude Code window" },
    { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer to Claude" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "x", desc = "Send selection to Claude" },
    { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Claude diff" },
    { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Claude diff" },
  },
}
