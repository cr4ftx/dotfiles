---@diagnostic disable: missing-fields

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "marilari88/neotest-vitest",
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({
        summary = { follow = true },
        adapters = { require("neotest-vitest") },
      })
    end,
    keys = {
      {
        "<leader>tr",
        function()
          local neotest = require("neotest")
          neotest.run.run({
            vim.fn.expand("%"),
            suite = false,
            vitestCommand = "yarn test:unit",
          })
          neotest.summary.open()
        end,
        desc = "Run current buffer tests",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Toggle summary",
      },
    },
  },
}
