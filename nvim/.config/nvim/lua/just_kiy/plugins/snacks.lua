return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = { enabled = true },
        dashboard = { enabled = true },
        explorer = {
            enabled = true,
            replace_netrw = true,
        },
        picker = {
            enabled = true,
            sources = {
                explorer = {
                }
            }
        },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = {
            enabled = true,
            timeout = 3000,
        },
        quickfile = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = {
            enabled = true,
            left = { "mark", "sign" }, -- priority of signs on the left (high to low)
            right = { "fold", "git" }, -- priority of signs on the right (high to low)
            folds = {
                open = false,          -- show open fold icons
                git_hl = false,        -- use Git Signs hl for fold icons
            },
            git = {
                -- patterns to match Git signs
                patterns = { "GitSign", "MiniDiffSign" },
            },
            refresh = 50, -- refresh at most every 50ms
        },
        words = { enabled = true },
        styles = {
            notification = {
                -- wo = { wrap = true } -- Wrap notifications
            },
        },
    },
    keys = {
        { "<leader>pe", function() Snacks.explorer.open() end,           desc = "Open Explorer", },
        { "<leader>z",  function() Snacks.zen() end,                     desc = "Toggle Zen Mode", },
        { "<leader>Z",  function() Snacks.zen.zoom() end,                desc = "Toggle Zoom", },
        { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer", },
        { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer", },
        { "<leader>n",  function() Snacks.notifier.show_history() end,   desc = "Notification History", },
        { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer", },
        { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename File", },
        { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse",                   mode = { "n", "v" }, },
        { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line", },
        { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History", },
        { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit", },
        { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)", },
        { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications", },
        { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",               mode = { "n", "t" }, },
        { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",               mode = { "n", "t" }, },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                Snacks.toggle.diagnostics():map("<leader>ud")
                Snacks.toggle.line_number():map("<leader>ul")
                Snacks.toggle
                    .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
                    :map("<leader>uc")
                Snacks.toggle.treesitter():map("<leader>uT")
                Snacks.toggle
                    .option("background", { off = "light", on = "dark", name = "Dark Background" })
                    :map("<leader>ub")
                Snacks.toggle.inlay_hints():map("<leader>uh")
                Snacks.toggle.indent():map("<leader>ug")
                Snacks.toggle.dim():map("<leader>uD")
            end,
        })
    end,
}
