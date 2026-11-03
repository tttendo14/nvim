return {
  {
    "mlr-msft/vim-loves-dafny",
    lazy = false,
    init = function()
      local group = vim.api.nvim_create_augroup("DafnySyntax", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        pattern = "dafny",
        callback = function(event)
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(event.buf) then
              vim.treesitter.stop(event.buf)
              vim.bo[event.buf].syntax = "dafny"
            end
          end)
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").dafny = {
            install_info = {
              url = "https://github.com/hath995/tree-sitter-dafny",
              queries = "queries",
            },
          }
        end,
      })
    end,
    opts = { ensure_installed = { "dafny" } },
  },
  {
    "tttendo14/dafny-gutter.nvim",
    lazy = false,
    opts = {
      animation = {
        amplitude = 0.3,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- With --verify-on Save the server verifies nothing when a file is opened, so a
      -- buffer with failing proofs looks clean until it is saved. Simulate a save on
      -- attach so every opened file is verified right away, like VS Code and the autograder.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("DafnyVerifyOnOpen", { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.name == "dafny" then
            client:notify("textDocument/didSave", {
              textDocument = { uri = vim.uri_from_bufnr(event.buf) },
            })
          end
        end,
      })
    end,
    opts = {
      servers = {
        dafny = {
          -- Dafny is installed system-wide; Mason does not manage this server.
          mason = false,
          -- Verify after writing the buffer and publish failures as diagnostics.
          cmd = {
            "dafny",
            "server",
            "--verify-on",
            "Save",
            "--notify-line-verification-status",
            -- Match the autograder: dafny /compile:0 /noCheating:1 /rlimit:32700000
            -- /compile:0 is implicit (the server never compiles).
            -- /noCheating:1 has no server equivalent; without --allow-axioms,
            -- `assume` statements are still flagged as warnings.
            "--resource-limit",
            "32700000",
          },
        },
      },
    },
  },
}
