return {
  "jakemason/ouroboros.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },

  ft = { "c", "cpp", "h", "hpp" }, -- load when opening these filetypes

  config = function()
    require("ouroboros").setup({
      -- these are the defaults; tweak if you want
      extension_preferences_table = {
        c = { h = 2, hpp = 1 },
        h = { c = 2, cpp = 1 },
        cpp = { hpp = 2, h = 1 },
        hpp = { cpp = 1, c = 2 },
      },
      switch_to_open_pane_if_possible = false,
    })

    -- Filetype-specific keymap for c/cpp
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "c", "cpp" },
      callback = function(ev)
        vim.keymap.set("n", "<A-o>", "<cmd>Ouroboros<CR>", { buffer = ev.buf, desc = "Switch header/source" })
      end,
    })
  end,
}
