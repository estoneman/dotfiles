local colorscheme = {
    lazy = false,
    priority = 1000,
    kanagawa = {
        "rebelot/kanagawa.nvim",
        init = function()
            vim.cmd("colorscheme kanagawa-dragon")
        end,
        name = "kanagawa",
        opts = {
            commentStyle = {
                italic = false
            },
            keywordStyle = {
                italic = false
            },
            theme = "dragon",
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none"
                        }
                    }
                }
            },
            overrides = function(colors)
                local theme = colors.theme

                return {
                    String = {
                        bg = nil,
                        fg = colors.palette.springGreen,
                        italic = false,
                    },
                    Function = {
                        bg = nil,
                        fg = colors.palette.carpYellow,
                    },

                    NormalFloat = { bg = "none" },
                    FloatBorder = { bg = "none" },
                    FloatTitle = { bg = "none" },

                    -- Save an hlgroup with dark background and dimmed foreground
                    -- so that you can use it where your still want darker windows.
                    -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                    NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                    -- Popular plugins that open floats will link to NormalFloat by default;
                    -- set their background accordingly if you wish to keep them dark and borderless
                    LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                }
            end,
        },
    },
    rose_pine = {
        "rose-pine/neovim",
        name = "rose-pine",
        init = function()
            vim.cmd("colorscheme rose-pine")
        end,
        opts = {
            styles = {
                bold = false,
                italic = false,
            },
        },
    },
}

return colorscheme["rose_pine"]
