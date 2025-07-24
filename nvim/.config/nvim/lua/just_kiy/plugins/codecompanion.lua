return {
    {
        -- Core plugin
        "olimorris/codecompanion.nvim",
        event        = "VeryLazy",
        version      = false,  -- pin to a commit/tag if you like
        build        = "make", -- build step for native bits (if any)

        -- Dependencies: plenary + nui are required by Code Companion itself,
        -- render-markdown renders the CC pane nicely.
        dependencies = {
            "nvim-lua/plenary.nvim",
            "ravitemer/codecompanion-history.nvim", -- Save and load conversation history
            "MunifTanjim/nui.nvim",

            {
                "MeanderingProgrammer/render-markdown.nvim",
                -- render-markdown should activate for CC buffers (filetype "CC")
                ft   = { "markdown", "CC" },
                opts = {
                    file_types = { "markdown", "CC" },
                },
            },
            {
                "echasnovski/mini.diff",
                version = false,
                config = function()
                    require('mini.diff').setup()
                end,
            }
        },
        opts = {
            adapters = {
                aitunnel = function()
                    return require("codecompanion.adapters").extend("openai_compatible", {
                        env = {
                            url = "https://api.aitunnel.ru",
                            api_key = "AITUNNEL_API_KEY",
                            chat_url = "/v1/chat/completions",
                            models_endpoint = "/v1/models",
                        },
                        schema = {
                            model = {
                                default = "codex-mini"
                            }
                        },
                    })
                end
            }
        },
    }
}
