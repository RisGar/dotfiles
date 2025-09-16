return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true })
				end,
				mode = "",
				desc = "format buffer",
			},
		},
		---@module "conform"
		---@type conform.setupOpts
		opts = {
			formatters_by_ft = {
				astro = { "biome", "prettierd", stop_after_first = true },
				cpp = { lsp_format = "prefer" }, -- clang-format is built into clangd
				css = { "biome", "prettierd", stop_after_first = true },
				dune = { "format-dune-file" },
				fish = { "fish_indent", lsp_format = "prefer" },
				graphql = { "biome", "prettierd", stop_after_first = true },
				handlebars = { "prettierd" },
				html = { "prettierd" },
				javascript = { "biome", "prettierd", stop_after_first = true },
				javascriptreact = { "biome", "prettierd", stop_after_first = true },
				json = { "biome" },
				jsonc = { "biome" },
				less = { "prettierd" },
				lua = { "stylua", lsp_format = "first" }, -- format no-stylua blocks with lsp_format
				markdown = { "prettierd", "markdownlint-cli2" },
				["markdown.mdx"] = { "prettierd", "markdownlint-cli2" },
				nix = { "nixfmt" },
				ocaml = { "ocamlformat" },
				python = { "ruff_format", "ruff_organize_imports" },
				rust = { "rustfmt" },
				scss = { "prettierd" },
				svelte = { "biome", "prettierd", stop_after_first = true },
				typescript = { "biome", "prettierd", stop_after_first = true },
				typescriptreact = { "biome", "prettierd", stop_after_first = true },
				vue = { "biome", "prettierd", stop_after_first = true },
				yaml = { "prettierd" },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = { timeout_ms = 500 },
			formatters = {
				biome = {
					require_cwd = true,
				},
			},
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},
}
