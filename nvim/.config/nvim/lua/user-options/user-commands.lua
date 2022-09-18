local createCommand = require("utils.create-command")

-- save current buffer as sudo (suda plugin)
createCommand("WS", ":w suda://%")



vim.cmd([[
augroup _lsp
    autocmd!
    autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
augroup end
]])
