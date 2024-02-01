return {
  -- Github theme for neovim
  {
    'projekt0n/github-nvim-theme',
    lazy = false,    -- make sure we load this during startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({
        -- Set theme variant (options: dark, dimmed, light, high_contrast)
      })
    end,
  },

  -- Transparent background to match with terminal
  { 'xiyaowong/transparent.nvim' },

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
            outerbg = nil,
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
}
