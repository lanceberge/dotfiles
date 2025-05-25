-- mf - mark file
-- mu - unmark all
local g = vim.g

local options_append = {
  netrw_keepdir = 0,
  netrw_winsize = '17',
  netrw_localmkdir = 'mkdir -p',
  netrw_localcopycmd = 'cp -r',
  netrw_localrmdir = 'rm -r',
  netrw_list_hide = [[^\.\/$,^\.\.\/$]],
  -- netrw_banner = 0,
  netrw_liststyle = 3,
  netrw_browse_split = 0,
  netrw_altv = 1,
  netrw_bufsettings = 'noma nomod nu nobl nowrap ro',
}

for k, v in pairs(options_append) do
  g[k] = v
end

local nmap = function(lhs, rhs)
  vim.keymap.set('n', lhs, rhs, { remap = true, buffer = vim.api.nvim_get_current_buf() })
end

nmap('.', 'gh')
nmap('q', ':bd<CR>')
