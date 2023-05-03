return {
	{
		"vim-test/vim-test",
		dependencies = {
			"jgdavey/tslime.vim",
			"sebdah/vim-delve", -- Only so we can set breakpoints that are used by vim-test.
		},
		config = function()
			vim.g["test#strategy"] = "tslime"
			vim.g["test#go#runner"] = "gotest"

			local golang = {
				default = "gotest",
				debug_mode = "delve",
			}

			local debug_mode = false

			vim.api.nvim_create_user_command("TestDebugToggle", function()
				debug_mode = not debug_mode

				if debug_mode == true then
					vim.g["test#go#runner"] = golang.debug_mode
					print("Debug ON")
				else
					vim.g["test#go#runner"] = golang.default
					print("Debug OFF")
				end
			end, {})

			vim.api.nvim_create_user_command("TestReset", function()
				vim.g["tslime"] = nil
				vim.g["test#last_command"] = nil
			end, {})

			vim.api.nvim_create_user_command("BreakpointToggle", ":DlvToggleBreakpoint", {})

			local keymap = require("user/keymap")

			keymap.groupname("<leader>t", "test")
			keymap.register("n", "<leader>tn", ":TestNearest<cr>", "test nearest")
			keymap.register("n", "<leader>tl", ":TestLast<cr>", "test last")

			keymap.groupname("<leader>b", "debugger")
			keymap.register("n", "<leader>bb", ":BreakpointToggle<cr>", "toggle breakpoint")
		end,
	},
}
