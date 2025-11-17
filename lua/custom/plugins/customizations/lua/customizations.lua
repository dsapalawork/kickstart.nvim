vim.g.have_nerd_font = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

vim.wo.wrap = false

vim.keymap.set('n', '<leader>tw', ':set invwrap<CR>:set wrap?<CR>', { desc = 'Toggle text wrap' })

vim.keymap.set('n', '<leader>non', ':set nu<CR>:set rnu<CR>', { desc = 'Toggle line numbers on' })
vim.keymap.set('n', '<leader>nor', ':set nonu<CR>:set rnu<CR>', { desc = 'Toggle only relative line numbers on' })
vim.keymap.set('n', '<leader>noa', ':set nu<CR>:set nornu<CR>', { desc = 'Toggle only absolute line numbers on' })
vim.keymap.set('n', '<leader>nof', ':set nonu<CR>:set nornu<CR>', { desc = 'Toggle line numbers off' })

vim.keymap.set('n', '<leader>lt', ':set list!<CR>', { desc = 'Toggle non-printable chars on and off' })

vim.keymap.set('n', '<leader>Y', '^y$', { desc = 'Copy the entire line without the line ending' })

vim.keymap.set('n', '<leader>a', 'ggVG', { desc = 'Select all', silent = true })

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
local listchars_default = {
  tab = '» ', -- Show tabs as a right-pointing arrow
  eol = '↩', -- Show end-of-line as a return arrow
  trail = '.', -- Show trailing spaces as a dot
  nbsp = '␣', -- Show non-breaking spaces as a special character
  extends = '›', -- Show when text extends beyond the right edge of the window
  precedes = '‹', -- Show when text extends beyond the left edge of the window
  space = '·', -- Show spaces as a special character
}
vim.opt.listchars = listchars_default

-- highlight trailing whitespace as red
local highlight_trailing_whitespace_highlight_name = 'TrailingWhitespace'
local highlight_trailing_whitespace_augroup_name = 'HighlightTrailingWhitespace'
vim.cmd.highlight { highlight_trailing_whitespace_highlight_name, 'ctermbg=red guibg=red' }
vim.api.nvim_create_augroup(highlight_trailing_whitespace_augroup_name, { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  desc = 'Highlight trailing whitespace when entering the buffer',
  group = highlight_trailing_whitespace_augroup_name,
  callback = function()
    vim.cmd.match { highlight_trailing_whitespace_highlight_name, [[/\s\+$/]] }
  end,
})
vim.api.nvim_create_autocmd('InsertEnter', {
  desc = 'Stop highlighting trailing whitespace while in insert mode at the end of the offending line',
  group = highlight_trailing_whitespace_augroup_name,
  callback = function()
    vim.cmd.match { highlight_trailing_whitespace_highlight_name, [[/\s\+\%#\@<!$/]] }
  end,
})
vim.api.nvim_create_autocmd('InsertLeave', {
  desc = 'Resume highlighting trailing whitespace after leaving insert mode',
  group = highlight_trailing_whitespace_augroup_name,
  callback = function()
    vim.cmd.match { highlight_trailing_whitespace_highlight_name, [[/\s\+$/]] }
  end,
})
vim.api.nvim_create_autocmd('BufWinLeave', {
  desc = 'Clear trailing whitespace highlights when leaving the buffer',
  group = highlight_trailing_whitespace_augroup_name,
  callback = function()
    vim.cmd [[call clearmatches()]]
  end,
})

vim.keymap.set('n', '<C-L>', ':nohlsearch<CR>', { desc = 'Clear highlighting', silent = true })
local function filename_first_path_display(_, path)
  local tail = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)
  if parent == '.' then
    return tail
  else
    return string.format('%s\t\t%s', tail, parent)
  end
end

-- require('telescope').setup {
--   defaults = {
--     path_display = filename_first_path_display,
--     file_ignore_patterns = { '^.git/' },
--   },
-- }
