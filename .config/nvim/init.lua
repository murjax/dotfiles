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
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  },
  "rhysd/accelerated-jk",
  "sheerun/vim-polyglot",
  "rhysd/committia.vim",
  "vim-test/vim-test",
  "tomtom/tcomment_vim",
  "MattesGroeger/vim-bookmarks",
  "tpope/vim-endwise",
  "tpope/vim-eunuch",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-rails",
  "tpope/vim-projectionist",
  "Yggdroot/indentLine",
  "axelf4/vim-strip-trailing-whitespace",
  "machakann/vim-sandwich",
  "jgdavey/tslime.vim",
  -- "folke/tokyonight.nvim",
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      vim.opt.background = "dark"
      vim.g.everforest_background = "hard"
      vim.g.everforest_enable_italic = true
      vim.cmd.colorscheme('everforest')
    end
  },
  { "VonHeikemen/lsp-zero.nvim", branch = "v3.x", },
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "roobert/tailwindcss-colorizer-cmp.nvim",
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {}
  },
  {
    'https://codeberg.org/esensar/nvim-dev-container',
    dependencies = 'nvim-treesitter/nvim-treesitter'
  },
  "stevearc/oil.nvim",
  "jgdavey/vim-blockle"
})

-- Basic settings
vim.opt.termguicolors = true
vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.colorcolumn = "80,120"
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.errorbells = false
vim.opt.mouse = ""
vim.opt.number = true
vim.opt.wrap = false
vim.opt.numberwidth = 5
vim.opt.showtabline = 2
vim.opt.smartcase = true
vim.opt.tabstop = 2
vim.opt.showmode = false

require 'vim-test'
require 'fzf'
require 'misc'
require 'lsp'
