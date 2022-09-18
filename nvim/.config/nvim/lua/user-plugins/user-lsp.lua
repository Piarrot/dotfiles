local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = require("user-options/user-keymaps").on_lsp_attach

lspconfig["tsserver"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

lspconfig["sumneko_lua"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
