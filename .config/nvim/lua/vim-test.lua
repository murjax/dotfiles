vim.api.nvim_set_keymap(
  "n",
  "<leader>t",
  ":TestFile<CR>",
  {}
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>s",
  ":TestNearest<CR>",
  {}
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>a",
  ":TestSuite<CR>",
  {}
)

vim.api.nvim_set_keymap(
  "n",
  "<leader>l",
  ":TestLast<CR>",
  {}
)

vim.api.nvim_set_var("test#strategy", "tslime")

vim.g.projectionist_heuristics = {
  ["*"] = {
    ["app/*.rb"] = {
      alternate = "spec/{}_spec.rb"
    },
    ["spec/*_spec.rb"] = {
      alternate = "app/{}.rb"
    },
    ["lib/*.ex"] = {
      alternate = "test/{}_test.exs"
    },
    ["test/*_test.exs"] = {
      alternate = "lib/{}.ex"
    },
  },
}
