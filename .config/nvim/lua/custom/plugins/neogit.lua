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
        kind = 'vsplit',
        commit_popup = {
          kind = 'split',
        },

        use_magit_keybindings = true,
        disable_signs = false,
        disable_hint = false,
        disable_context_highlighting = false,

        mappings = {
          popup = {
            ['z'] = 'StashPopup',
            ['F'] = 'PullPopup',
            ['p'] = 'PushPopup',
          },
        },
      }

      vim.keymap.set('n', '<leader>gs', function()
        neogit.open { kind = 'vsplit' }
      end, { noremap = true, silent = true, desc = 'Open Neogit in vertical split' })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'NeogitStatus',
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          vim.keymap.set('n', '<C-c>', ':q<CR>', { buffer = buf })
        end,
      })
    end,
  },
}
