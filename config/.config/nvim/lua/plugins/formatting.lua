return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        json = { "prettierd" },
        jsonc = { "prettierd" },
        yaml = { "prettierd" },
        graphql = { "prettierd" },
        html = { "prettierd" },
        markdown = { "prettierd" },
        css = { "prettierd" },
        sass = { "prettierd" },
        scss = { "prettierd" },
        sql = { "sql_formatter" },
        sh = { "beautysh" },
        bash = { "beautysh" },
        zsh = { "beautysh" },
        proto = { "buf" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}
