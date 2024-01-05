return{
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  -- Harpoon for quick navigation
  {
    'ThePrimeagen/harpoon', config = function()
    require("telescope").load_extension('harpoon')
    -- Add keybindings
      vim.keymap.set({ 'n' }, '<leader><Tab>', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true})
      vim.keymap.set({ 'n' }, '<leader>s', ':lua require("harpoon.mark").add_file()<CR>', { noremap = true})
      vim.keymap.set({ 'n' }, '<leader>1', ':lua require("harpoon.ui").nav_file(1)  <CR>', { noremap = true})
      vim.keymap.set({ 'n' }, '<leader>2', ':lua require("harpoon.ui").nav_file(2)  <CR>', { noremap = true})
      vim.keymap.set({ 'n' }, '<leader>3', ':lua require("harpoon.ui").nav_file(3)  <CR>', { noremap = true})
  end
  },
}
