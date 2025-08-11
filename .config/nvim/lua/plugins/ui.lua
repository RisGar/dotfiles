return {
  { -- One Dark Pro theme from Atom
    "olimorris/onedarkpro.nvim",
    priority = 1000,
    opts = {
      options = {
        transparency = true,
        cursorline = true
      },
      highlights = {
        SnacksIndentScope = { fg = "${fg}" },
        Cursor = { bg = "#5188FA", fg = "${white}" },
      },
      styles = {
        comments = "italic",
        keywords = "bold"
      }
    },
    config = function(_, opts)
      require("onedarkpro").setup(opts)
      vim.cmd.colorscheme("onedark")
      -- vim.cmd.hi("Comment gui=none")`norg`, `scss`, `tsx`
    end,
  },

  { -- icon & status line
    "echasnovski/mini.statusline",
    opts = {
      use_icons = true,
    },
    config = function(_, opts)
      require("mini.statusline").setup({ opts })
      require("mini.statusline").section_location = function()
        return "%2l:%-2v"
      end
    end,
  },

}
