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

vim.api.nvim_set_var("test#strategy", "neovim_sticky")

-- Function to toggle the test terminal window
local function toggle_terminal()
  -- Find the terminal buffer used by vim-test
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local bufname = vim.api.nvim_buf_get_name(buf)
      if bufname:match("term://") then
        -- Check if buffer is visible in any window
        local wins = vim.fn.win_findbuf(buf)
        if #wins > 0 then
          -- Hide the window
          vim.api.nvim_win_close(wins[1], false)
          return
        else
          -- Show the buffer in a split
          vim.cmd('botright 15split')
          vim.api.nvim_win_set_buf(0, buf)
          return
        end
      end
    end
  end

  -- Open new terminal if none found
  vim.api.nvim_command("belowright :terminal")
end

vim.keymap.set('n', 'tt', toggle_terminal, { desc = 'Toggle terminal' })
vim.g['test#neovim_sticky#use_existing'] = 1
vim.g['test#neovim_sticky#reopen_window'] = 1

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
