-- SonarLint (installed via Mason in work-lsp.lua); needs java, which comes from mise
local filetypes = {
  "javascript",
  "javascriptreact",
  "typescript",
  "typescriptreact",
  "css",
  "scss",
  "html",
  "python",
}

return {
  {
    url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
    ft = filetypes,
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local analyzers = vim.fn.stdpath("data") .. "/mason/share/sonarlint-analyzers/"
      require("sonarlint").setup({
        server = {
          cmd = {
            "sonarlint-language-server",
            "-stdio",
            "-analyzers",
            analyzers .. "sonarjs.jar",
            analyzers .. "sonarhtml.jar",
            analyzers .. "sonarpython.jar",
          },
        },
        filetypes = filetypes,
      })
    end,
  },
}
