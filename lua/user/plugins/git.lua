return {
	{
		"lewis6991/gitsigns.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
		opts = {
			signcolumn = true,
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local telescope = require("telescope.builtin")
				local keymap = require("user/keymap")

				-- Navigation
				keymap.register("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk({ preview = true })
					end)
					return "<Ignore>"
				end, "next change", bufnr, { expr = true })

				keymap.register("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk({ preview = true })
					end)
					return "<Ignore>"
				end, "prev change", bufnr, { expr = true })

				-- Actions
				keymap.groupname("<leader>g", "git", bufnr)

				keymap.register("n", "<leader>gg", telescope.git_status, "status", bufnr)

				-- Stage
				keymap.register("n", "<leader>gS", gs.stage_buffer, "stage buffer", bufnr)
				keymap.register("n", "<leader>gs", gs.stage_hunk, "stage hunk", bufnr)
				keymap.register("v", "<leader>gs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "stage hunk", bufnr)

				-- Unstage
				keymap.register("n", "<leader>gu", gs.undo_stage_hunk, "unstage hunk", bufnr)

				-- Blameline
				keymap.register("n", "<leader>gb", function()
					gs.blame_line({ full = true })
				end, "blame line", bufnr)

				-- Diff
				keymap.register("n", "<leader>gd", gs.diffthis, "diff this", bufnr)
				keymap.register("n", "<leader>gp", gs.preview_hunk, "preview hunk", bufnr)

				-- Reset
				keymap.register("n", "<leader>gR", gs.reset_buffer, "reset buffer", bufnr)
				keymap.register("n", "<leader>gr", gs.reset_hunk, "reset hunk", bufnr)
				keymap.register("v", "<leader>gr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, "reset hunk", bufnr)

				-- Toggles
				keymap.groupname("<leader>gT", "toggles", bufnr)
				keymap.register("n", "<leader>gTb", gs.toggle_current_line_blame, "blame lines", bufnr)
				keymap.register("n", "<leader>gTd", gs.toggle_deleted, "signs show deleted", bufnr)

				-- Text object
				keymap.register({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "select hunk", bufnr)
			end,
		},
	},
}
