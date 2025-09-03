return {
  {
    "echasnovski/mini.ai",
    version = "*",
    opts = {},
  },

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
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "gsa",        -- Add surrounding in Normal and Visual modes
        delete = "gsd",     -- Delete surrounding
        find = "gsf",       -- Find surrounding (to the right)
        find_left = "gsF",  -- Find surrounding (to the left)
        highlight = "gsh",  -- Highlight surrounding
        replace = "gsr",    -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
}
