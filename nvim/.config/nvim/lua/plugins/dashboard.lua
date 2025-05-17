local conf = {}

---capture command output into stdout
---@param cmd string
---@param raw boolean
local function cmdCapture(cmd, raw)
    local proc = assert(io.popen(cmd, 'r'))
    local out = assert(proc:read('*a'))

    proc:close()

    if raw then return out end

    out = string.gsub(out, '^%s+', '')
    out = string.gsub(out, '%s+$', '')

    return out
end

conf.header = cmdCapture("neofetch -L", true)

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
