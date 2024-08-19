-- fzf commands

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
