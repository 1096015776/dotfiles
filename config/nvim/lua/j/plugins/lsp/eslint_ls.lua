local util = require 'lspconfig.util'

require('lspconfig').eslint.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false

    require('j.plugins.lsp').on_attach(client, bufnr)
  end,
  root_dir = util.root_pattern('package.json', '.git'),
}
