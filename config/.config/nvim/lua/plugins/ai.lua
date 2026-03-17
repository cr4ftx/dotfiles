return {
  "yetone/avante.nvim",
  build = "make",
  version = false,
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    instructions_file = "AGENTS.md",
    provider = "claude",
    input = {
      provider = "dressing",
      provider_opts = {},
    },
  },
  keys = {
    { "<leader>aa", "<cmd>AvanteAsk<cr>", desc = "avante: ask", mode = { "n", "v" } },
  },
  cmd = {
    "AvanteAsk",
    "AvanteBuild",
    "AvanteChat",
    "AvanteChatNew",
    "AvanteClear",
    "AvanteEdit",
    "AvanteFocus",
    "AvanteHistory",
    "AvanteModels",
    "AvanteRefresh",
    "AvanteShowRepoMap",
    "AvanteStop",
    "AvanteSwitchInputProvider",
    "AvanteSwitchProvider",
    "AvanteSwitchSelectorProvider",
    "AvanteToggle",
  },
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
