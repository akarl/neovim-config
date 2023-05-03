local M = {}

M.register = function(mode, lhs, rhs, desc, bufnr, opts)
	if opts == nil then
		opts = {}
	end

	opts.desc = desc
	opts.buffer = bufnr

	vim.keymap.set(mode, lhs, rhs, opts)
end

M.groupname = function(lhs, desc, bufnr)
	-- vim.keymap.set("n", lhs, "", { buffer = bufnr, desc = desc })

	local wk = require("which-key")

	wk.register({
		[lhs] = { name = desc },
	}, {
		buffer = bufnr,
	})
end

return M
