require('lspconfig').html.setup {
  cmd={"vscode-html-language-server","--stdio"},
  filetypes={"html"},
  on_attach = require('j.plugins.lsp').on_attach,
  capabilities = require('j.plugins.lsp').capabilities,
  flags = {
    debounce_text_changes = 150,
  },
}

