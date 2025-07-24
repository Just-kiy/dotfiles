return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec", "disable.ft", "disable.bt" },
    opts = {
        icons = {
            group = vim.g.icons_enabled ~= false and "" or "+",
            rules = false,
            separator = "-",
        },
        spec = {
            {
                mode = { "n", "v" },
                { "<leader>x", group = "Trouble" },
                { "<leader>g", group = "Git" },
                { "<leader>p", group = "Project" },
            }
        }
    },
}
