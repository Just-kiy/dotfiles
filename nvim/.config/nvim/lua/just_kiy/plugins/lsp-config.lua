local servers = {
    "lua_ls",
    "pylsp",
    "gopls",
    "bashls",
    "docker_compose_language_service",
    "dockerls",
    "helm_ls",
    "yamlls",
    -- "basedpyright",
    -- "ruff",
}

return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = servers,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local lspconfig = require("lspconfig")

            -- Base config for all servers
            local default_config = {
                capabilities = capabilities,
            }

            -- Server-specific overrides (deep merged)
            local server_configs = {
                pylsp = {
                    settings = {
                        pylsp = {
                            plugins = {
                                ruff = {
                                    enabled = true,
                                    formatEnabled = true,
                                    formatOnSave = true,
                                },
                                jedi_completion = { enabled = false },
                                jedi_rename = { enabled = false },
                                rope_completion = { enabled = true },
                                rope_autoimport = {
                                    enabled = true,
                                    completions = { enabled = true },
                                    code_actions = { enabled = true },
                                },
                                pylsp_rope = {
                                    enabled = true,
                                    rename = true,
                                },
                                rope_rename = { enabled = false },
                                pylsp_mypy = { enabled = false },
                            },
                        },
                    },
                },
            }

            -- Auto-configure all servers
            for _, server in ipairs(servers) do
                local config = vim.tbl_deep_extend(
                    "force",
                    {},
                    default_config,
                    server_configs[server] or {}
                )
                lspconfig[server].setup(config)
            end

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            local telescope = require("telescope.builtin")
            vim.keymap.set("n", "gd", telescope.lsp_definitions, {})
            vim.keymap.set("n", "gr", telescope.lsp_references, {})
            -- vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", {})
            -- vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", {})
            vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", {})
            vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", {})
            vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", {})
            vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", {})
            vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})

            vim.filetype.add({
                filename = {
                    ["docker-compose.yml"] = "yaml.docker-compose",
                    ["docker-compose.yaml"] = "yaml.docker-compose",
                    ["compose.yml"] = "yaml.docker-compose",
                    ["compose.yaml"] = "yaml.docker-compose",
                },
            })
        end,
    },
}
