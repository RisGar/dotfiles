return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      {
        "bezhermoso/tree-sitter-ghostty",
        build = "make nvim_install",
      }
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
        "regex"
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
      parser_config.crystal = {
        install_info = {
          url = "/Users/rishab/Documents/Binaries/tree-sitter-crystal",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "main",
        },
        filetype = "cr",
      }
    end
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
    keys = {
      {
        "<leader>st",
        function()
          Snacks.picker.todo_comments()
        end,
        desc = "todo",
      },
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
    keys = {
      { "<leader>cp", function() require("precognition").peek() end, desc = "show motions" }
    }
  }
}
