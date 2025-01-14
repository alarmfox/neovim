local state = {
  floating = {
    buf = -1,
    win = -1
  }
}
function create_floating_window(opts)
  opts = opts or {}
  -- Create a buffer and configure it
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end
  -- Get the editor's dimensions
  local ui = vim.api.nvim_list_uis()[1]
  local width = math.floor(ui.width * .75)   -- 60% of the screen width
  local height = math.floor(ui.height * .75) -- 40% of the screen height
  local col = math.floor((ui.width - width) / 2)
  local row = math.floor((ui.height - height) / 2)

  -- Configure window options
  local config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded', -- You can use 'single', 'double', or 'none' as well
  }

  -- Create the floating window
  win = vim.api.nvim_open_win(buf, true, config)

  return { buf = buf, win = win }
end

local function toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window({ buf = state.floating.buf })
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set({ "n", "t" }, "<space>ft", toggle_terminal, { desc = "Toggle floating terminal" })
