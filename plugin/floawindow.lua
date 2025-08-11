vim.keymap.set("t", "<esc><esc>", "<C-\\><C-N>")

local window = require("core.win")

local state = {
  --@type core.win.State
  floating_term = {
    buf = -1,
    win = -1,
  },
  --@type core.win.State
  lazy_git = {
    buf = -1,
    win = -1,
  }
}


local function toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.floating_term.win) then
    state.floating_term = window.create_floating({
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


  if require("core.os").type == "windows" then
    vim.opt.shell = "cmd.exe"
    vim.opt.shellcmdflag = "/c"
  end

  if not vim.api.nvim_win_is_valid(state.lazy_git.win) then
    state.lazy_git = window.create_floating({
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
vim.keymap.set({ "n", "t" }, "<leader>t", toggle_terminal, { desc = "Opens a floating terminal" })

vim.api.nvim_create_user_command("LazyGit", toggle_lazygit, {})
vim.keymap.set({ "n", "t" }, "<leader>g", toggle_lazygit, { desc = "Opens Lazygit" })
