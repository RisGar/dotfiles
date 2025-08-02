-- [[ keymaps ]]

vim.keymap.set("n", "<Left>", "<Nop>")
vim.keymap.set("n", "<Right>", "<Nop>")
vim.keymap.set("n", "<Down>", "<Nop>")
vim.keymap.set("n", "<Up>", "<Nop>")
vim.keymap.set("n", "<ScrollWheelRight>", "<Nop>") -- todo: ???

vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "mason" })
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "lazy" })
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<cr>", { desc = "linewrap" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "exit terminal mode" }) -- exit terminal mode

vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" })
vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "run codelens" })
vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "line diagnostics" })
vim.keymap.set("n", "<leader>cC", vim.lsp.codelens.refresh, { desc = "refresh codelens" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "rename" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "goto definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "goto references" })
vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "goto implementation" })
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "goto type definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "goto declaration" })
vim.keymap.set("n", "gK", function()
	return vim.lsp.buf.signature_help()
end, { desc = "signature help" })

-- [[ autocommands ]]
vim.api.nvim_create_autocmd("TextYankPost", { -- highlight when yanking (copying) text
	desc = "highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- vim.api.nvim_create_autocmd("LspAttach", { -- format on save
--   group = vim.api.nvim_create_augroup("lsp", { clear = true }),
--   callback = function(args)
--     vim.api.nvim_create_autocmd("BufWritePre", {
--       buffer = args.buf,
--       callback = function()
--         vim.lsp.buf.format({ async = false, id = args.data.client_id })
--       end,
--     })
--   end,
-- })
