return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("neodev").setup()

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
					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					local telescope = require("telescope.builtin")
					local keymap = require("user/keymap")

					keymap.groupname("<leader>l", "lsp", ev.buf)

					if client.server_capabilities.signatureHelpProvider then
						keymap.register("i", "<C-]>", telescope.lsp_definitions, "goto definition", ev.buf)
					end

					if client.server_capabilities.implementationProvider then
						keymap.register("n", "<C-[>", telescope.lsp_implementations, "goto implementation", ev.buf)
					end

					if client.server_capabilities.documentSymbolProvider then
						keymap.register("n", "<leader>ls", telescope.lsp_document_symbols, "document symbols", ev.buf)
					end

					if client.server_capabilities.workspaceSymbolProvider then
						keymap.register(
							"n",
							"<leader>lS",
							telescope.lsp_dynamic_workspace_symbols,
							"workspace symbols",
							ev.buf
						)
					end

					if client.server_capabilities.hoverProvider then
						keymap.register("n", "<C-q>", vim.lsp.buf.hover, "lsp hover", ev.buf)
					end

					if client.server_capabilities.signatureHelpProvider then
						keymap.register("i", "<C-q>", vim.lsp.buf.signature_help, "lsp signature", ev.buf)
					end

					if client.server_capabilities.renameProvider then
						keymap.register("n", "<leader>lr", vim.lsp.buf.rename, "rename", ev.buf)
					end

					if client.server_capabilities.referencesProvider then
						keymap.register("n", "<leader>lR", telescope.lsp_references, "references", ev.buf)
					end

					if client.server_capabilities.callHierarchyProvider then
						keymap.register("n", "<leader>lI", telescope.lsp_incoming_calls, "incoming calls", ev.buf)
						keymap.register("n", "<leader>lO", telescope.lsp_outgoing_calls, "outgoing calls", ev.buf)
					end

					if client.server_capabilities.codeActionProvider then
						keymap.register({ "n", "v" }, "<leader>.", vim.lsp.buf.code_action, "lsp code action", ev.buf)
					end

					if client.server_capabilities.documentFormattingProvider then
						local au_group = vim.api.nvim_create_augroup("LSPDocumentFormatting" .. ev.buf, {
							clear = true,
						})

						vim.api.nvim_create_autocmd("BufWritePre", {
							group = au_group,
							callback = function()
								vim.lsp.buf.format({ async = false })
							end,
							buffer = ev.buf,
						})
					end

					if client.server_capabilities.documentHighlightProvider then
						local au_group = vim.api.nvim_create_augroup("LSPDocumentHighlight" .. ev.buf, {
							clear = true,
						})

						vim.api.nvim_create_autocmd("CursorHold", {
							group = au_group,
							callback = function()
								vim.lsp.buf.clear_references()
								vim.lsp.buf.document_highlight()
							end,
							buffer = ev.buf,
						})

						vim.api.nvim_create_autocmd("CursorHoldI", {
							group = "LSPDocumentHighlight" .. ev.buf,
							callback = function()
								vim.lsp.buf.clear_references()
							end,
							buffer = ev.buf,
						})
					end

					-- if client.server_capabilities.codeLensProvider then
					--  local au_group = vim.api.nvim_create_augroup("LSPCodeLens" .. ev.buf, {
					--      clear = true,
					--  })

					--  vim.api.nvim_create_autocmd("CursorHold", {
					--      group = au_group,
					--      callback = function()
					--          vim.lsp.codelens.refresh()
					--      end,
					--      buffer = ev.buf,
					--  })
					-- end
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
