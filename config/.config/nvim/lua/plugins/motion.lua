return {
  {
    "aserowy/tmux.nvim",
    event = "VeryLazy",
    opts = {
      resize = {
        enable_default_keybindings = true,
        resize_step_x = 5,
        resize_step_y = 5,
      },
    },
  },
  {
    "gregorias/coerce.nvim",
    tag = "v0.3",
    config = true,
    keys = { "cr", "gcr" },
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "InsertEnter",
    config = true,
  },
}
