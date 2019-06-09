local signs = require("utils.signs")

local disable_filetypes = {
    "NvimTree",
    "dashboard",
    "DiffviewFiles",
    "DressingInput",
    "DressingSelect",
}

return {
    {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        opts = {
            config = {
                disable_move = true,
                header = signs.dashboard,
                project = {
                    enable = false,
                },
                mru = { limit = 5 },
                shortcut = {
                    {
                        desc = "Find files",
                        key = "f",
                        action = "Telescope find_files",
                    },
                    {
                        desc = "Load current session",
                        key = "s",
                        action = function()
                            local ok = pcall(require("persistence").load)
                            if ok then
                                vim.notify("Last sessions loaded")
                            else
                                vim.notify(
                                    "Error when loading the last session"
                                )
                            end
                        end,
                    },
                    {
                        desc = "Lazy",
                        key = "l",
                        action = "Lazy",
                    },
                    {
                        desc = "Mason",
                        key = "m",
                        action = "Mason",
                    },
                    {
                        desc = "Quit",
                        key = "q",
                        action = "quit",
                    },
                },
            },
        },
        dependencies = "nvim-tree/nvim-web-devicons",
    },
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "folke/trouble.nvim",
        },
        keys = {
            { "<C-p>", "<cmd>Telescope find_files<cr>" },
            { "<C-g>", "<cmd>Telescope live_grep<cr>" },
            { "<C-n>", "<cmd>Telescope grep_string<cr>" },
            { "gd", "<cmd>Telescope lsp_definitions<cr>" },
            { "gi", "<cmd>Telescope lsp_implementations<cr>" },
            { "gr", "<cmd>Telescope lsp_references<cr>" },
            { "gD", "<cmd>Telescope lsp_type_definitions<cr>" },
            { "<leader>gb", "<cmd>Telescope git_branches<cr>" },
        },
        cmd = "Telescope",
        config = function()
            local telescope = require("telescope")
            local trouble = require("trouble.providers.telescope")
            telescope.setup({
                defaults = {
                    mappings = {
                        i = { ["<c-q>"] = trouble.smart_open_with_trouble },
                        n = { ["<c-q>"] = trouble.smart_open_with_trouble },
                    },
                    file_ignore_patterns = { "^.git/" },
                    vimgrep_arguments = {
                        "rg",
                        "--trim",
                        "--color=never",
                        "--vimgrep",
                        "--smart-case",
                        "--hidden",
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        version = false,
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        ft = {
            "astro",
            "glimmer",
            "handlebars",
            "handlebars",
            "javascript",
            "javascriptreact",
            "jsx",
            "markdown",
            "php",
            "rescript",
            "svelte",
            "tsx",
            "typescript",
            "typescriptreact",
            "vue",
            "xml",
            "html",
        },
        opts = {},
        dependencies = "nvim-treesitter/nvim-treesitter",
    },
    {
        "norcalli/nvim-colorizer.lua",
        ft = { "css", "sass", "scss", "html" },
        opts = { "css", "sass", "scss", "html" },
    },
    {
        "ellisonleao/glow.nvim",
        config = true,
        cmd = "Glow",
    },
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            auto_close = true,
            signs = {
                error = signs.diagnostics.Error,
                warning = signs.diagnostics.Warn,
                hint = signs.diagnostics.Hint,
                information = signs.diagnostics.Info,
            },
        },
        keys = {
            { "<leader>xx", "<cmd>TroubleToggle<cr>" },
            { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>" },
            { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>" },
            { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },
            { "<leader>xl", "<cmd>TroubleToggle loclist<cr>" },
        },
        cmd = "Trouble",
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            local Rule = require("nvim-autopairs.rule")
            local cond = require("nvim-autopairs.conds")

            npairs.setup({
                fast_wrap = {},
                disable_filetype = disable_filetypes,
            })

            local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
            npairs.add_rules({
                Rule(" ", " ")
                    :with_pair(function(opts)
                        local pair = opts.line:sub(opts.col - 1, opts.col)
                        return vim.tbl_contains({
                            brackets[1][1] .. brackets[1][2],
                            brackets[2][1] .. brackets[2][2],
                            brackets[3][1] .. brackets[3][2],
                        }, pair)
                    end)
                    :with_move(cond.none())
                    :with_cr(cond.none())
                    :with_del(function(opts)
                        local col = vim.api.nvim_win_get_cursor(0)[2]
                        local context = opts.line:sub(col - 1, col + 2)
                        return vim.tbl_contains({
                            brackets[1][1] .. "  " .. brackets[1][2],
                            brackets[2][1] .. "  " .. brackets[2][2],
                            brackets[3][1] .. "  " .. brackets[3][2],
                        }, context)
                    end),
            })
            for _, bracket in pairs(brackets) do
                Rule("", " " .. bracket[2])
                    :with_pair(cond.none())
                    :with_move(function(opts)
                        return opts.char == bracket[2]
                    end)
                    :with_cr(cond.none())
                    :with_del(cond.none())
                    :use_key(bracket[2])
            end
        end,
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {},
    },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        cmd = "Refactor",
        keys = {
            {
                "<leader>rr",
                function()
                    require("refactoring").select_refactor({
                        show_success_message = true,
                    })
                end,
                mode = { "n", "x" },
            },
        },
        opts = {},
    },
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        config = function()
            require("illuminate").configure({
                filetypes_denylist = disable_filetypes,
            })
        end,
    },
    {
        "Wansmer/treesj",
        keys = { "<space>m", "<space>j", "<space>s" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {},
    },
    {
        "rcarriga/nvim-notify",
        lazy = false,
        priority = 100,
        config = function()
            local notify = require("notify")
            notify.setup({ top_down = false })
            vim.notify = notify
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            scope = {
                show_start = false,
                show_end = false,
            },
            exclude = {
                filetypes = {
                    "lspinfo",
                    "checkhealth",
                    "help",
                    "man",
                    "gitcommit",
                    unpack(disable_filetypes),
                },
            },
        },
    },
    {
        "nvim-tree/nvim-tree.lua",
        keys = {
            { "<C-s>", "<cmd>NvimTreeFindFileToggle<cr>" },
        },
        cmd = { "NvimTreeFindFileToggle" },
        dependencies = "nvim-tree/nvim-web-devicons",
        init = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
        opts = {
            sync_root_with_cwd = true,
            respect_buf_cwd = true,
            update_focused_file = {
                enable = true,
                update_root = true,
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                show_on_open_dirs = false,
                icons = {
                    hint = signs.diagnostics.Hint,
                    info = signs.diagnostics.Info,
                    warning = signs.diagnostics.Warn,
                    error = signs.diagnostics.Error,
                },
            },
            modified = {
                enable = true,
                show_on_dirs = true,
                show_on_open_dirs = false,
            },
            git = {
                ignore = false,
                show_on_dirs = true,
                show_on_open_dirs = false,
            },
            sort_by = "case_sensitive",
            reload_on_bufenter = true,
            view = {
                adaptive_size = true,
            },
            renderer = {
                group_empty = true,
                root_folder_label = false,
            },
            filters = {
                dotfiles = false,
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
        },
    },
    {
        "utilyre/barbecue.nvim",
        event = { "BufReadPre", "BufNewFile" },
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        config = true,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            options = {
                globalstatus = true,
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        fmt = function(res)
                            return res:sub(1, 1)
                        end,
                    },
                },
                lualine_b = {
                    "branch",
                    {
                        "diff",
                        symbols = {
                            added = signs.git.added,
                            modified = signs.git.modified,
                            removed = signs.git.removed,
                        }, -- Changes the symbols used by the diff.
                    },
                    "diagnostics",
                },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            extensions = { "nvim-tree", "quickfix" },
        },
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            options = {
                mode = "tabs",
                diagnostics = "nvim_lsp",
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center",
                        separator = true,
                    },
                    {
                        filetype = "DiffviewFiles",
                        text = "Source control",
                        text_align = "center",
                        separator = true,
                    },
                },
            },
        },
    },
    {
        "petertriho/nvim-scrollbar",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
        config = function()
            local scrollbar = require("scrollbar")
            local colors = require("tokyonight.colors").setup()

            scrollbar.setup({
                handle = {
                    color = colors.fg_gutter,
                },
                marks = {
                    Search = { color = colors.orange },
                    Error = { color = colors.error },
                    Warn = { color = colors.warning },
                    Info = { color = colors.info },
                    Hint = { color = colors.hint },
                    Misc = { color = colors.purple },
                },
                handlers = {
                    cursor = false,
                },
            })
        end,
    },
    {
        "stevearc/dressing.nvim",
        opts = {
            input = {
                insert_only = false,
            },
        },
        event = "VeryLazy",
    },
}
