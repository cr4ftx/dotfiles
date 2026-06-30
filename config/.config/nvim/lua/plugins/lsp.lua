local icons = require("utils.signs")
local map = require("utils.map")

local vue_language_server_path = vim.fn.stdpath("data")
  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}

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
      -- { "folke/neoconf.nvim", opts = {} },
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
          init_options = {
            plugins = { vue_plugin },
            maxTsServerMemory = 8192,
          },
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
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
              schemaDownload = { enable = false },
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
              format = { enable = false },
            },
          },
        },
        {
          "yamlls",
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              schemaStore = { enable = false, url = "" },
              schemas = require("schemastore").yaml.schemas(),
              format = { enable = false },
            },
          },
        },
        "taplo",
        "tailwindcss",
        "dockerls",
        "jedi_language_server",
        "terraformls",
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
        "prisma-language-server",
        "postgres-language-server",
        {
          "vue_ls",
          -- `@vue/language-server` resolves TypeScript with `require('typescript')`
          -- from its own install, where Mason pins `typescript@^7` (the native/Go
          -- preview with no JS API, so `ts.server.protocol` is nil and it crashes).
          -- Pass `--tsdk` explicitly: prefer the project's TypeScript (matching how
          -- `ts_ls` resolves it), else fall back to the JS TypeScript bundled with
          -- `typescript-language-server`.
          cmd = function(dispatchers, config)
            local root = config.root_dir or vim.fn.getcwd()
            local project_tsdk = root .. "/node_modules/typescript/lib"
            local tsdk = vim.uv.fs_stat(project_tsdk) and project_tsdk
              or vim.fn.stdpath("data")
                .. "/mason/packages/typescript-language-server/node_modules/typescript/lib"
            return vim.lsp.rpc.start(
              { "vue-language-server", "--stdio", "--tsdk=" .. tsdk },
              dispatchers
            )
          end,
        },
      }

      local capabilities = require("blink.cmp").get_lsp_capabilities()

      for _, lsp in ipairs(servers) do
        local lsp_type = type(lsp)

        if lsp_type == "string" then
          vim.lsp.config(lsp, { capabilities = capabilities })
        elseif lsp_type == "table" then
          vim.lsp.config(lsp[1], {
            cmd = lsp.cmd,
            filetypes = lsp.filetypes,
            root_dir = lsp.root_dir,
            single_file_support = lsp.single_file_support,
            capabilities = capabilities,
            settings = lsp.settings,
            on_init = lsp.on_init,
            init_options = lsp.init_options,
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
