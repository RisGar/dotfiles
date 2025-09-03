return {
  {
    "mason-org/mason.nvim",
    ---@module "mason"
    ---@type MasonSettings
    opts = {
      PATH = "append",
    },
    keys = {
      { "<leader>pm", "<cmd>Mason<cr>", desc = "mason" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.inlay_hint.enable(true, nil)
      vim.diagnostic.config({ virtual_text = true })

      vim.lsp.enable({ "gleam", "julials", "ocamllsp", "clangd" })

      -- ocaml config in lsp/ocamllsp.lua

      vim.lsp.config("vtsls", {
        settings = {
          typescript = {
            inlayHints = {
              parameterNames = { enabled = "all" },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
          },
          vtsls = {
            tsserver = {
              globalPlugins = {
                {
                  name = "@astrojs/ts-plugin",
                  location = vim.fn.stdpath("data")
                      .. "/mason/packages/astro-language-server/node_modules/@astrojs/ts-plugin",
                  enableForWorkspaceTypeScriptVersions = true,
                },
                {
                  name = "typescript-svelte-plugin",
                  location = vim.fn.stdpath("data")
                      .. "/mason/packages/svelte-language-server/node_modules/typescript-svelte-plugin",
                  enableForWorkspaceTypeScriptVersions = true,
                },
              },
            },
          },
        },
      })

      vim.lsp.config("clangd", {
        keys = {
          { "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
        },
      })

      vim.lsp.config("texlab", {
        keys = {
          { "<Leader>K", "<plug>(vimtex-doc-package)", desc = "Vimtex Docs", silent = true },
        },
      })
    end,
    dependencies = {
      { "j-hui/fidget.nvim", opts = { notification = { window = { winblend = 0 } } } },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_enable = {
        exclude = {
          "jdtls", -- done by nvim-jdtls
        },
      },
    },
  },

  {
    "jmbuhr/otter.nvim",
    enable = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ---@module "otter"
    ---@type OtterConfig
    opts = {
      buffers = {
        write_to_disk = true,
      },
    },
  },
}
