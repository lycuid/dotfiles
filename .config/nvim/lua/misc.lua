local OpenNewWindow = function(buf)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  local opt = {
    relative  = "editor",
    border    = "rounded",
    row       = row,
    col       = col,
    width     = width,
    height    = height,
  }
  local win = vim.api.nvim_open_win(buf, true, opt)
  vim.api.nvim_win_set_option(win, "winhl", "Normal:")
  vim.cmd("set nonu nornu")
  return win
end

_G.ToggleTerm = function()
  local BUFNAME = "scratchterm"
  local scratchterm = {buf = vim.fn.bufnr(BUFNAME), new = false}
  local currentbuf = vim.fn.bufnr()

  if currentbuf == scratchterm.buf then
    vim.api.nvim_win_hide(0)
    return nil
  end

  if vim.fn.bufexists(scratchterm.buf) == 0 then
    scratchterm.buf = vim.api.nvim_create_buf(false, true)
    scratchterm.new = true
  end

  local win = OpenNewWindow(scratchterm.buf)
  if scratchterm.new then
    vim.cmd(":terminal")
    vim.api.nvim_buf_set_option(scratchterm.buf, "bufhidden", "hide")
    vim.api.nvim_buf_set_name(scratchterm.buf, BUFNAME)
  end
end

vim.api.nvim_set_keymap("n", "<a-`>", ":lua ToggleTerm()<cr>", {noremap = true})
vim.api.nvim_set_keymap("t", "<leader>`", "<c-\\><c-n>", {noremap = true})
