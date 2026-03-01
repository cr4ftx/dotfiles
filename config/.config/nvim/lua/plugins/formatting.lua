local root_has_file = function(files, bufnr)
  local root = vim.fs.root(bufnr or 0, files)
  return root ~= nil
end

local javascript_formatter = function(bufnr)
  if root_has_file({ "biome.json", "biome.jsonc" }, bufnr) then
    return { "biome-check" }
  end

  if root_has_file({ ".oxfmtrc.json", ".oxfmtrc.jsonc" }, bufnr) then
    return { "oxfmt" }
  end

  return { "prettierd" }
end

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
        -- python = { "black" },
        javascript = javascript_formatter,
        javascriptreact = javascript_formatter,
        typescript = javascript_formatter,
        typescriptreact = javascript_formatter,
        json = javascript_formatter,
        jsonc = javascript_formatter,
        yaml = javascript_formatter,
        graphql = javascript_formatter,
        html = javascript_formatter,
        markdown = javascript_formatter,
        css = javascript_formatter,
        sass = javascript_formatter,
        scss = javascript_formatter,
        sql = { "sql_formatter" },
        sh = { "beautysh" },
        bash = { "beautysh" },
        zsh = { "beautysh" },
        proto = { "buf" },
      },
      format_on_save = {
        lsp_fallback = false,
      },
      default_format_opts = {
        timeout_ms = 1000,
        stop_after_first = true,
      },
    },
  },
}
