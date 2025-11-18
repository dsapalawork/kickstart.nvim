return {
  {
    'tpope/vim-obsession',
    lazy = false,

    config = function()
      vim.api.nvim_set_keymap('n', '<leader>so', ':Obsession<CR>', { noremap = true, silent = true })

      vim.cmd [[
      augroup ObsessionGroup
      autocmd!
      autocmd VimEnter * nested
      \ if !argc() && empty(v:this_session) && !&modified|
      \   if filereadable('Session.vim') |
      \     source Session.vim |
      \   else |
      \     Obsession |
      \   endif |
      \ endif
      augroup END
      ]]
    end,
  },
}
