local debug_mode = false
local default_runner = "gotest"

vim.g["test#go#runner"] = default_runner
vim.g["test#go#gotest#executable"] = "go test -timeout 30s"

local keymap = require("user/keymap")

keymap.groupname("<leader>b", "debugger", true)

keymap.register("n", "<leader>bb", ":DlvToggleBreakpoint<cr>", "toggle breakpoint", true)

keymap.register("n", "<leader>bt", function()
	debug_mode = not debug_mode

	if debug_mode then
		vim.g["test#go#runner"] = "delve"
		print("Debug ON")
	else
		vim.g["test#go#runner"] = default_runner
		print("Debug OFF")
	end
end, "toggle test debug", true)
