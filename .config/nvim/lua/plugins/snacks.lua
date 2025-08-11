return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@module "snacks"
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      indent = { enabled = true },
      lazygit = { enabled = true },
      -- scroll = { enabled = true },
      rename = { enabled = true },
      image = { enabled = true },
      input = { enabled = true },
      picker = {
        enabled = true,
        hidden = true,
        sources = {
          files = {
            hidden = true
          }
        }
      },
      toggle = { enabled = true },
      words = { enabled = true }
    },
    config = function(_, opts)
      require("snacks").setup(opts)

      Snacks.toggle.option("spell"):map("<leader>us")
      Snacks.toggle.option("wrap"):map("<leader>uw")
    end,
    keys = {
      --- quick pickers
      { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "smart find files" },
      { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "buffers" },
      { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "grep" },
      { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "cmd history" },
      -- { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },

      --- find
      { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "find files" },
      { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "git find" },
      { "<leader>f.",      function() Snacks.picker.recent() end,                                  desc = "recents" },
      { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "buffers" },
      { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "find in config" },
      { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "projects" },

      -- git
      { "<leader>gl",      function() Snacks.lazygit.open() end,                                   desc = "lazygit" },

      -- grep
      { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "grep" },
      { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "buffer lines" },
      { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "grep open buffers" },

      -- search
      { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "undo history" },
      { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "help pages" },
      { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "keymaps" },
      { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "cmd history" },
      { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "search history" },
      { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
      { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "man pages" },
      { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "lsp Symbols" },
      { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "lsp workspace symbols" },
      -- { TODO: diagonostics & trouble nvim
      --   "<leader>sd",
      --   function()
      --     Snacks.picker.diagnostics()
      --   end,
      --   desc = "Diagnostics",
      -- }, { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },

      -- lsp gotos
      { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "goto definition" },
      { "gr",              function() Snacks.picker.lsp_references() end,                          desc = "references",           nowait = true },
      { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "goto implementation" },
      { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "goto type definition" },
    },
  },
}
