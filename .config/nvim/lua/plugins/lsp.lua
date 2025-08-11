return {
  {
    "mason-org/mason.nvim",
    opts = {},
    keys = {
      { "<leader>pm", "<cmd>Mason<cr>", desc = "mason" }
    }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Enable lsps not available or not working in mason
      vim.lsp.enable({ "gleam", "julials", "ocamllsp" })
      vim.lsp.inlay_hint.enable(true, nil)

      vim.lsp.config("ocamllsp", {
        settings = {
          extendedHover = { enable = true },
          standardHover = { enable = true },
          codelens = { enable = true },
          duneDiagnostics = { enable = true },
          inlayHints = { enable = true },
          syntaxDocumentation = { enable = true },
          merlinJumpCodeActions = { enable = true }
        }
      })

      vim.diagnostic.config({ virtual_text = true })
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
          "rust_analyzer", -- done by rustaceanvim
          "jdtls"          -- done by nvim-jdtls
        },
      },
    },
  },

  {
    'jmbuhr/otter.nvim',
    enable = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    ---@module "otter"
    ---@type OtterConfig
    opts = {
      buffers = {
        write_to_disk = true,
      }
    },
  },

  {
    'saghen/blink.compat',
    version = '2.*',
    lazy = true,
    opts = {},
  },

  {
    "saghen/blink.cmp",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
      "rafamadriz/friendly-snippets",
      { "xzbdmw/colorful-menu.nvim", opts = {} },
    },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = {
        preset = "super-tab",
        ["gK"] = { 'show_signature', 'hide_signature', 'fallback' }
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        -- accept = { auto_brackets = { enabled = true } }, -- todo: does not work?
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        trigger = { show_in_snippet = false },
        menu = {
          draw = {
            -- We don't need label_description now because label and label_description are already
            -- combined together in label by colorful-menu.nvim.
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },
      sources = {
        default = {
          "avante",
          "lazydev",
          "lsp",
          "path",
          "snippets",
          "buffer",
        },
        providers = {
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {},
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
        },
      },

      signature = { enabled = true },

      fuzzy = { implementation = "prefer_rust_with_warning" },

      cmdline = {
        keymap = { preset = "inherit" },
        completion = { menu = { auto_show = true } },
      },
    },
    opts_extend = { "sources.default" },
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "format buffer",
      },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        lua = { "stylua", lsp_format = "prefer" },
        python = { "ruff_organize_imports", "ruff_format" },
        rust = { "rustfmt" },
        javascript = { "prettierd" },
        ocaml = { "ocamlformat" },
        cpp = { lsp_format = "prefer" }, -- clang-format is built into clangd
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
      format_on_save = { timeout_ms = 500 },
    },
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
