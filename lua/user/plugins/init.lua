return {
    "sheerun/vim-polyglot",
    "tpope/vim-commentary",
    "tpope/vim-eunuch",
    "tpope/vim-repeat",

    {
        "stevearc/oil.nvim",
        opts = {},
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    {
        "kylechui/nvim-surround",
        version = "*",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                show_trailing_blankline_indent = false,
                show_first_indent_level = false,
                show_current_context = true,
            })
        end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato", -- latte, frappe, macchiato, mocha
                show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
                term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
                custom_highlights = function(c)
                    return {
                        Comment = { fg = c.overlay0 },
                        Folded = { fg = c.overlay1, bg = c.none },
                    }
                end,
            })

            -- setup must be called before loading
            vim.cmd.colorscheme("catppuccin")
        end,
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
            "neovim/nvim-lspconfig",
        },
        config = function()
            local navic = require("nvim-navic")
            navic.setup({
                highlight = true,
                lsp = {
                    auto_attach = true,
                },
            })

            local filename_section = {
                "filename",
                file_status = true,
                newfile_status = false,
                path = 1,
                shorting_target = 100,
                symbols = {
                    modified = "[+]", -- Text to show when the file is modified.
                    readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
                    unnamed = "[No Name]", -- Text to show for unnamed buffers.
                    newfile = "[New]", -- Text to show for newly created file before first write
                },
            }

            require("lualine").setup({
                options = {
                    theme = "catppuccin",
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { filename_section },
                    lualine_c = { "navic" },
                    lualine_x = {
                        {
                            function()
                                local bufnr = vim.fn.bufnr()
                                local clients = vim.lsp.get_active_clients({ bufnr = bufnr })

                                if #clients == 0 then
                                    return ""
                                end

                                local client = clients[#clients]
                                return client.name
                            end,
                        },
                        "diagnostics",
                        "location",
                    },
                    lualine_y = { "diff" },
                    lualine_z = { "branch" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = { "tabs" },
                },
            })

            vim.opt.showtabline = 1
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                textobjects = { enable = true },
                incremental_selection = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            })
        end,
    },
}
