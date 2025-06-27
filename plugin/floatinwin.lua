vim.keymap.set("t", "<esc><esc>", "<C-\\><C-N>")


---@class DeadyWinState
---@field buf number
---@field win number

---@class DeadyWinOpts
---@field state? DeadyWinState
---@field height? number
---@field width? number
---@field width_ratio? number
---@field height_ratio? number
---@field on_open? fun(bufnr: number, winnr: number)


local state = {
  floating_term = {
    buf = -1,
    win = -1,
  },
  lazy_git = {
    buf = -1,
    win = -1,
  }
}

---Create a floating window
---@param opts DeadyWinOpts
---@return DeadyWinState
local function create_floating_window(opts)
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

local function toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.floating_term.win) then
    state.floating_term = create_floating_window({
      state = state.floating_term, height_ratio = 0.8, width_ratio = 0.8
    })

    if vim.bo[state.floating_term.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating_term.win)
  end
end

local function toggle_lazygit()
  if vim.fn.executable("lazygit") ~= 1 then
    vim.notify("lazygit is not installed or not in your PATH", vim.log.levels.ERROR)
    return
  end

  if not vim.api.nvim_win_is_valid(state.floating_term.win) then
    state.floating_term = create_floating_window({
      state = state.lazy_git, height_ratio = 0.8, width_ratio = 0.8
    })

    if vim.bo[state.lazy_git.buf].buftype ~= "terminal" then
      vim.cmd.terminal("lazygit")
      local term_buf = state.lazy_git.buf


      vim.api.nvim_create_autocmd("TermClose", {
        buffer = term_buf,
        once = true,
        callback = function()
          if vim.api.nvim_win_is_valid(state.lazy_git.win) then
            vim.api.nvim_win_close(state.lazy_git.win, true)
          end
          if vim.api.nvim_buf_is_valid(state.lazy_git.buf) then
            vim.api.nvim_buf_delete(state.lazy_git.buf, { force = true })
          end
          state.lazy_git.buf = -1
          state.lazy_git.win = -1
        end,
      })
    end

    vim.api.nvim_feedkeys('i', 'n', false)
  else
    vim.api.nvim_win_hide(state.lazy_git.win)
  end
end

vim.api.nvim_create_user_command("FloatinTerm", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<leader>tt", toggle_terminal, { desc = "Opens a floating terminal" })

vim.api.nvim_create_user_command("LazyGit", toggle_lazygit, {})
vim.keymap.set({ "n", "t" }, "<leader>lg", toggle_lazygit, { desc = "Opens Lazygit" })
