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
    "williamboman/mason-lspconfig.nvim",
    event = { "VeryLazy" },
    dependencies = { "williamboman/mason.nvim" },
    opts = { automatic_installation = true },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = { "VeryLazy" },
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
    opts = { ensure_installed = { "js" } },
  },
  {
    "zapling/mason-conform.nvim",
    event = { "VeryLazy" },
    dependencies = {
      "williamboman/mason.nvim",
      "stevearc/conform.nvim",
    },
    opts = {},
  },
}
