local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function ()
    local bufopts = { noremap=true, silent=true, buffer=0 }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
end

lspconfig["tsserver"].setup({
    on_attach = on_attach,
    capabilities = capabilities
})

lspconfig["sumneko_lua"].setup({
    on_attach = on_attach,
    capabilities = capabilities
})
