require("bufferline").setup()
require("toggleterm").setup({
    direction = "float",
    on_open = require("user-options/user-keymaps").on_term_attach
})
require("gitsigns").setup()

local telescope = require("telescope")
telescope.setup({
  extensions = {
    workspaces = {
      -- keep insert mode after selection in the picker, default is false
      keep_insert = true,
    }
  }
})

require("workspaces").setup({
    hooks={
        open = { "NvimTreeOpen", "Telescope find_files hidden=true" },
    }
})
telescope.load_extension("workspaces")

local nvim_tree = require("nvim-tree")
nvim_tree.setup({
    disable_netrw=true,
    hijack_cursor=true,
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file= {
        enable = true,
    }
})

require("nvim-treesitter.configs").setup({
    ensure_installed = {"lua","typescript","html","css","scss","yaml","javascript","json","json5"},
    auto_install=true,
    highlight={enable=true}
})


--Install and configure LSP servers 
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed={"sunmeko_lua","tsserver"},
    automatic_installation=true,
})

-- Load snippets from plugins
require('luasnip.loaders.from_vscode').lazy_load()


require("nvim-autopairs").setup()



-- Setup autocompletion and LSP servers
require("user-plugins/user-completion")
require("user-plugins/user-dashboard")
require("user-plugins/user-lsp")
