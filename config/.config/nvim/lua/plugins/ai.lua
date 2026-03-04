return {
  "yetone/avante.nvim",
  build = "make",
  version = false,
  opts = {
    instructions_file = "AGENTS.md",
    provider = "claude",
    input = {
      provider = "dressing",
      provider_opts = {},
    },
  },
  keys = {
    "<leader>aa",
  },
  cmd = "Avante",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
    "saghen/blink.cmp",
    "stevearc/dressing.nvim",
    "nvim-tree/nvim-web-devicons",
    "MeanderingProgrammer/render-markdown.nvim",
  },
}
