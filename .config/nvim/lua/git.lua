return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      local neogit = require 'neogit'
      neogit.setup {
        kind = 'vsplit', -- Open Neogit in a vertical split
        commit_popup = {
          kind = 'split', -- Horizontal split for commit editor
        },
        use_magit_keybindings = true,
        disable_signs = false,
        disable_hint = false,
        disable_context_highlighting = false,
      }

      -- Keybinding to open Neogit
      vim.keymap.set('n', '<leader>gs', function()
        neogit.open { kind = 'vsplit' }
      end, { noremap = true, silent = true, desc = 'Open Neogit in vertical split' })
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
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    config = function()
      require('git-conflict').setup {
        default_mappings = {
          ours = 'l',
          theirs = 'o',
          both = 'a',
          next = 'n',
          prev = 'p',
        },
      }
    end,
  },
}
