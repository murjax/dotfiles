lua << EOF

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "AndrewRadev/splitjoin.vim",
  "airblade/vim-gitgutter",
  "bronson/vim-trailing-whitespace",
  "itchyny/lightline.vim",
  { "junegunn/fzf", dir = "~/.fzf", build = "./install --all" },
  "junegunn/fzf.vim",
  "mhinz/vim-startify",
  "rhysd/accelerated-jk",
  "sheerun/vim-polyglot",
  "rhysd/committia.vim",
  "thoughtbot/vim-rspec",
  "tomtom/tcomment_vim",
  "tpope/vim-endwise",
  "tpope/vim-eunuch",
  "tpope/vim-fugitive",
  "Yggdroot/indentLine",
  "jgdavey/tslime.vim",
  "folke/tokyonight.nvim",
  { "VonHeikemen/lsp-zero.nvim", branch = "v3.x", },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "roobert/tailwindcss-colorizer-cmp.nvim",
})

-- " LSP with lsp-zero

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    lsp_zero.default_setup,
  },
})

-- tailwindcss-colorizer-cmp
local cmp = require("cmp")
local tailwindcss_colors = require("tailwindcss-colorizer-cmp")
local cmp_formatter = function(entry, vim_item)
    return tailwindcss_colors.formatter(entry, vim_item)
end

cmp.setup({
    formatting = {
        format = cmp_formatter,
    },
})

EOF

set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim
source ~/.vimrc
