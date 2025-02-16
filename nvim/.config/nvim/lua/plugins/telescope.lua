return {
    "nvim-telescope/telescope.nvim",
    enabled = false,
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-frecency.nvim",
    },
    opts = {
        defaults = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '-uu',
        },
        extensions = {
            frecency = {
                auto_validate = false,
                matcher = "fuzzy",
                path_display = { "filename_first" },
            },
      },
  }
}
