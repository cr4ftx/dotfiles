return {
    {
        "williamboman/mason.nvim",
        event = { "VeryLazy" },
        build = ":MasonUpdate",
        opts = {
            ui = {
                icons = {
                    server_installed = "✓",
                    server_pending = "➜",
                    server_uninstalled = "✗",
                },
            },
        },
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "VeryLazy" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        opts = { automatic_installation = true },
    },
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "VeryLazy" },
        dependencies = { "williamboman/mason.nvim" },
        opts = { automatic_installation = true },
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = { "VeryLazy" },
        dependencies = { "williamboman/mason.nvim" },
        opts = { ensure_installed = { "node2" } },
    },
}
