local g = vim.g

local map = require('j.utils').map

-- Settings
g.nvim_tree_git_hl = 1
g.nvim_tree_auto_close = 1
g.nvim_tree_show_icons = {
  git = 0,
  folders = 1,
  files = 1,
}
g.nvim_tree_icons = {
  default = '',
  symlink = '',
  folder = {
    default = '',
    open = '',
    empty = '',
    empty_open = '',
    symlink = '',
    symlink_open = '',
  },
}
g.nvim_tree_ignore = { '.git', '.DS_Store' }

-- Mappings
map('n', '<c-n>', ':NvimTreeToggle<cr>', { silent = true })
