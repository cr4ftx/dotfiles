return {
  {
    "saghen/blink.cmp",
    event = { "VeryLazy" },
    dependencies = {
      "rafamadriz/friendly-snippets",
      "Kaiser-Yang/blink-cmp-avante",
    },
    version = "1.*",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = "enter" },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = { documentation = { auto_show = false } },
      sources = {
        default = { "avante", "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          avante = {
            module = "blink-cmp-avante",
            name = "Avante",
            opts = {},
          },
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      enabled = function()
        return not vim.tbl_contains({ "DressingInput" }, vim.bo.filetype)
      end,
    },
    opts_extend = { "sources.default" },
  },
}
