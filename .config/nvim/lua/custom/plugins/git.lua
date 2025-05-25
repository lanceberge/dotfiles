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
          ours = 'ml',
          theirs = 'mo',
          none = 'mx',
          both = 'ma',
          next = ']c',
          prev = '[c',
        },
      }
    end,
  },
  {
    'fredeeb/tardis.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('tardis-nvim').setup {
        keymap = {
          ['next'] = 'p',
          ['prev'] = 'n',
          ['quit'] = 'q',
        },
        initial_revisions = 10,
        max_revisions = 256,
      }
      vim.keymap.set('n', '<leader>gt', ':Tardis git<cr>')
    end,
  },
}
