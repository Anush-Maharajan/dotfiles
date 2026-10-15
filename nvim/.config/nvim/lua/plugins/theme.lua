return {
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     style = "moon",
  --     transparent = true,
  --     styles = {
  --       sidebars = "transparent",
  --       floats = "transparent",
  --       keywords = { italic = true },
  --       comments = { italic = true },
  --     },
  --   },
  --   on_colors = function(c)
  --     c.magenta = "#f92672" -- monokai pink for keywords
  --     c.green = "#a6e22e" -- monokai green for functions
  --   end,
  -- },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = { colorscheme = "tokyonight" },
  -- },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_enable_italic = 1
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "gruvbox-material" },
  },
}
