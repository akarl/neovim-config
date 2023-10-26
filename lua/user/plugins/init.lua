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
            require("ibl").setup()
            -- {
            --     show_trailing_blankline_indent = false,
            --     show_first_indent_level = false,
            --     show_current_context = true,
            -- })
        end,
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "macchiato",     -- latte, frappe, macchiato, mocha
                show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
                term_colors = true,        -- sets terminal colors (e.g. `g:terminal_color_0`)
                custom_highlights = function(c)
                    return {
                        Comment = { fg = c.overlay0 },
                        Folded = { fg = c.overlay1, bg = c.none },
                        VertSplit = { fg = c.mantle, bg = c.mantle },

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
                shorting_target = 40,
                symbols = {
                    modified = "[+]",      -- Text to show when the file is modified.
                    readonly = "[-]",      -- Text to show when the file is non-modifiable or readonly.
                    unnamed = "[No Name]", -- Text to show for unnamed buffers.
                    newfile = "[New]",     -- Text to show for newly created file before first write
                },
            }

            local lsp_section = {
                function()
                    local clients = vim.lsp.get_active_clients()

                    if #clients == 0 then
                        return ""
                    end

                    local names = {}

                    for _, client in ipairs(clients) do
                        if client.name == "copilot" then
                            goto continue
                        end
                        if client.name == "null-ls" then
                            goto continue
                        end

                        table.insert(names, client.name)

                        ::continue::
                    end

                    if #names == 0 then
                        return ""
                    end

                    return table.concat(names, " ")
                end,
            }

            require("lualine").setup({
                options = {
                    theme = "catppuccin",
                },
                sections = {
                    lualine_a = { filename_section },
                    lualine_b = {
                        {
                            "navic",
                            color_correction = "dynamic",
                            navic_opts = { highlight = false },
                            draw_empty = false
                        },
                    },
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {
                        { "diagnostics", draw_empty = false },
                    },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = { filename_section },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                inactive_winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {
                    lualine_a = {
                        function()
                            local mode = require('lualine.utils.mode').get_mode()
                            local dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

                            if mode == "NORMAL" then
                                -- Return the current cwd path.
                                return dir
                            end

                            return mode
                        end,
                    },
                    lualine_b = {},
                    lualine_c = {
                        {
                            "tabs",
                            use_mode_colors = false,
                        },
                    },
                    lualine_x = { lsp_section },
                    lualine_y = { "diff" },
                    lualine_z = { "branch" },
                },
            })

            -- vim.opt.showtabline = 1
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
