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
-- Open scratch files by extension in dedicated scratch directory
vim.api.nvim_create_user_command(
  "Scratch",
  function(opts)
    vim.cmd("tabedit ~/scratch/scratch." .. opts.fargs[1])
  end,
  { nargs = 1 }
)

-- Run last command in target tmux pane.
vim.api.nvim_set_keymap(
  "n",
  "<leader>u",
  ":call Send_to_Tmux(\"!!\\n\")<CR>",
  {}
)
