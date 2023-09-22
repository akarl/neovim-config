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

vim.opt["autoindent"] = true
vim.opt["backup"] = false
vim.opt["breakindent"] = true
vim.opt["clipboard"] = "unnamedplus"
vim.opt["cmdheight"] = 1
vim.opt["colorcolumn"] = "9999"
vim.opt["cursorline"] = true
vim.opt["encoding"] = "utf-8"
vim.opt["equalalways"] = false
vim.opt["expandtab"] = true
vim.opt["exrc"] = true
vim.opt["foldenable"] = false
vim.opt["foldlevel"] = 0
vim.opt["foldmethod"] = "indent"
vim.opt["grepprg"] = "rg --vimgrep"
vim.opt["hidden"] = true
vim.opt["ignorecase"] = true
vim.opt["inccommand"] = "nosplit"
vim.opt["laststatus"] = 3
vim.opt["linebreak"] = false
vim.opt["mouse"] = "a"
vim.opt["number"] = false
vim.opt["scrolloff"] = 5
vim.opt["shell"] = "/usr/local/bin/zsh"
vim.opt["shiftwidth"] = 4
vim.opt["showmode"] = false
vim.opt["sidescroll"] = 1
vim.opt["sidescrolloff"] = 5
vim.opt["signcolumn"] = "yes:2"
vim.opt["smartcase"] = true
vim.opt["swapfile"] = false
vim.opt["tabstop"] = 4
vim.opt["timeoutlen"] = 100
vim.opt["wrap"] = false

-- Ensures that we are always relative to the current directory.
vim.api.nvim_create_autocmd("BufWinEnter", { command = "cd ." })

vim.api.nvim_create_autocmd("WinLeave", {
    callback = function(args)
        vim.opt["cursorline"] = false
    end,
})

vim.api.nvim_create_autocmd("WinEnter", {
    callback = function(args)
        vim.opt["cursorline"] = true
    end,
})

require("user/diagnostics").setup()
