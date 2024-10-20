return {
  -- Telescrope
  {
    "nvim-telescope/telescope.nvim",
    branch = '0.1.x',
    dependencies = { 
      "nvim-lua/plenary.nvim"
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    keys = {
      {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "find files"},
      {"<leader>fg", "<cmd>Telescope git_files<cr>", desc = "find git files"},
      {"<leader>fF", "<cmd>Telescope live_grep<cr>", desc = "live grep"}
    },
    config = function()
      require("telescope").setup({
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      })
    end,
  },
  
  -- Show key bindings
  {
    "folke/which-key.nvim",
    event = "VimEnter",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "buffer local keymaps",
      },
    },
    opts = {
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = {},
      },
      spec = {
        { "<leader>f", group = "telescope" },
        { "<leader>g", group = "git" },
      }
    },
  },

  -- Icons for which-key
  {
    'echasnovski/mini.icons',
    version = false,
    config = true
  },
  {
    'nvim-tree/nvim-web-devicons',
    config = true
  },


  {
    "debugloop/telescope-undo.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      { "<leader>u", "<cmd>Telescope undo<cr>", desc = "undo history" },
    },
    opts = { extensions = { undo = {}, }, },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("undo")
    end,
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
        { "<leader>gl", "<cmd>LazyGit<cr>", desc = "lazygit" }
    }
  },

  {
    'tpope/vim-sleuth'
  },

}
