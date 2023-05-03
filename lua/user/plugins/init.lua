return {
	"sheerun/vim-polyglot",
	"tpope/vim-commentary",
	"tpope/vim-eunuch",
	-- "tpope/vim-repeat",
	-- "tpope/vim-surround",

	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
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
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
				incremental_selection = {
					enable = true,
				},
				indent = {
					enable = false,
				},
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter.configs").setup({})
		end,
	},

	{
		"lewis6991/gitsigns.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		opts = {
			signcolumn = true,
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local keymap = require("user/keymap")

				-- Navigation
				keymap.register("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, "next change", bufnr, { expr = true })

				keymap.register("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, "prev change", bufnr, { expr = true })

				-- Actions
				keymap.groupname("<leader>g", "git", bufnr)
				keymap.register("n", "<leader>gs", gs.stage_hunk, "stage hunk", bufnr)
				keymap.register("n", "<leader>gr", gs.reset_hunk, "reset hunk", bufnr)
				keymap.register("v", "<leader>gs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "stage hunk", bufnr)
				keymap.register("v", "<leader>gr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "reset hunk", bufnr)
				keymap.register("n", "<leader>gS", gs.stage_buffer, "stage buffer", bufnr)
				keymap.register("n", "<leader>gu", gs.undo_stage_hunk, "unstage hunk", bufnr)
				keymap.register("n", "<leader>gR", gs.reset_buffer, "reset buffer", bufnr)
				keymap.register("n", "<leader>gp", gs.preview_hunk, "preview hunk", bufnr)
				keymap.register("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end, "blame line", bufnr)
				keymap.register("n", "<leader>gd", gs.diffthis, "diff this", bufnr)
				keymap.register("n", "<leader>gD", function()
					gs.diffthis("~")
				end, "diff this 2", bufnr)

				keymap.groupname("<leader>gT", "toggles", bufnr)
				keymap.register("n", "<leader>gTb", gs.toggle_current_line_blame, "blame lines", bufnr)
				keymap.register("n", "<leader>gTd", gs.toggle_deleted, "signs show deleted", bufnr)

				-- Text object
				keymap.register({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "select hunk", bufnr)
			end,
		},
	},
}
