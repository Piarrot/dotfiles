require("bufferline").setup()

require("nvim-tree").setup({
    disable_netrw=false,
})

require("nvim-treesitter").setup()

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed={"sunmeko_lua","tsserver"},
    automatic_installation=true,
})
