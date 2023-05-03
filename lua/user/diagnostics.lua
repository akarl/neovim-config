local M = {}

M.setup = function()
	vim.diagnostic.config({
		underline = false,
		virtual_text = false,
		severity_sort = true,
		signs = true,
	})

	local keymap = require("user/keymap")

	keymap.register("n", "]e", vim.diagnostic.goto_next, "next diagnostic")
	keymap.register("n", "[e", vim.diagnostic.goto_prev, "prev diagnostic")

	vim.api.nvim_create_user_command("DiagnosticsToQuickfix", vim.diagnostic.setqflist, {})

	-- Update Quickfix with new diagnostics if Quickfix is opened and contains diagnostics.
	vim.api.nvim_create_autocmd("DiagnosticChanged", {
		callback = function()
			local qflist = vim.fn.getqflist({
				title = true,
				qfbufnr = true,
			})

			if qflist.qfbufnr == 0 then
				-- Quickfix buffer doesn't exist so we won't update.
				return
			end

			if vim.fn.bufwinnr(qflist.qfbufnr) == -1 then
				-- Quickfix window isn't opened so we won't update.
				return
			end

			if qflist.title ~= "Diagnostics" then
				-- Quickfix doesn't contain Diagnostics so we won't override it.
				-- Diagnostics is the default name when doing vim.diagnostic.setqflist().
				return
			end

			vim.diagnostic.setqflist({ open = false })
		end,
	})
end

return M
