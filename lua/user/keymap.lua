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

	if (type(bufnr) == "boolean" and bufnr) or (type(bufnr) == "number" and bufnr == 0) then
		bufnr = vim.fn.bufnr()
	end

	wk.register({
		[lhs] = { name = desc },
	}, {
		buffer = bufnr,
	})
end

return M
