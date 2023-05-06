return {
	"sheerun/vim-polyglot",
	"tpope/vim-commentary",
	"tpope/vim-eunuch",
	"tpope/vim-repeat",

	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"kylechui/nvim-surround",
		version = "*",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},

	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "night",
				on_highlights = function(hl, c)
					hl.StatusLine = { fg = c.bg, bg = c.green }
					hl.StatusLineNC = { fg = c.fg, bg = c.border }
					hl.WinSeparator = { bg = c.border, fg = c.border }
					hl.LspReferenceText = { underline = true, bold = true }
					hl.LspReferenceRead = { underline = true, bold = true }
					hl.LspReferenceWrite = { underline = true, bold = true }
				end,
			})

			vim.cmd("colorscheme tokyonight")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				textobjects = { enable = true },
				incremental_selection = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
}
