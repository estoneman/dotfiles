local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
        { desc = "Rename symbol in buffer" },
        opts
    )
    vim.keymap.set("n", "ge", vim.diagnostic.open_float,
        { desc = "Open diagnostics in floating window" },
        opts
    )
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,
        { desc = "Go to previous diagnostic" },
        opts
    )
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next,
        { desc = "Go to next diagnostic" },
        opts
    )
end

local mason_lspconfig_setup = function()
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities()
    )

    vim.lsp.config("lua_ls", {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "Snacks", "autocmd", "vim", },
                },
            },
        }
    })
    vim.lsp.config("gopls", {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
                gofumpt = true,
            },
        }
    })
    vim.lsp.config("pylsp", {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            pylsp = {
                plugins = {
                    flake8 = { enabled = true },
                    pycodestyle = { enabled = false },
                    mccabe = { enabled = false },
                    pyflakes = { enabled = false },
                },
            },
        }
    })
    vim.lsp.config("clangd", {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {},
    })

    return {
        ensure_installed = {
            "ansiblels",
            "clangd",
            "gopls",
            "lua_ls",
            "rust_analyzer",
            "ruff",
            "pylsp",
        },
    }
end

return {
    "neovim/nvim-lspconfig",

    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lua",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "onsails/lspkind.nvim",
    },

    config = function ()
        require("mason").setup({})
        require("mason-lspconfig").setup(mason_lspconfig_setup())
        require("fidget").setup({})

        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local lspkind = require("lspkind")

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),

            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },

            sources = cmp.config.sources({
                { name = "nvim_lua" },
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                { name = "buffer", keyword_length = 5, max_item_count = 20, },
            }),

            formatting = {
                format = lspkind.cmp_format({
                    with_text = true,
                    menu = {
                        buffer = "[buf]",
                        nvim_lsp = "[lsp]",
                        nvim_lua = "[api]",
                        path = "[path]",
                        luasnip = "[snip]",
                    },
                }),
            },
        })
    end,
}
