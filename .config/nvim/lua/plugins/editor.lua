return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      {
        "bezhermoso/tree-sitter-ghostty",
        build = "make nvim_install",
      },
    },
    main = "nvim-treesitter.configs",
    opts = {
      ensure_installed = {
        "bash",
        "diff",
        "html",
        "json5",
        "latex",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
        "regex",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- see: https://github.com/crystal-lang-tools/tree-sitter-crystal
      -- remove when support is upstreamed
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.crystal = {
        install_info = {
          url = "/Users/rishab/Documents/Binaries/tree-sitter-crystal",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "main",
        },
        filetype = "cr",
      }
    end,
  },

  { -- Rainbow brackets
    url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
  },

  { "wakatime/vim-wakatime",                   lazy = false },

  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    opts = { startVisible = false },
    -- stylua: ignore
    keys = {
      { "<leader>up", function() require("precognition").peek() end, desc = "show motions" },
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      labels = "asdfghjklöäqwertyuiopüzxcvbnm",
      modes = {
        search = {
          enabled = true,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "flash treesitter" },
      { "r",     mode = { "o" },           function() require("flash").remote() end,            desc = "remote flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "treesitter search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "toggle flash search" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },

  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    -- stylua: ignore
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              desc = "trouble diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "trouble buffer diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>",                  desc = "trouble symbols" },
      { "<leader>cS", "<cmd>Trouble lsp toggle<cr>",                      desc = "trouble lsp" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                  desc = "trouble location list" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                   desc = "trouble quickfix list" },
    },
  },

  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "search and replace",
      },
    },
  },

  { "nvim-treesitter/nvim-treesitter-context", opts = {} },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    ---@module "which-key"
    ---@type wk.Opts
    opts = {
      preset = "helix",
      show_help = false, -- enable again after https://github.com/folke/which-key.nvim/issues/967 gets fixed
      spec = {
        { "<leader>a", group = "ai", icon = { icon = " ", color = "orange" } },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>p", group = "plugins", icon = { icon = " ", color = "cyan" } },
        { "<leader>s", group = "search" },
        { "<leader>u", group = "ui" },
        { "<leader>x", group = "diagnostics", icon = { icon = "󱖫 ", color = "green" } },
        { "g", group = "goto" },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
        { "z", group = "fold" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}
