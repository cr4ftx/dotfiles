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
        javascript = { "biome-check", "prettierd" },
        javascriptreact = { "biome-check", "prettierd" },
        typescript = { "biome-check", "prettierd" },
        typescriptreact = { "biome-check", "prettierd" },
        json = { "biome-check", "prettierd" },
        jsonc = { "biome-check", "prettierd" },
        yaml = { "biome-check", "prettierd" },
        graphql = { "biome-check", "prettierd" },
        html = { "prettierd" },
        markdown = { "prettierd" },
        css = { "biome-check", "prettierd" },
        sass = { "prettierd" },
        scss = { "prettierd" },
        sql = { "sql_formatter" },
        sh = { "beautysh" },
        bash = { "beautysh" },
        zsh = { "beautysh" },
        proto = { "buf" },
      },
      format_on_save = {
        lsp_fallback = true,
      },
      default_format_opts = {
        timeout_ms = 500,
        stop_after_first = true,
      },
    },
  },
}
