return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "clang-format",
        "cmakelang",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cpp = { "clang-format" },
        cmake = { "cmake_format" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Use the system clangd already available on this machine. It provides
        -- the definition and implementation requests used by gd and gI.
        clangd = { mason = false },
      },
    },
  },
}
