-- рамки для всплывашек, которые не смотрят на vim.o.winborder
return {
  {
    "folke/noice.nvim",
    opts = {
      presets = { lsp_doc_border = true }, -- hover и сигнатуры
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      win = { border = "rounded" },
    },
  },
}
