return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { 'neovim/nvim-lspconfig' },
        config = function()
            require("mason-lspconfig").setup()
        end,
    },
}
