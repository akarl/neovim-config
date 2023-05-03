return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope-file-browser.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope/builtin")
			local actions = require("telescope/actions")
			local state = require("telescope/actions/state")

			require("telescope").setup({
				defaults = {
					mappings = {
						i = { ["<esc>"] = "close" },
					},
				},
				pickers = {
					buffers = {
						theme = "ivy",
						sort_mru = true,
						mappings = {
							i = {
								["<C-space>"] = function(prompt_bufnr)
									local input = state.get_current_line()
									actions.close(prompt_bufnr)
									builtin.find_files({ default_text = input })
								end,
							},
						},
					},
					find_files = {
						theme = "ivy",
						mappings = {
							i = {
								["<C-space>"] = function(prompt_bufnr)
									local input = state.get_current_line()
									actions.close(prompt_bufnr)
									builtin.buffers({ default_text = input })
								end,
							},
						},
					},
				},
				extensions = {
					file_browser = {
						theme = "ivy",
						grouped = true,
						respect_gitignore = true,
						hide_parent_dir = true,
						prompt_path = true,
					},
				},
			})

			telescope.load_extension("file_browser")

			local keymap = require("user/keymap")

			keymap.register("n", "<C-space>", builtin.buffers, "buffers")

			keymap.register("n", "-", function()
				telescope.extensions.file_browser.file_browser({
					path = "%:h",
				}, "file browser")
			end, {})
		end,
	},
}
