local signs = require("utils.signs")

return {
    {
        "nvim-tree/nvim-tree.lua",
        event = "VeryLazy",
        -- stylua: ignore
        keys = {
            { "<c-s>", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toogle explorer" },
            { "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toogle explorer" },
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
            filesystem_watchers = {
                enable = true,
                debounce_delay = 50,
                ignore_dirs = { "node_modules", ".git" },
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
        "kwkarlwang/bufresize.nvim",
        opts = {},
    },
}
