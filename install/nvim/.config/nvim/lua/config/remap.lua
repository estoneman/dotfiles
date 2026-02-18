local keymap = vim.keymap
local cmd = vim.cmd
local ls = require("luasnip")
local explorer = require("snacks.explorer")
local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")

-- general
keymap.set("n", "<leader>pv", cmd.Ex, {
    desc = "Return to netrw"
})

keymap.set("n", "<leader>ch", cmd.checkhealth, {
    desc = "Run checkhealth"
})

keymap.set("n", "<leader>qa", function()
    if vim.bo.filetype == 'snacks_picker_list' then
        -- actually toggles close
        explorer.open()
    end
    cmd("qa")
end, {
    desc = "Close all windows including explorer"
})

-- harpoon
keymap.set("n", "<leader>ha", harpoon_mark.add_file, {
    desc = "harpoon.mark.add_file: you mark files you want to revisit later on",
})

keymap.set("n", "<leader>ht", harpoon_ui.toggle_quick_menu, {
    desc = "harpoon.ui.toggle_quick_menu: view all project marks",
})

-- navigation
---- tab
keymap.set("n", "<leader>tl", ":-tabm<cr>", {
    desc = "Move one tab left",
})

keymap.set("n", "<leader>tr", ":+tabm<cr>", {
    desc = "Move one tab right",
})

-- pane
keymap.set("n", "<c-l>", ":wincmd l | echon<cr>", {
    desc = "Move pane - right"
})

keymap.set("n", "<c-h>", ":wincmd h | echon<cr>", {
    desc = "Move pane - left"
})

keymap.set("n", "<c-j>", ":wincmd j | echon<cr>", {
    desc = "Move pane - down"
})

keymap.set("n", "<c-k>", ":wincmd k | echon<cr>", {
    desc = "Move pane - up"
})

-- lazy
keymap.set("n", "<leader>lz", Lazy.home, {
    desc = ":Lazy home: go to Lazy vim's home menu"
})

keymap.set("n", "<leader>lu", Lazy.update, {
    desc = ":Lazy update: update installed plugins in Lazy"
})

keymap.set("n", "<leader>lc", Lazy.check, {
    desc = ":Lazy check: check for updates of installed plugins in Lazy"
})

keymap.set("n", "<leader>lr", Lazy.reload, {
    desc = ":Lazy reload: reload Lazy configuration (e.g., pick up new plugins in real-time)",
})

---- lspconfig
keymap.set("n", "<leader>ll", cmd.LspLog, {
    desc = ":LspLog: show logs of lsp clients"
})

keymap.set("n", "<leader>li", cmd.LspInfo, {
    desc = ":LspInfo: show active lsp clients"
})

-- mason
keymap.set("n", "<leader>ma", cmd.Mason, {
    desc = ":Mason: go to Mason home menu"
})

keymap.set("n", "<leader>ml", cmd.MasonLog, {
    desc = ":MasonLog: view logs for Mason",
})

keymap.set("n", "<leader>mr", cmd.MasonUpdate, {
    desc = ":MasonLog: update Mason registries",
})

-- wit
keymap.set("n", "<leader>ws", ":WitSearch ", {
    desc = ":WitSearch: open cmdline for adding search terms"
})

-- luasnip
keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

keymap.set({"i", "s"}, "<C-E>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, {silent = true})
