local map = vim.keymap.set
-- set <space> as the leader key
map({ "n", "v" }, "<space>", "<nop>")

-- Store relative line number jumps in the jumplist if they exceed a threshold.
map("n", "k", '(v:count > 5 ? "m\'" . v:count : "") . "k"', { expr = true })
map("n", "j", '(v:count > 5 ? "m\'" . v:count : "") . "j"', { expr = true })

-- More comfortable jumping to marks
map("n", "'", "`")
map("n", "`", "'")

-- Repurpose arrow keys for quickfix list movement
map("n", "<up>", "<cmd>cprevious<cr>", { silent = true })
map("n", "<down>", "<cmd>cnext<cr>", { silent = true })

-- Ex-mode is weird and not useful so it seems better to repeat the last macro
map("n", "Q", "@@")

-- Split line with X
map("n", "X", "<cmd>keeppatterns substitute/\\s*\\%#\\s*/\\r/e <bar> normal! ==^<cr>", { silent = true })

-- Navigate merge conflict markers
map(
  "n",
  "]n",
  [[<cmd>call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', 'W')<cr>]],
  { silent = true, desc = "Next conflict" }
)
map(
  "n",
  "[n",
  [[<cmd>call search('^\(@@ .* @@\|[<=>|]\{7}[<=>|]\@!\)', 'bW')<cr>]],
  { silent = true, desc = "Previous conflict" }
)

-- Navigate loclist
map("n", "]l", "<cmd>lnext<cr>", { silent = true })
map("n", "[l", "<cmd>lprev<cr>", { silent = true })

-- Paste without populating the yank register
-- map("x", "<leader>p", '"_dP')

-- Close floating windows, clear highlights, etc.
-- Disable current line lint rule
map("n", "<localleader>cd", function()
  require("fx.disable_lint_rule").disable_current_line_lint_rule()
end, {
  desc = "Disable current line lint rule",
})

map("n", "<s-m-a>", "mA")
map("n", "<m-a>", "'A")
map("n", "<s-m-r>", "mR")
map("n", "<m-r>", "'R")
map("n", "<s-m-s>", "mS")
map("n", "<m-s>", "'S")
map("n", "<s-m-t>", "mT")
map("n", "<m-t>", "'T")

-- Leader mappings

-- Quit the buffer
map("n", "<localleader>q", "<cmd>quit<cr>", { silent = true })
-- Quit Vim without closing windows (useful for keeping a session)
map("n", "<localleader>x", "<cmd>quitall<cr>", { silent = true })
-- Save
map("n", "<localleader>w", "<cmd>silent w!<cr>", { silent = true })
map("n", "<localleader>sr", ":%s/\\<<c-r><c-w>\\>/")
map("n", "<localleader>,", ":s/,/,\\r/g<cr>", { silent = true })
map("n", "<localleader>,", ":s/,/,\\r/g<cr>", { silent = true })
map("n", "<localleader> ", ":s/\\(\\S\\s\\)/\\1\\r/g<cr>", { silent = true })
map("v", "<localleader> ", ":s/\\(\\S\\s\\)/\\1\\r/g<cr>", { silent = true })
map("v", "<localleader>,", ":s/,/,\\r/g<cr>", { silent = true })

map("x", ".", ":normal .<cr>")
map("x", "@", [[:<c-u>echo "@".getcmdline() | execute ":'<,'>normal @" . nr2char(getchar())<cr>]])
map("v", "<c-a>", function()
  vim.cmd('normal! "xy')
  vim.fn.setreg("A", vim.fn.getreg("x") .. "\n")
end)
map("n", "<leader>a", function()
  vim.fn.setreg("a", "")
end)
map("i", "<c-a>", "<c-r>A")

vim.keymap.set("n", "<localleader>ri", function()
  local cursor_position = vim.fn.getcurpos()
  vim.api.nvim_buf_set_mark(0, "G", cursor_position[2], cursor_position[3] - 1, {})

  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx)
    if err then
      vim.api.nvim_err_writeln("Error when executing textDocument/definition: " .. err.message)
      return
    end
    local offset_encoding = vim.lsp.get_client_by_id(ctx.client_id).offset_encoding
    vim.lsp.util.jump_to_location(result[1], offset_encoding)

    local declaration_node = vim.treesitter.get_node({ ignore_injections = false }):parent()
    vim.cmd.normal("'G")

    if not declaration_node then
      vim.print("Could not find declaration :(")
      return
    end

    local lexical_declaration_node =
      require("fx.treesitter_utils").find_node_ancestor({ "lexical_declaration" }, declaration_node)
    if not lexical_declaration_node then
      vim.print("Could not find declaration :(")
      return
    end

    local declaration_value_node = declaration_node:child(2)
    if not declaration_value_node then
      vim.print("Could not find declaration :(")
      return
    end

    local declaration_value = vim.treesitter.get_node_text(declaration_value_node, 0)
    local start_row, start_col, end_row, end_col = vim.treesitter.get_node_range(lexical_declaration_node)
    vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, {})

    local usage_node = vim.treesitter.get_node({ ignore_injections = false })
    start_row, start_col, end_row, end_col = vim.treesitter.get_node_range(usage_node)
    vim.api.nvim_buf_set_text(0, start_row, start_col, end_row, end_col, vim.split(declaration_value, "\n"))
  end)
end)
