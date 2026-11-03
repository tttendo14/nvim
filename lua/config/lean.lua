-- lean.nvim is managed by Neovim's built-in vim.pack (not lazy.nvim).
-- lazy.nvim resets 'packpath', so restore the site dir before vim.pack.add.
vim.opt.packpath:prepend(vim.fn.stdpath("data") .. "/site")

vim.g.lean_config = { mappings = true }

vim.pack.add({ "https://github.com/Julian/lean.nvim" })
