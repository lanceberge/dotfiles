return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      vim.keymap.set('n', '<leader>gs', ':Neogit<CR>')

      local neogit = require 'neogit'
      neogit.setup {
        kind = 'vsplit', -- Open Neogit in a vertical split by default
        -- Optional: Configure specific popups
        commit_popup = {
          kind = 'split', -- Use horizontal split for commit editor to avoid vsplit errors
        },
      }
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
}
