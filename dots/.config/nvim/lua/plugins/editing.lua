return {
  "sindrets/diffview.nvim",
  {
    "max397574/better-escape.nvim",
    enabled = false,
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    opts = {
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "ys",
        normal_cur = "yss",
        normal_line = "yS",
        normal_cur_line = "ySS",
        visual = "gs",
        visual_line = "gS",
        delete = "ds",
        change = "cs",
        change_line = "cS",
      },
    },
  },
  {
    "axelvc/template-string.nvim",
    opts = {
      filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" },
      remove_template_string = true,
      restore_quotes = {
        normal = [[']],
        jsx = [["]],
      },
    },
    event = "InsertEnter",
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" },
  },

  {
    "echasnovski/mini.ai",
    enabled = false,
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      local treesitter = require("mini.ai").gen_spec.treesitter

      require("mini.ai").setup({
        custom_textobjects = {
          -- Whole buffer
          e = function()
            local from = { line = 1, col = 1 }
            local to = {
              line = vim.fn.line("$"),
              col = math.max(vim.fn.getline("$"):len(), 1),
            }
            return { from = from, to = to }
          end,

          -- Current line
          j = function(args)
            local index_of_first_non_whitespace_character = string.find(vim.fn.getline("."), "%S")
            local col = args == "i" and index_of_first_non_whitespace_character or 1

            return {
              from = { line = vim.fn.line("."), col = col },
              to = { line = vim.fn.line("."), col = math.max(vim.fn.getline("."):len(), 1) },
            }
          end,

          -- Function definition (needs treesitter queries with these captures)
          m = treesitter({ a = "@function.outer", i = "@function.inner" }),

          o = treesitter({
            a = { "@conditional.outer", "@loop.outer" },
            i = { "@conditional.inner", "@loop.inner" },
          }),
        },
      })
    end,
  },
}
