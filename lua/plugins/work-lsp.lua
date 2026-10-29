-- Mason packages and LSP servers carried over from the work (AstroNvim) config
return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "ast-grep",
        "css-lsp",
        "css-variables-language-server",
        "django-template-lsp",
        "dotenv-linter",
        "eslint-lsp",
        "eslint_d",
        "html-lsp",
        "lua-language-server",
        "prettier",
        "prettierd",
        "prisma-language-server",
        "pyright",
        "rust-analyzer",
        "some-sass-language-server",
        "sonarlint-language-server",
        "stylelint",
        "stylua",
        "typescript-language-server",
      })
    end,
  },

  -- servers that AstroNvim enabled automatically at work
  -- (ts_ls is left off: the typescript extra already runs vtsls)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- free insert-mode <C-k> for the "Move Up" mapping in config/keymaps.lua
        ["*"] = {
          keys = {
            { "<c-k>", false, mode = "i" },
          },
        },
        ast_grep = {},
        cssls = {},
        css_variables = {},
        djlsp = {},
        html = {},
        rust_analyzer = {},
        somesass_ls = {},
        -- сообщения об ошибках на русском (у TypeScript и pyright есть свои переводы)
        vtsls = {
          settings = {
            typescript = { locale = "ru" },
          },
        },
        pyright = {
          cmd_env = { VSCODE_NLS_CONFIG = '{"locale":"ru"}' },
        },
      },
    },
  },

  -- blink's preset also binds <C-k> to signature help
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<C-k>"] = false,
      },
      -- навигация по выпадашке в cmdline; без меню — обычное поведение (история)
      cmdline = {
        keymap = {
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
          ["<Down>"] = { "select_next", "fallback" },
          ["<Up>"] = { "select_prev", "fallback" },
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        css = { "stylelint" },
        scss = { "stylelint" },
        less = { "stylelint" },
      },
    },
  },
}
