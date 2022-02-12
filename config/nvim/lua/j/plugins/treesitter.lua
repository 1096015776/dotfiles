require('nvim-treesitter.install').compilers = { 'gcc' }
require('nvim-treesitter.configs').setup {
  matchup = {
    enable = true,              -- mandatory, false will disable the whole extension
    disable = { "c", "ruby" },  -- optional, list of language that will be disabled
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  },
  playground = {
    enable = false,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
  },
  autotag = {
    enable = true,
  },
  autopairs = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  ignore_install = {"haskell"},
  ensure_installed = {
    'query',
    'javascript',
    'jsdoc',
    'typescript',
    'tsx',
    'json',
    'php',
    'python',
    'html',
    'graphql',
    'lua',
    'vue',
    'yaml',
    'css',
    'bash',
    'scss',
    'hcl',
  },
}
