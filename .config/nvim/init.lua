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
  "moofish32/vim-ex_test",
  "tomtom/tcomment_vim",
  "tpope/vim-endwise",
  "tpope/vim-eunuch",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
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

-- Theme
vim.cmd[[colorscheme tokyonight]]

-- Visual select shift mappings
vim.api.nvim_set_keymap(
  "n",
  "<Tab>",
  ">>_",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<S-Tab>",
  "<<_",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "i",
  "<S-Tab>",
  "<C-D>",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "v",
  "<Tab>",
  ">gv",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "v",
  "<S-Tab>",
  "<gv",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "v",
  ">",
  ">gv",
  { noremap = true }
)

vim.api.nvim_set_keymap(
  "v",
  "<",
  "<gv",
  { noremap = true }
)

-- Replace old school ruby hashes with modern day syntax
vim.api.nvim_set_keymap(
  "n",
  "hs",
  ":%s/:\\([^ ]*\\)\\(\\s*\\)=>/\\1:/g",
  { noremap = true }
)

-- Clear search highlighting by pressing //
vim.api.nvim_set_keymap(
  "n",
  "//",
  ":noh<cr>",
  { noremap = true }
)

--bind K to ripgrep word under cursor
vim.api.nvim_set_keymap(
  "n",
  "K",
  ":Find <cr>",
  { noremap = true }
)

--bind F to open fzf dialog
vim.api.nvim_set_keymap(
  "n",
  "F",
  ":Files <cr>",
  { noremap = true }
)

-- vim-rspec settings
vim.g['rspec_command'] = 'call Send_to_Tmux("bundle exec rspec {spec}\n")'
vim.api.nvim_set_keymap(
  "n",
  "<leader>t",
  ":call RunCurrentSpecFile()<CR>",
  {}
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>s",
  ":call RunNearestSpec()<CR>",
  {}
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>l",
  ":call RunLastSpec()<CR>",
  {}
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>a",
  ":call RunAllSpecs()<CR>",
  {}
)

-- vim-ex-test settings
vim.g['ex_test_command'] = 'call Send_to_Tmux("mix test {test}\n")'
vim.api.nvim_set_keymap(
  "n",
  "<leader>et",
  ":call RunCurrentTestFile()<CR>",
  {}
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>es",
  ":call RunNearestTest()<CR>",
  {}
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>el",
  ":call RunLastTest()<CR>",
  {}
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>ea",
  ":call RunAllTests()<CR>",
  {}
)

-- Run last command in target tmux pane.
vim.api.nvim_set_keymap(
  "n",
  "<leader>u",
  ":call Send_to_Tmux(\"!!\\n\")<CR>",
  {}
)

-- fzf commands

-- May improve fzf quit speed when esc is pressed.
-- This seems to be mostly fine in modern nvim, but this still helps slightly.
-- https://github.com/junegunn/fzf/issues/1393#issuecomment-426576577
local autocmd_group = vim.api.nvim_create_augroup('vimrc_autocmd', { clear = true })
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = 'fzf',
  group = autocmd_group,
  command = 'tnoremap <buffer> <esc> <c-c>'
})

local rg_command = 'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" -g "!{.git,log,coverage,node_modules,vendor,frontend,tmp}/*" -g "!tmux*" -g "!*.log" -g "!tags"'
-- Hide preview when using ripgrep. Shows more of the matching text.
vim.api.nvim_create_user_command(
  "Rg",
  function(opts)
    vim.call("fzf#vim#grep", rg_command .. " " .. "\"" .. opts.args .. "\"", vim.call("fzf#vim#with_preview", "right:50%:hidden"), false)
  end,
  { nargs = "?" }
)

-- This command is used with a shortcut key below to find all occurences of the word beneath the cursor
vim.api.nvim_create_user_command(
  "Find",
  function(opts)
    local term = vim.call("expand", "<cword>")
    vim.call("fzf#vim#grep", rg_command .. " " .. term, vim.call("fzf#vim#with_preview", "right:50%:hidden"), false)
  end,
  { nargs = 0 }
)

-- Open scratch files by extension in dedicated scratch directory
vim.api.nvim_create_user_command(
  "Scratch",
  function(opts)
    vim.cmd("tabedit ~/scratch/scratch." .. opts.fargs[1])
  end,
  { nargs = 1 }
)
