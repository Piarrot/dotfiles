local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
        install_path })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost user-plugins.lua source <afile> | PackerSync
  augroup end
]])

local packer = require("packer")

packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({
                border = "rounded"
            })
        end
    }
})

return packer.startup(function(use)
    use("wbthomason/packer.nvim")
    use("nvim-treesitter/nvim-treesitter")
    use("lambdalisue/suda.vim")

    -- LSP
    use("neovim/nvim-lspconfig")
    use("williamboman/nvim-lsp-installer")

    -- Auto completion
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-cmdline')
    use('hrsh7th/nvim-cmp')

    -- Color Schemes
    use("lunarvim/colorschemes")
    use("lunarvim/darkplus.nvim")

    if PACKER_BOOTSTRAP then
        packer.sync()
    end
end)
