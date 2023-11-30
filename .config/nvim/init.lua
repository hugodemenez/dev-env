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
require('lazy').setup({
  -- Adding coding activity tracking
  'wakatime/vim-wakatime',

  -- Adding Copilot
  'github/copilot.vim',

  -- Adding github line modification details
  {'lewis6991/gitsigns.nvim',
  config=function()
    require('gitsigns').setup {
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
      yadm = {
        enable = false
      },
    }
  end
  },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Useful plugin to show pending keybinds.
  'folke/which-key.nvim',

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Github theme for neovim
  {
    'projekt0n/github-nvim-theme',
    lazy = false, -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({
      })
    end,
  },

  -- Auto switch between light and dark  theme
  {
    "f-person/auto-dark-mode.nvim",
    config = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option("background", "dark")
        vim.cmd('colorscheme github_dark_high_contrast')
      end,
      set_light_mode = function()
        vim.api.nvim_set_option("background", "light")
        vim.cmd('colorscheme github_light_high_contrast')
      end,
    },
  },

  -- Adding transparency
  {"xiyaowong/transparent.nvim"},

  -- Information bar at bottom
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
        theme = function()
          local colors = {
              darkgray = "#16161d",
              gray = "#727169",
              innerbg = nil,
              outerbg = "#16161D",
              normal = "#7e9cd8",
              insert = "#98bb6c",
              visual = "#ffa066",
              replace = "#e46876",
              command = "#e6c384",
          }
          return {
              inactive = {
                  a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" },
                  b = { fg = colors.gray, bg = colors.outerbg },
                  c = { fg = colors.gray, bg = colors.innerbg },
              },
              visual = {
                  a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
                  b = { fg = colors.gray, bg = colors.outerbg },
                  c = { fg = colors.gray, bg = colors.innerbg },
              },
              replace = {
                  a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
                  b = { fg = colors.gray, bg = colors.outerbg },
                  c = { fg = colors.gray, bg = colors.innerbg },
              },
              normal = {
                  a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
                  b = { fg = colors.gray, bg = colors.outerbg },
                  c = { fg = colors.gray, bg = colors.innerbg },
              },
              insert = {
                  a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
                  b = { fg = colors.gray, bg = colors.outerbg },
                  c = { fg = colors.gray, bg = colors.innerbg },
              },
              command = {
                  a = { fg = colors.darkgray, bg = colors.command, gui = "bold" },
                  b = { fg = colors.gray, bg = colors.outerbg },
                  c = { fg = colors.gray, bg = colors.innerbg },
              },
          }
        end
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
    },
    build = ':TSUpdate',
    config = function()
      require("nvim-treesitter.configs").setup {
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = {}, -- list of language that will be disabled
        },
      }
    end,
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },

  -- Harpoon for quick navigation
  {'ThePrimeagen/harpoon', config = function()
    require("telescope").load_extension('harpoon')
    -- Add keybindings
      vim.keymap.set({ 'n' }, '<leader>hm', ':lua require("harpoon.ui").toggle_quick_menu()<CR>', { noremap = true})
      vim.keymap.set({ 'n' }, '<leader>hf', ':lua require("harpoon.mark").add_file()<CR>', { noremap = true})
      vim.keymap.set({ 'n' }, '<leader>1', ':lua require("harpoon.ui").nav_file(1)  <CR>', { noremap = true})
      vim.keymap.set({ 'n' }, '<leader>2', ':lua require("harpoon.ui").nav_file(2)  <CR>', { noremap = true})
      vim.keymap.set({ 'n' }, '<leader>3', ':lua require("harpoon.ui").nav_file(3)  <CR>', { noremap = true})
  end
  },

  -- Completion plugin 
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-path", -- source for file system paths
      "L3MON4D3/LuaSnip", -- snippet engine
      "saadparwaiz1/cmp_luasnip", -- for autocompletion
      "rafamadriz/friendly-snippets", -- useful snippets
    },
    config = function()
      local cmp = require("cmp")

      local luasnip = require("luasnip")

      -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(), -- close completion window
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" }, -- text within current buffer
          { name = "luasnip" }, -- snippets
          { name = "path" }, -- file system paths
        }),
      })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp"
    },
    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      local keymap = vim.keymap

      local opts = { noremap = true, silent = true }

      local on_attach = function(client, bufnr)
        opts.buffer = bufnr

        -- set keybinds
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Smart rename"
        keymap.set("n", "gr", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
      end

      local capabilities = cmp_nvim_lsp.default_capabilities()

      lspconfig["html"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure typescript server with plugin
      lspconfig["tsserver"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure css server
      lspconfig["cssls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure tailwindcss server
      lspconfig["tailwindcss"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })


      lspconfig["prismals"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig["emmet_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
      })

      lspconfig["pyright"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig["lua_ls"].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
          globals = { "vim" },
          },
          workspace = {
          -- make language server aware of runtime files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
          },
        },
        },
      })

      lspconfig["clangd"].setup({
        capabilities = capabilities,
        on_attach = on_attach
      })

    end
  },

  -- LSP Manager
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })

      mason_lspconfig.setup({
        ensure_installed = {
          "tsserver",
          "astro",
          "html",
          "cssls",
          "tailwindcss",
          "lua_ls",
          "emmet_ls",
          "prismals",
          "pyright",
          "clangd"
        },
        automatic_installation = true
      })
    end
  },

  -- Floating term
  {'akinsho/toggleterm.nvim', version = "*", config = function()
    require("toggleterm").setup{
      direction = 'float',
      open_mapping = [[<C-\>]],
      insert_mappings = false,
    }
  end
  },

}, {})

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

-- Save undo history
vim.o.undofile = true

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

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<leader>g', ':Git<CR>', { noremap = true})
vim.keymap.set({ 'n', 'v' }, '<leader>e', ':Explore<CR>', { noremap = true})
vim.keymap.set({ 'n', 'v' }, '<leader>gb', ':GBrowse<CR>', { noremap = true})
vim.keymap.set({ 'n', 'v' }, '<leader>wj', ':wincmd j<CR>', { noremap = true})
vim.keymap.set({ 'n', 'v' }, '<leader>wk', ':wincmd k<CR>', { noremap = true})
vim.keymap.set({ 'n', 'v' }, '<leader>s', ':Telescope  find_files<CR>', { noremap = true})
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { noremap = true})



-- document existing key chains
require('which-key').register {
  ['<leader>e'] = { name = '[E]xplore', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]erminal', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]indow', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
}

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

vim.cmd('highlight! HarpoonInactive guibg=NONE guifg=#63698c')
vim.cmd('highlight! HarpoonActive guibg=NONE guifg=white')
vim.cmd('highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7')
vim.cmd('highlight! TabLineFill guibg=NONE guifg=white')
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
