return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      mappings = {
        ["<c-f>"] = function(state)
          local node = state.tree:get_node()
          local path = node:get_parent_id()
          if node.type == "directory" then
            path = node:get_id()
          end
          require("neo-tree").close_all()
          require("grug-far").open({
            prefills = { paths = path },
          })
        end,
        ["<c-e>"] = function(state)
          local node = state.tree:get_node()
          local path = node:get_parent_id()
          if node.type == "directory" then
            path = node:get_id()
          end
          require("neo-tree").close_all()
          local term_opts = { cwd = path, esc_esc = false, ctrl_hjkl = false, border = "single" }
          require("snacks").terminal({ "zsh", "-c", "cd " .. path .. " && yazi" }, term_opts)
        end,
        ["<localleader>d"] = function(state)
          local node = state.tree:get_node()
          local path = node:get_parent_id()
          if node.type == "directory" then
            path = node:get_id()
          end
          require("neo-tree").close_all()
          vim.cmd("DiffviewFileHistory " .. path)
        end,
      },
    },
  },
}
