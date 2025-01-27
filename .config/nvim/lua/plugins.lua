return {
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		opts = {
			icons = {
				mappings = true,

				keys = {},
			},

			-- Document existing key chains
			spec = {
				{ "<leader>f", group = "find" },
			},
		},
	},

	{ -- Fuzzy Finder
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "find keymaps" })
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "find files" })
			vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "find in repo" })
			vim.keymap.set("n", "<leader>fF", builtin.live_grep, { desc = "grep in cwd" })
			vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = "find recents" })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "switch between buffers" })
			vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "fuzzy find current buffer" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>fn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "find neovim config" })
		end,
	},

	-- [[ Code Plugins ]]
	{ "williamboman/mason.nvim", config = true },

	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>s",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "format buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use 'stop_after_first' to run the first available formatter from the list
				-- javascript = { "prettierd", "prettier", stop_after_first = true },
			},
		},
	},

	-- [[ THEMING ]]
	{ -- One Dark Pro theme from Atom
		"olimorris/onedarkpro.nvim",
		priority = 1000,
		opts = {
			options = {
				transparency = true,
			},
		},
		config = function(_, opts)
			require("onedarkpro").setup(opts)
			vim.cmd.colorscheme("onedark")
			vim.cmd.hi("Comment gui=none")
		end,
	},

	{ -- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{ -- Rainbow brackets
		url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
	},

	-- Indent lines
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = true,
		--		config = function()
		--			local highlight = {
		--				"RainbowRed",
		--				"RainbowYellow",
		--				"RainbowBlue",
		--				"RainbowOrange",
		--				"RainbowGreen",
		--				"RainbowViolet",
		--				"RainbowCyan",
		--			}
		--
		--			local hooks = require("ibl.hooks")
		--
		--			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		--				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
		--				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
		--				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
		--				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
		--				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
		--				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
		--				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
		--			end)
		--
		--			require("ibl").setup({ indent = { highlight = highlight } })
		--		end,
	},

	{ -- icon & status line
		"echasnovski/mini.nvim",
		config = function()
			require("mini.icons").setup({})

			local statusline = require("mini.statusline")
			statusline.setup({ use_icons = true })
			statusline.section_location = function()
				return "%2l:%-2v"
			end
		end,
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"vim",
				"vimdoc",
				"fish",
			},
			auto_install = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
		},
	},

	{ -- auto pair brackets
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		-- Optional dependency
		dependencies = { "hrsh7th/nvim-cmp" },
		config = function()
			require("nvim-autopairs").setup({})
			-- If you want to automatically add `(` after selecting a function or method
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	{
		"karb94/neoscroll.nvim",
		config = true,
	},
}
