-- LSP with lsp-zero

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
