return {
  "vyfor/cord.nvim",
  event = "VeryLazy",
  build = ":Cord update",
  opts = {
    display = {
      theme = "minecraft",
    },
  }, -- uses defaults, which are great out of the box
}
