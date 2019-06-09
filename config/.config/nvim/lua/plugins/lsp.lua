local icons = require("utils.signs")

return {
    {
        "neovim/nvim-lspconfig",
        event = { "VeryLazy" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "b0o/schemastore.nvim",
            { "folke/neodev.nvim", opts = {} },
            { "folke/neoconf.nvim", opts = {} },
        },
        config = function()
            local opts = { noremap = true, silent = true }

            vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

            for name, icon in pairs(icons.diagnostics) do
                name = "DiagnosticSign" .. name
                vim.fn.sign_define(
                    name,
                    { text = icon, texthl = name, numhl = "" }
                )
            end

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                -- stylua: ignore
                callback = function()
                    -- Mappings.
                    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set("n", "<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                end,
            })

            local lspconfig = require("lspconfig")
            local servers = {
                "lua_ls",
                "bashls",
                {
                    "tsserver",
                    root_dir = lspconfig.util.find_package_json_ancestor,
                    single_file_support = false,
                },
                {
                    "denols",
                    root_dir = lspconfig.util.root_pattern(
                        "deno.json",
                        "deno.jsonc"
                    ),
                },
                "html",
                "cssls",
                "jsonls",
                "yamlls",
                -- "cssmodules_ls",
                {
                    "tailwindcss",
                    root_dir = lspconfig.util.root_pattern(
                        "tailwind.config.js"
                    ),
                },
                "dockerls",
                "jedi_language_server",
                "terraformls",
                "eslint",
                {
                    "graphql",
                    filetypes = {
                        "graphql",
                        "typescriptreact",
                        "javascriptreact",
                    },
                },
            }

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            for _, lsp in ipairs(servers) do
                local lsp_type = type(lsp)

                if lsp_type == "string" then
                    lspconfig[lsp].setup({ capabilities = capabilities })
                elseif lsp_type == "table" then
                    lspconfig[lsp[1]].setup({
                        filetypes = lsp.filetypes,
                        root_dir = lsp.root_dir,
                        single_file_support = lsp.single_file_support,
                        capabilities = capabilities,
                    })
                end
            end
        end,
    },
    {
        "mrded/nvim-lsp-notify",
        opts = {},
        event = "VeryLazy",
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
    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
            doc_lines = 0,
            hint_enable = false,
            max_width = 240,
        },
    },
}
