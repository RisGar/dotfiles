return {
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
        { "<leader>p", group = "plugins" },
        { "<leader>s", group = "search" },
        { "<leader>u", group = "ui" },
        { "<leader>q", group = "quit" },
        { "g", group = "goto" },
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
