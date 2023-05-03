local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup("user/plugins", {
	install = {
		colorscheme = { "tokyonight" },
	},
})

vim.opt["exrc"] = true
vim.opt["encoding"] = "utf-8"
vim.opt["mouse"] = "a"
vim.opt["clipboard"] = "unnamedplus"
vim.opt["number"] = false
vim.opt["colorcolumn"] = "9999"
vim.opt["shiftwidth"] = 4
vim.opt["tabstop"] = 4
vim.opt["expandtab"] = true
vim.opt["laststatus"] = 2
vim.opt["backup"] = false
vim.opt["swapfile"] = false
vim.opt["shell"] = "/usr/local/bin/zsh"
vim.opt["equalalways"] = false
vim.opt["grepprg"] = "rg --vimgrep"
vim.opt["inccommand"] = "nosplit"
vim.opt["cmdheight"] = 0
vim.opt["ignorecase"] = true
vim.opt["smartcase"] = true
-- vim.opt["wildmode"] = "longest:full"
-- vim.opt["completeopt"] = "menu,menuone,noselect"
vim.opt["signcolumn"] = "yes:2"
vim.opt["hidden"] = true
vim.opt["cursorline"] = true
vim.opt["wrap"] = false
vim.opt["linebreak"] = false
vim.opt["breakindent"] = true
vim.opt["sidescroll"] = 1
vim.opt["sidescrolloff"] = 5
vim.opt["scrolloff"] = 5
vim.opt["autoindent"] = true
vim.opt["timeoutlen"] = 700
-- vim.opt["fillchars"] = "stl: ,stlnc: ,fold: ,diff: "

-- Ensures that we are always relative to the current directory.
vim.api.nvim_create_autocmd("BufWinEnter", { command = "cd ." })

require("user/diagnostics").setup()
