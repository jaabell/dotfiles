vim.keymap.set("n", "<A-PageUp>", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<A-PageDown>", ":bnext<CR>", { desc = "Next buffer" })

local function mdserve_preview(target)
  vim.fn.jobstart({ "mdserve", target, "-o" }, { detach = true })
end

local function mdserve_check()
  if vim.bo.ft ~= "markdown" then
    vim.notify("mdserve: not a markdown buffer", vim.log.levels.WARN)
    return false
  end
  return true
end

vim.keymap.set("n", "<leader>mp", function()
  if mdserve_check() then
    mdserve_preview(vim.api.nvim_buf_get_name(0))
  end
end, { desc = "Preview file with mdserve" })
vim.keymap.set("n", "<leader>mP", function()
  if mdserve_check() then
    mdserve_preview(vim.fn.expand("%:p:h"))
  end
end, { desc = "Preview directory with mdserve (sidebar)" })
