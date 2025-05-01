local icons = require("utils.signs")
local map = require("utils.map")

return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        {
          path = "${3rd}/luv/library",
          words = { "vim%.uv" },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "VeryLazy" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp",
      "b0o/schemastore.nvim",
      { "folke/neoconf.nvim", opts = {} },
    },
    config = function()
      vim.diagnostic.config({
        float = true,
        jump = { float = true },
        virtual_text = true,
      })

      for name, icon in pairs(icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        -- stylua: ignore
        callback = function(ev)
          map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code actions" })
        end,
      })

      local servers = {
        {
          "lua_ls",
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              format = { enable = false },
              completion = { callSnippet = "Replace" },
            },
          },
        },
        "bashls",
        {
          "ts_ls",
          single_file_support = false,
          settings = {
            javascript = {
              format = { enable = false },
              suggest = { completeFunctionCalls = true },
            },
            typescript = {
              format = { enable = false },
              suggest = { completeFunctionCalls = true },
            },
          },
        },
        "html",
        "cssls",
        {
          "jsonls",
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
              format = { enable = false },
            },
          },
        },
        {
          "yamlls",
          settings = {
            yaml = {
              schemaStore = { enable = false, url = "" },
              schemas = require("schemastore").yaml.schemas(),
              format = { enable = false },
              redhat = { telemetry = { enabled = false } },
            },
          },
        },
        "taplo",
        "tailwindcss",
        "dockerls",
        "jedi_language_server",
        "terraformls",
        "biome",
        {
          "graphql",
          filetypes = {
            "graphql",
            "typescriptreact",
            "javascriptreact",
          },
        },
        "pbls",
        "rust_analyzer",
      }

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      for _, lsp in ipairs(servers) do
        local lsp_type = type(lsp)

        if lsp_type == "string" then
          vim.lsp.config(lsp, { capabilities = capabilities })
        elseif lsp_type == "table" then
          vim.lsp.config(lsp[1], {
            filetypes = lsp.filetypes,
            root_dir = lsp.root_dir,
            single_file_support = lsp.single_file_support,
            capabilities = capabilities,
            settings = lsp.settings,
          })
        end
      end
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    opts = {},
  },
}
