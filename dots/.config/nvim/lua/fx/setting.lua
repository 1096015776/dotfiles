-- change lualineColor
-- vim.api.nvim_set_hl(0, "StatusLine", { bg = "#2A2A37" })

vim.api.nvim_set_hl(0, "StatusLine", { bg = "#31363F" })

require("fx.cmp-path-alias")

require("gitsigns").setup({
  signs_staged_enable = false,
  current_line_blame = true,
})
