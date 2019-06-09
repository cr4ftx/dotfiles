return {
    {
        "sindrets/diffview.nvim",
        keys = {
            { "<leader>go", "<cmd>DiffviewOpen<cr>" },
            { "<leader>gd", "<cmd>DiffviewClose<cr>" },
        },
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewLog",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
            "DiffviewFileHistory",
            "DiffviewRefresh",
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = "petertriho/nvim-scrollbar",
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol",
                delay = 300,
                ignore_whitespace = false,
            },
        },
        config = function(_, opts)
            local gs = require("gitsigns")
            local ok, sb = pcall(require, "scrollbar.handlers.gitsigns")
            if ok then
                sb.setup()
            end

            opts.on_attach = function(bufnr)
                local map = function(mode, l, r, mOpts)
                    mOpts = mOpts or {}
                    mOpts.buffer = bufnr
                    vim.keymap.set(mode, l, r, mOpts)
                end

                -- Navigation
                map("n", "]g", function()
                    if vim.wo.diff then
                        return "]g"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true })

                map("n", "[g", function()
                    if vim.wo.diff then
                        return "[g"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true })

                -- Actions
                map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
                map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
                map("n", "<leader>hS", gs.stage_buffer)
                map("n", "<leader>hu", gs.undo_stage_hunk)
                map("n", "<leader>hR", gs.reset_buffer)
                map("n", "<leader>hp", gs.preview_hunk)
                map("n", "<leader>hd", gs.diffthis)

                -- Text object
                map({ "o", "x" }, "ig", ":<C-U>Gitsigns select_hunk<CR>")
                map({ "o", "x" }, "ag", ":<C-U>Gitsigns select_hunk<CR>")
            end

            gs.setup(opts)
        end,
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        cmd = "Neogit",
        keys = {
            {
                "<leader>gc",
                function()
                    require("neogit").open({ "commit" })
                end,
            },
            {
                "<leader>gg",
                function()
                    require("neogit").open()
                end,
            },
        },
        opts = {},
    },
}
