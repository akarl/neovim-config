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
vim.opt["showmode"] = false
vim.opt["tabstop"] = 4
vim.opt["expandtab"] = true
vim.opt["laststatus"] = 3
vim.opt["backup"] = false
vim.opt["swapfile"] = false
vim.opt["shell"] = "/usr/local/bin/zsh"
vim.opt["equalalways"] = false
vim.opt["grepprg"] = "rg --vimgrep"
vim.opt["inccommand"] = "nosplit"
vim.opt["cmdheight"] = 1
vim.opt["ignorecase"] = true
vim.opt["smartcase"] = true
vim.opt["foldmethod"] = "indent"
vim.opt["foldlevel"] = 0
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
vim.opt["timeoutlen"] = 100

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
