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
  {
    "folke/snacks.nvim",
    keys = {
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    }
  },
  "itchyny/lightline.vim",
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
    end,
  },
  "jgdavey/tslime.vim",
  "jgdavey/vim-blockle",
  { "mason-org/mason.nvim", opts = {} },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        elixir = { "credo" },
      }

      -- Run linter on save and when entering buffer
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  "Mohammed-Taher/AdvancedNewFile.nvim",
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      vim.diagnostic.config({
        virtual_text = true,  -- Show diagnostics as virtual text at end of line
        signs = true,         -- Show signs in the gutter
        underline = true,     -- Underline problematic code
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'always',  -- Show source of diagnostic
          header = '',
          prefix = '',
        },
      })

      -- Show diagnostic message in floating window
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic' })

      -- Navigate between diagnostics
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local opts = { buffer = args.buf }

          -- Code actions (includes auto-import)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        end,
      })

      vim.lsp.config('elixirls', {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/elixir-ls" },
        capabilities = capabilities,
        settings = {
          elixirLS = {
            dialyzerEnabled = true,
            fetchDeps = false,
            enableTestLenses = false,
            suggestSpecs = false,
          }
        }
      })

      -- Preventing pending Rails migration popup.
      vim.lsp.handlers["window/showMessageRequest"] = function(err, result, ctx, config)
        if result and result.message and result.message:match("Migrations are pending") then
          if result.actions then
            for _, action in ipairs(result.actions) do
              if action.title and action.title:match("Cancel") then
                return action
              end
            end
            return result.actions[#result.actions]
          end
          return { title = "Cancel" }
        end
        return vim.lsp.handlers["window/showMessageRequest"](err, result, ctx, config)
      end

      vim.lsp.config('ruby_lsp', {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/ruby-lsp" },
        capabilities = capabilities,
        init_options = {
          formatter = "standard",
          linters = { "standard" },
        },
        on_attach = function(client, bufnr)
          -- Preventing pending Rails migration popup.
          client.server_capabilities.executeCommandProvider = false
        end
      })

      vim.lsp.config('ts_ls', {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/typescript-language-server", "--stdio" },
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", "jsconfig.json", ".git" }),
      })
    end,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
  },
  {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
  "rhysd/committia.vim",
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
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          elixir = { "mix" },
        },
      })

      -- Manual format with <leader>cf
      vim.keymap.set("n", "<leader>cf", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "Format buffer" })
    end,
  },
  "tomtom/tcomment_vim",
  "tpope/vim-eunuch",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-projectionist",
  "vim-test/vim-test",
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
vim.opt.swapfile = false

require 'vim-test'
require 'fzf'
require 'misc'
require 'treesitter'
