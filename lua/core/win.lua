---@class core.win.State
---@field buf number
---@field win number

---@class core.win.Opts
---@field state? core.win.State
---@field height? number
---@field width? number
---@field width_ratio? number
---@field height_ratio? number
---@field on_open? fun(bufnr: number, winnr: number)

---Create a floating window
---@param opts core.win.Opts
---@return core.win.State
local function create_floating(opts)
  opts = opts or { state = { buf = -1, win = -1 }, height_ratio = 0.8, width_ratio = 0.8 }

  local width = opts.width or math.floor(vim.o.columns * opts.width_ratio)
  local height = opts.height or math.floor(vim.o.lines * opts.height_ratio)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  if opts.state.buf == -1 or not vim.api.nvim_buf_is_valid(opts.state.buf) then
    opts.state.buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }

  if opts.state.win == -1 or not vim.api.nvim_win_is_valid(opts.state.win) then
    opts.state.win = vim.api.nvim_open_win(opts.state.buf, true, win_config)
    if opts.on_open then
      opts.on_open(opts.state.buf, opts.state.win)
    end
  end

  return opts.state
end
