return {
	"mhartington/formatter.nvim",
	lazy = false,
	config = function()
		local util = require("formatter.util")
		local go = require("formatter.filetypes.go")

		require("formatter").setup({
			filetype = {
				go = {
					go.goimports,
					go.gofumpt,
					{
						exe = "golines",
						stdin = true,
						args = {
							"--chain-split-dots",
							"--shorten-comments",
							"--ignore-generated",
							"--reformat-tags",
						},
					},
					{
						exe = "gosrt",
						stdin = true,
						args = { "--no-backup" },
					},
					{
						exe = "goimports-reviser",
						stdin = false,
						args = {
							"-company-prefixes",
							vim.fn.expand("$GOIMPORTS_REVISER_COMPANY_PREFIXES"),
						},
					},
				},
				sh = { require("formatter.filetypes.sh").shfmt },
				lua = { require("formatter.filetypes.lua").stylua },
				json = { require("formatter.filetypes.json").jq },
				["*"] = {
					-- "formatter.filetypes.any" defines default configurations for any
					-- filetype
					require("formatter.filetypes.any").remove_trailing_whitespace,
				},
			},
		})

		local au_group = vim.api.nvim_create_augroup("AutoformatWrite", {
			clear = true,
		})

		vim.api.nvim_create_autocmd("BufWritePost", {
			group = au_group,
			command = "silent FormatWrite",
		})
	end,
}
