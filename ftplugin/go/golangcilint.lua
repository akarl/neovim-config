require("user/keymap").register("n", "<leader>L", function()
	-- Run only the typecheck first.
	local errors = vim.json.decode(
		vim.fn.system("golangci-lint run --no-config --disable-all -E typecheck --out-format json")
	)

	if errors == nil then
		return
	end

	if #errors == 0 then
		errors = vim.json.decode(vim.fn.system("golangci-lint run --out-format json"))
		if errors == nil then
			return
		end
	end

	if #errors == 0 then
		print("GolangCI Lint OK!")
	end

	local issues = errors.Issues
	local qflist = {}

	for _, issue in pairs(issues) do
		local what = {
			filename = issue.Pos.Filename,
			text = issue.Text,
			type = "E",
		}

		if issue.LineRange then
			what.lnum = issue.LineRange.From
			what.end_lnum = issue.LineRange.To
		else
			what.lnum = issue.Pos.Line
			what.col = issue.Pos.Column
			what.vcol = true
		end

		table.insert(qflist, what)
	end

	vim.fn.setqflist(qflist)
	vim.cmd("copen")
end, "GolangCI Lint", true)
