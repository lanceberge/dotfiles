local nmap = function(lhs, rhs)
  vim.keymap.set('n', lhs, rhs, { remap = true, buffer = vim.api.nvim_get_current_buf() })
end

return {
  vim.keymap.set('n', '-', vim.cmd.Ex),
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>'),

  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' }),
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' }),
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' }),
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' }),
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' }),
  vim.keymap.set('n', 'H', '_'),
  vim.keymap.set('n', 'L', '$'),

  vim.keymap.set('n', '<leader>bd', ':bd<CR>'),
  vim.keymap.set('n', '<leader>wq', ':wq<CR>'),

  vim.keymap.set('n', '<leader>bn', ':bn<CR>'),
  vim.keymap.set('n', '<leader>bp', ':bp<CR>'),
  vim.keymap.set('i', 'jk', '<esc>'),
}
