return{
  -- Adding coding activity tracking
  'wakatime/vim-wakatime',

  -- Adding Copilot
  'github/copilot.vim',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Syntax highlighting
  'nvim-treesitter/nvim-treesitter',

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- Auto saving
  {
    "Pocco81/auto-save.nvim",
    config = function()
       require("auto-save").setup {
        -- your config goes here
        -- or just leave it empty :)
       }
    end,
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

}
