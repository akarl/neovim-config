return {
    "mfussenegger/nvim-lint",
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            yaml = { "yamllint" },
            json = { "jsonlint" },
            sh = { "shellcheck" },
            -- gitcommit = { "commitlint" }
        }

        local au_group = vim.api.nvim_create_augroup("Linting", {
            clear = true,
        })

        vim.api.nvim_create_autocmd("CursorHold", {
            group = au_group,
            callback = function()
                lint.try_lint()
            end,
        })
    end

}
