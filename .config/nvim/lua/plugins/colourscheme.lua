return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedark").setup({
        transparent = true,
        lualine = {
          transparent = true, -- lualine center bar transparency
        },
      })
      require("onedark").load()
    end,
  },
}
