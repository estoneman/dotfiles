local conf = {}

local function neofetch()
    local proc_handle = io.popen("neofetch -L | sed -e 's/\27\\[[0-9;\\?]*[a-zA-Z]//g' -e '/^$/d'")
    if proc_handle == nil then
        print("Error: Failed to execute 'neofetch'")
        return ""
    end

    local proc_out = proc_handle:read('a')

    return proc_out
end

local function split(s, sep)
    if sep == nil then
        sep = '\n'
    end

    local t = {}
    table.insert(t, "")
    for line in string.gmatch(s, "([^" .. sep .. "]+)") do
        table.insert(t, line)
    end
    table.insert(t, "")

    return t
end

conf.header = split(neofetch())

conf.center = {
  {
    icon = "󰈞  ",
    desc = "Find  File                              ",
    action = function()
        vim.cmd('Telescope find_files cwd=.')
    end,
    key = "<Leader> f f",
  },
  {
    icon = "󰈢  ",
    desc = "Recently opened files                   ",
    action = function ()
        vim.cmd('Telescope frecency')
    end,
    key = "<Leader> f r",
  },
  {
    icon = "󰈬  ",
    desc = "Project grep                            ",
    action = function()
        vim.cmd('Telescope live_grep')
    end,
    key = "<Leader> f g",
  },
  {
    icon = "  ",
    desc = "Open Nvim config                        ",
    action = "tabnew $MYVIMRC | tcd %:p:h",
    key = "<Leader> e v",
  },
  {
    icon = "  ",
    desc = "New file                                ",
    action = "enew",
    key = "e",
  },
  {
    icon = "󰗼  ",
    desc = "Quit Nvim                               ",
    action = "qa",
    key = "q",
  },
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "dashboard",
  group = vim.api.nvim_create_augroup("dashboard_enter", { clear = true }),
  callback = function ()
    vim.keymap.set("n", "q", ":qa<CR>", { buffer = true, silent = true })
    vim.keymap.set("n", "e", ":enew<CR>", { buffer = true, silent = true })
  end
})

return {
    "nvimdev/dashboard-nvim",
    enabled = false,
    event = "VimEnter",
    config = function()
        require("dashboard").setup({
            theme = 'doom',
            config = conf,
        })
    end,
    dependencies = { {"nvim-tree/nvim-web-devicons"} }
}
