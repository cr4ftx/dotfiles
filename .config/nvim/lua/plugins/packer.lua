local packer_status_ok, packer = pcall(require, 'packer')
if not packer_status_ok then
    return
end

return packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'editorconfig/editorconfig-vim'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-abolish'
    use 'jiangmiao/auto-pairs'
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-lualine/lualine.nvim'
    use 'kyazdani42/nvim-tree.lua'

    -- use 'shaunsingh/nord.nvim'
    use 'folke/tokyonight.nvim'

    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use 'williamboman/nvim-lsp-installer'
    use 'neovim/nvim-lspconfig'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'lewis6991/gitsigns.nvim'
    use 'norcalli/nvim-colorizer.lua'
end)
