return {
	{
		"mason-org/mason.nvim",
		opts = {
			ensure_installed = {
				"astro-language-server",
				"bash-language-server",
				"biome",
				"docker-language-server",
				"fish-lsp",
				"jdtls",
				"json-lsp",
				"lua-language-server",
				"markdownlint-cli2",
				"marksman",
				"mmdc",
				"ocamlformat",
				"prettierd",
				"ruff",
				"stylua",
				"svelte-language-server",
				"texlab",
				"tinymist",
				"tombi",
				"vtsls",
				"yaml-language-server",
				-- installed separately:
				-- ocamllsp
				-- rust-anaylzer
				-- nixd
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.lsp.inlay_hint.enable(true, nil)
			vim.diagnostic.config({ virtual_text = true })

			vim.lsp.enable({
				"gleam",
				"biome",
				"julials",
				"ocamllsp",
				"clangd",
				"astro",
				"docker_language_server",
				"fish_lsp",
				"jsonls",
				"lua_ls",
				"marksman",
				"ruff",
				"svelte",
				"texlab",
				"tinymist",
				"tombi",
				"vtsls",
				"yamlls",
				"bashls",
				"nixd",
				-- activated through seperate plugin:
				-- jdtls
				-- rust_analyzer
			})

			-- ocaml config in ../../lsp/ocamllsp.lua

			vim.lsp.config("vtsls", {
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
				settings = {
					typescript = {
						inlayHints = {
							parameterNames = { enabled = "all" },
							parameterTypes = { enabled = true },
							variableTypes = { enabled = true },
							propertyDeclarationTypes = { enabled = true },
							functionLikeReturnTypes = { enabled = true },
							enumMemberValues = { enabled = true },
						},
					},
					vtsls = {
						tsserver = {
							globalPlugins = {
								{
									name = "@astrojs/ts-plugin",
									location = vim.fn.stdpath("data")
										.. "/mason/packages/astro-language-server/node_modules/@astrojs/ts-plugin",
									enableForWorkspaceTypeScriptVersions = true,
								},
								{
									name = "typescript-svelte-plugin",
									location = vim.fn.stdpath("data")
										.. "/mason/packages/svelte-language-server/node_modules/typescript-svelte-plugin",
									enableForWorkspaceTypeScriptVersions = true,
								},
							},
						},
					},
				},
			})

			vim.lsp.config("clangd", {
				keys = {
					{ "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
				},
			})

			vim.lsp.config("texlab", {
				keys = {
					{ "<Leader>K", "<plug>(vimtex-doc-package)", desc = "Vimtex Docs", silent = true },
				},
			})
		end,
		dependencies = {
			{ "j-hui/fidget.nvim", opts = { notification = { window = { winblend = 0 } } } },
		},
	},

	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			automatic_enable = false,
		},
		keys = {
			{ "<leader>pm", "<cmd>Mason<cr>", desc = "mason" },
		},
	},

	-- {
	--   "jmbuhr/otter.nvim",
	--   enable = false,
	--   dependencies = {
	--     "nvim-treesitter/nvim-treesitter",
	--   },
	--   ---@module "otter"
	--   ---@type OtterConfig
	--   opts = {
	--     buffers = {
	--       write_to_disk = true,
	--     },
	--   },
	-- },
}
