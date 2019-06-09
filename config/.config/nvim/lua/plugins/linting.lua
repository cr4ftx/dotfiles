return {
    {
        "nvimtools/none-ls.nvim",
        event = { "VeryLazy" },
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            local null_ls = require("null-ls")

            local sources = {
                -- node
                null_ls.builtins.formatting.prettierd,
                -- python
                null_ls.builtins.formatting.black,
                -- terraform
                null_ls.builtins.diagnostics.terraform_validate,
                null_ls.builtins.formatting.terraform_fmt,
                -- sql
                null_ls.builtins.formatting.sql_formatter,
                -- lua
                null_ls.builtins.formatting.stylua,
                -- git
                null_ls.builtins.code_actions.gitsigns,
            }

            null_ls.setup({ sources = sources })
        end,
    },
}
