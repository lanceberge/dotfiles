return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end)
    vim.keymap.set('n', '<leader>.', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    for _, idx in ipairs { 1, 2, 3, 4, 5 } do
      vim.keymap.set('n', string.format('<space>%d', idx), function()
        harpoon:list():select(idx)
      end)
    end
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'harpoon',
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        vim.keymap.set('n', '<C-c>', ':wq<CR>', { buffer = buf })
      end,
    })
  end,
}
