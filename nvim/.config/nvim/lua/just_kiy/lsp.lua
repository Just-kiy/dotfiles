vim.lsp.enable({
    "lua_ls",
    "bashls",
    "helm_ls",
    "dockerls",
    "yamlls",
    "ruff",
    "basedpyright",
    "typescript-language-server",
    "vue-language-server",
})

vim.filetype.add({
    filename = {
        ["docker-compose.yml"] = "yaml.docker-compose",
        ["docker-compose.yaml"] = "yaml.docker-compose",
        ["compose.yml"] = "yaml.docker-compose",
        ["compose.yaml"] = "yaml.docker-compose",
    },
})

-- map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
-- map("K", vim.lsp.buf.hover, "Hover Documentation")
-- map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
-- map("gD", vim.lsp.buf.declaration, "Goto Declaration")
-- map("<leader>la", vim.lsp.buf.code_action, "Code Action")
-- map("<leader>lr", vim.lsp.buf.rename, "Rename all references")
-- map("<leader>lf", vim.lsp.buf.format, "Format")

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local buf = args.buf
        local telescope = require("telescope.builtin")

        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = "LSP: " .. desc })
        end

        map("n", "K", vim.lsp.buf.hover, "Hover documentation")
        map("n", "gd", telescope.lsp_definitions, "Goto definition")
        map("n", "gr", telescope.lsp_references, "Goto references")
        map("n", "gD", vim.lsp.buf.declaration, "Goto declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Goto implementation")
        map("n", "go", vim.lsp.buf.type_definition, "Goto type definition")
        map("n", "gs", vim.lsp.buf.signature_help, "Signature help")
        map("n", "<F2>", vim.lsp.buf.rename, "Rename symbol")
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code actions")
        map("n", "<leader>cf", vim.lsp.buf.format, "Format code")
        map("n", "<leader>gv", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto definition (split)")
    end,
})
