return {
  { "nvim-lua/plenary.nvim", lazy = true },


  -- { -- TODO:
  --   "folke/trouble.nvim",
  --   opts = {},
  --   specs = {
  --     "folke/snacks.nvim",
  --     opts = function(_, opts)
  --       return vim.tbl_deep_extend("force", opts or {}, {
  --         picker = {
  --           actions = require("trouble.sources.snacks").actions,
  --           win = {
  --             input = {
  --               keys = {
  --                 ["<c-t>"] = {
  --                   "trouble_open",
  --                   mode = { "n", "i" },
  --                 },
  --               },
  --             },
  --           },
  --         },
  --       })
  --     end,
  --   },
  -- },
}
