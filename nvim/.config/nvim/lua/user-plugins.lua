local configurePacker = function ()
    -- Plugin manager
    use("wbthomason/packer.nvim")

    -- Code Highlighter
    use("nvim-treesitter/nvim-treesitter")
    
    -- Reload configuration
    use({"famiu/nvim-reload",requires = { {'nvim-lua/plenary.nvim'} }})

    -- Utils
    use("lambdalisue/suda.vim") --Sudo save current buffer
    use({'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'})
    use({"kyazdani42/nvim-tree.lua", requires="kyazdani42/nvim-web-devicons"})

    -- Telescope
    use({"nvim-telescope/telescope.nvim",requires = { {'nvim-lua/plenary.nvim'} }})

    -- LSP, DAP, Linters and formatters Manager
    use("williamboman/mason.nvim")

    -- LSP
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")

    -- Auto completion
    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-cmdline')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-nvim-lua')
    use("saadparwaiz1/cmp_luasnip")

    -- Snippets
    use("L3MON4D3/LuaSnip") 
    use("rafamadriz/friendly-snippets")

    -- Color Schemes
    use("lunarvim/colorschemes")
    use("lunarvim/darkplus.nvim")

    if PACKER_BOOTSTRAP then
        packer.sync()
    end
end


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

packer.startup(configurePacker)
