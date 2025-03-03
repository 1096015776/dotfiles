vim.keymap.set("i", "t", require("fx.javascript").add_async, { buffer = true })
vim.keymap.set("n", "<leader>r", "a${({ <++> }) => <++>.<++>}<esc>%")
vim.keymap.set("i", "<c-l>", "<esc>/<++>/<cr>c4l")
