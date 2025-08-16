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
          url = "Users/rishab/Documents/Binaries/tree-sitter-crystal",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "main",
        },
        filetype = "cr",
      }
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  { "wakatime/vim-wakatime", lazy = false },

  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "todo", },
    },
  },

  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  { -- Rainbow brackets
    url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
  },

  {
    "tris203/precognition.nvim",
    --event = "VeryLazy",
    opts = {
      startVisible = false,
      -- showBlankVirtLine = true,
      -- highlightColor = { link = "Comment" },
      -- hints = {
      --      Caret = { text = "^", prio = 2 },
      --      Dollar = { text = "$", prio = 1 },
      --      MatchingPair = { text = "%", prio = 5 },
      --      Zero = { text = "0", prio = 1 },
      --      w = { text = "w", prio = 10 },
      --      b = { text = "b", prio = 9 },
      --      e = { text = "e", prio = 8 },
      --      W = { text = "W", prio = 7 },
      --      B = { text = "B", prio = 6 },
      --      E = { text = "E", prio = 5 },
      -- },
      -- gutterHints = {
      --     G = { text = "G", prio = 10 },
      --     gg = { text = "gg", prio = 9 },
      --     PrevParagraph = { text = "{", prio = 8 },
      --     NextParagraph = { text = "}", prio = 8 },
      -- },
      -- disabled_fts = {
      --     "startify",
      -- },
    },
    -- stylua: ignore
    keys = {
      { "<leader>up", function() require("precognition").peek() end, desc = "show motions" },
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabled = true,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "flash Treesitter" },
      { "r",     mode = { "o" },           function() require("flash").remote() end,            desc = "remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "toggle flash search" },
    },
  },

  {
    "echasnovski/mini.ai",
    version = "*",
    opts = {},
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
}
