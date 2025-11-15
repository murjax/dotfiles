-- fzf commands

require('fzf-lua').setup({'fzf-vim'})

--bind K to ripgrep word under cursor
vim.api.nvim_set_keymap(
  "n",
  "K",
  ":FzfLua grep_cword <cr>",
  { noremap = true }
)

--bind F to open fzf dialog
vim.api.nvim_set_keymap(
  "n",
  "F",
  ":Files <cr>",
  { noremap = true }
)
