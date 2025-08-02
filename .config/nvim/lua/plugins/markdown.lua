return {

	{ -- render markdown with avante.nvim config
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			preset = "obsidian",
			completions = { blink = { enabled = true } },
			file_types = { "markdown", "quarto", "Avante" },
			html = {
				comment = {
					conceal = false,
				},
			},
		},
		ft = { "markdown", "Avante" },
	},
}
