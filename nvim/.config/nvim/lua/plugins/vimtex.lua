return {
  {
    "lervag/vimtex",
    ft = { "tex", "bib" },
    init = function()
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "*.tex",
        callback = function(ev)
          if vim.bo[ev.buf].filetype == "" then
            vim.bo[ev.buf].filetype = "tex"
          end
        end,
      })
      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_general_viewer = "evince"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk_engines = {
        _ = "-pdf",
      }
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_fold_enabled = 1
    end,
    config = function()
      -- vimtex needs the regex-based syntax engine; keep tree-sitter from
      -- hiding it (see :h vimtex-faq-treesitter)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "tex", "bib" },
        callback = function()
          vim.bo.syntax = "tex"
        end,
      })
    end,
  },

  -- never hand latex highlighting to tree-sitter (no parser / vimtex is better)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.highlight = opts.highlight or {}
      opts.highlight.disable = opts.highlight.disable or {}
      vim.list_extend(opts.highlight.disable, { "latex" })
    end,
  },
}
