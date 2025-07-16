return {
    cmd = { "pylsp" },
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
}
