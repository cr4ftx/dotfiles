local map = require("utils.map")
return {
  {
    "sindrets/diffview.nvim",
    -- stylua: ignore
    keys = {
      { "<leader>go", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
      { "<leader>gd", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "File history" },
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
      local gitsigns = require("gitsigns")
      local ok, sb = pcall(require, "scrollbar.handlers.gitsigns")
      if ok then
        sb.setup()
      end

      opts.on_attach = function(bufnr)
        -- Navigation
        map("n", "]g", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]g", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, {
          buffer = bufnr,
          expr = true,
          desc = "Go to next hunk",
        })

        map("n", "[g", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[g", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, {
          buffer = bufnr,
          expr = true,
          desc = "Go to previous hunk",
        })

        -- Actions
        map({ "n", "v" }, "<leader>hs", gitsigns.stage_hunk, {
          buffer = bufnr,
          desc = "Toggle stage hunk",
        })
        map({ "n", "v" }, "<leader>hr", gitsigns.reset_hunk, {
          buffer = bufnr,
          desc = "Reset hunk",
        })
        map("n", "<leader>hb", function()
          gitsigns.blame_line({ full = true })
        end, {
          buffer = bufnr,
          desc = "Full blame line",
        })
        map("n", "<leader>hi", gitsigns.preview_hunk_inline)
        map("n", "<leader>hS", gitsigns.stage_buffer, {
          buffer = bufnr,
          desc = "Stage current buffer",
        })
        map("n", "<leader>hR", gitsigns.reset_buffer, {
          buffer = bufnr,
          desc = "Reset current buffer",
        })
        map("n", "<leader>hp", gitsigns.preview_hunk, {
          buffer = bufnr,
          desc = "Preview hunk",
        })
        map("n", "<leader>hd", gitsigns.diffthis, {
          buffer = bufnr,
          desc = "Diff current buffer",
        })

        -- Text object
        map({ "o", "x" }, "ig", gitsigns.select_hunk)
        map({ "o", "x" }, "ag", gitsigns.select_hunk)
      end

      gitsigns.setup(opts)
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
        desc = "Open neogit commit",
      },
      {
        "<leader>gg",
        function()
          require("neogit").open()
        end,
        desc = "Open neogit",
      },
    },
    opts = {},
  },
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
  },
}
