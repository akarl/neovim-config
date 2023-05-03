return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("neodev").setup()

			local keymap = require("user/keymap")
			local lspconfig = require("lspconfig")

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lspconfig.gopls.setup({
				capabilities = capabilities,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					keymap.register("n", "<C-q>", vim.lsp.buf.hover, "lsp hover", ev.buf)
					keymap.register("i", "<C-q>", vim.lsp.buf.signature_help, "lsp signature", ev.buf)
					keymap.register("n", "<leader>R", vim.lsp.buf.rename, "lsp rename", ev.buf)
					keymap.register({ "n", "v" }, "<leader>.", vim.lsp.buf.code_action, "lsp code action", ev.buf)

					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					local au_group = vim.api.nvim_create_augroup("UserLspConfigBuf" .. ev.buf, {})

					vim.api.nvim_create_autocmd("BufWritePre", {
						group = au_group,
						callback = function()
							if client.supports_method("textDocument/formatting") then
								vim.lsp.buf.format({ async = false })
							end
						end,
						buffer = ev.buf,
					})

					vim.api.nvim_create_autocmd({ "CursorHold" }, {
						group = au_group,
						callback = function()
							if client.supports_method("textDocument/documentHighlight") then
								vim.lsp.buf.clear_references()
								vim.lsp.buf.document_highlight()
							end

							if client.supports_method("textDocument/codeLens") then
								vim.lsp.codelens.refresh()
							end
						end,
						buffer = ev.buf,
					})

					vim.api.nvim_create_autocmd({ "CursorHoldI" }, {
						group = au_group,
						callback = function()
							if client.supports_method("textDocument/documentHighlight") then
								vim.lsp.buf.clear_references()
							end
						end,
						buffer = ev.buf,
					})
				end,
			})
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = function()
			local null_ls = require("null-ls")

			return {
				debug = false,
				sources = {
					-- Lua
					null_ls.builtins.formatting.stylua,

					-- Json
					null_ls.builtins.diagnostics.jsonlint,

					-- Javascript
					null_ls.builtins.diagnostics.eslint,

					-- Go
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.formatting.goimports_reviser.with({
						to_temp_file = true,
						args = {
							"-company-prefixes",
							vim.fn.expand("$GOIMPORTS_REVISER_COMPANY_PREFIXES"),
							"$FILENAME",
						},
					}),

					-- Python
					null_ls.builtins.formatting.black,
				},
			}
		end,
	},
}
