return {
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
