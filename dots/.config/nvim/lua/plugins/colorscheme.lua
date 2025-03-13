return {
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        code_style = {
          comments = "italic",
          keywords = "bold,italic",
          functions = "italic",
          strings = "none",
          variables = "none",
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
