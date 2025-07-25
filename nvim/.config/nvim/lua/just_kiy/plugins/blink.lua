return
{
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },

    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = 'default',
            ['<CR>'] = { 'accept', 'fallback' },
        },
        appearance = {
            nerd_font_variant = 'mono'
        },
        completion = {
            documentation = {
                auto_show = false
            },
            list = {
                selection = {
                    preselect = false
                }
            }
        },

        signature = { enabled = true },

        sources = {
            default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
