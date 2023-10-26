return {
	{
		"vim-test/vim-test",
		dependencies = {
			"jgdavey/tslime.vim",
			"kassio/neoterm",
			"sebdah/vim-delve", -- Only so we can set breakpoints that are used by vim-test.
		},
		config = function()
			vim.g["test#strategy"] = "neoterm"
			vim.g["test#preserve_screen"] = 1
			vim.g["test#echo_command"] = 0
			vim.g["test#neovim#start_normal"] = 1
			vim.g["neoterm_default_mod"] = "botright 10split"

			local keymap = require("user/keymap")

			keymap.groupname("<leader>t", "test")
			keymap.register("n", "<leader>tn", ":TestNearest<cr>", "test nearest")
			keymap.register("n", "<leader>tl", ":TestLast<cr>", "test last")
			keymap.register("n", "<leader>tR", function()
				vim.g["tslime"] = nil
				vim.g["test#last_command"] = nil
			end, "reset")
		end,
	},
}
