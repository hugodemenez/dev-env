-- Map leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- Install lazy.nvim as plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim and plugins
require('lazy').setup("plugins")

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>g', ':Git<CR>', { noremap = true})
vim.keymap.set({ 'n', 'v' }, '<leader>e', ':Explore<CR>', { noremap = true})
vim.keymap.set({ 'n', 'v' }, '<leader>b', ':GBrowse<CR>', { noremap = true})
vim.keymap.set({ 'n', 'v' }, '<leader>j', ':wincmd j<CR>', { noremap = true})
vim.keymap.set({ 'n', 'v' }, '<leader>k', ':wincmd k<CR>', { noremap = true})
vim.keymap.set({ 'n', 'v' }, '<leader>l', ':wincmd l<CR>', { noremap = true})
vim.keymap.set({ 'n', 'v' }, '<leader>h', ':wincmd h<CR>', { noremap = true})
vim.keymap.set({ 'n', 'v' }, '<leader>f', ':Telescope  find_files<CR>', { noremap = true})
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { noremap = true})

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
