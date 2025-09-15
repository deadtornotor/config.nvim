--[[
local opts = {
  heading = {
    sign = fal
  }
}
  --]]

return {
  spec = {
    src = "https://github.com/MeanderingProgrammer/render-markdown.nvim.git"
  },
  setup = function()
    require("render-markdown").setup()
  end,
}
