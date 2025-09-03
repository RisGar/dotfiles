return {
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
        lua = { "stylua", lsp_format = "last" },
        python = { "ruff_format", "ruff_organize_imports" },
        rust = { "rustfmt" },
        javascript = { "prettierd" },
        ocaml = { "ocamlformat" },
        dune = { "format-dune-file" },
        fish = { "fish_indent", lsp_format = "prefer" },
        cpp = { lsp_format = "prefer" }, -- clang-format is built into clangd
        astro = { "prettierd" },
        svelte = { "prettierd" },
        markdown = { "prettierd", "markdownlint-cli2" },
        ["markdown.mdx"] = { "prettierd", "markdownlint-cli2" },
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
