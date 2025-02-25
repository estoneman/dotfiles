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

-- local function is_ansible()
--     local path = vim.fn.expand("%:p")
--     local task_regex = string.format([[ '%s' =~ '\v/(roles|handlers|tasks)/.*\.ya?ml$' ]], path)
--     local var_regex = string.format([[ '%s' =~ '\v/(group|host)_vars/.*\.ya?ml$' ]], path)
-- 
--     if vim.api.nvim_eval(task_regex) ~= 0 then
--         return 1
--     end
-- 
--     if vim.api.nvim_eval(var_regex) ~= 0 then
--         return 1
--     end
-- 
--     return 0
-- end
-- 
-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
--   pattern = "*",
--   group = vim.api.nvim_create_augroup("yaml_ansible", { clear = true }),
--   callback = function ()
--       if is_ansible() == 0 then
--           vim.bo.filetype = "yaml.ansible"
--       end
--   end
-- })

local mason_lspconfig_setup = function()
    local lspconfig = require("lspconfig")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities()
    )

    return {
        ensure_installed = {
            "ansiblels",
            "clangd",
            "gopls",
            "lua_ls",
            "rust_analyzer",
            "ruff",
            "jedi_language_server",
        },

        automatic_installation = false,

        handlers = {
            ["lua_ls"] = function()
                lspconfig["lua_ls"].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "Snacks", "autocmd", "vim", },
                                disable = { "lowercase-global", },
                            }
                        }
                    },
                })
            end,
            ["gopls"] = function()
                lspconfig["gopls"].setup({
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
                    },
                })
            end,
            ["pylsp"] = function()
                lspconfig["pylsp"].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {
                        pylsp = {
                            plugins = {
                                flake8 = { enabled = true },
                                pycodestyle = { enabled = true },
                                mccabe = { enabled = true },
                                pyflakes = { enabled = true },
                            },
                        },
                    },
                })
            end,
            function(server_name)
                lspconfig[server_name].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end,
        },
    }
end

return {
    "neovim/nvim-lspconfig",

    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
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
