-- Plugins carried over from the work (AstroNvim) config
return {
  -- jk / jj to leave insert, visual and terminal mode
  { "max397574/better-escape.nvim", event = "VeryLazy", opts = {} },

  -- AI completion; accept with <C-g> in insert mode (first run: :Codeium Auth)
  {
    "Exafunction/windsurf.vim",
    event = "InsertEnter",
    init = function()
      vim.g.codeium_disable_bindings = 1
    end,
    config = function()
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true, replace_keycodes = false, desc = "Codeium Accept" })
    end,
  },

  -- Claude CLI in a side terminal, on <leader>y like at work
  {
    "folke/sidekick.nvim",
    opts = { nes = { enabled = false } },
    -- stylua: ignore
    keys = {
      { "<leader>y", "", desc = "+sidekick", mode = { "n", "v" } },
      { "<leader>yy", function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end, mode = { "n", "t", "i", "x" }, desc = "Sidekick Toggle" },
      { "<leader>yd", function() require("sidekick.cli").close() end, desc = "Detach a CLI Session" },
      { "<leader>yt", function() require("sidekick.cli").send({ name = "claude", focus = true, msg = "{this}" }) end, mode = { "n", "x" }, desc = "Send This" },
      { "<leader>yf", function() require("sidekick.cli").send({ name = "claude", focus = true, msg = "{file}" }) end, desc = "Send File" },
      { "<leader>yv", function() require("sidekick.cli").send({ name = "claude", focus = true, msg = "{selection}" }) end, mode = "x", desc = "Send Visual Selection" },
      { "<leader>yp", function() require("sidekick.cli").prompt() end, mode = { "n", "x" }, desc = "Sidekick Select Prompt" },
    },
  },

  -- git
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { virt_text_pos = "eol", delay = 500 },
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    },
  },
  { "tpope/vim-fugitive", cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "GBrowse" } },
  { "rbong/vim-flog", cmd = { "Flog", "Flogsplit", "Floggit" }, dependencies = { "tpope/vim-fugitive" } },
  { "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" } },

  -- editing
  { "tpope/vim-surround", event = "VeryLazy", dependencies = { "tpope/vim-repeat" } },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-i>",
        ["Find Subword Under"] = "<C-i>",
        ["Select All"] = "<C-a>",
        ["Find Prev"] = "<C-k>",
        ["Find Next"] = "<C-l>",
      }
      vim.g.VM_theme = "iceblue"
    end,
  },
  {
    "Wansmer/treesj",
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" } },
    opts = { use_default_keymaps = false, max_join_length = 150, cursor_behavior = "hold" },
  },
  { "kevinhwang91/nvim-bqf", ft = "qf" },
  { "heavenshell/vim-jsdoc", ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" }, build = "make install" },

  -- jest for neotest (test.core extra); test keys as at work
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = { "nvim-neotest/neotest-jest" },
    opts = { adapters = { ["neotest-jest"] = {} } },
    -- stylua: ignore
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Run nearest test" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file test" },
      { "<leader>to", "<cmd>Neotest output<cr>", desc = "Show test output" },
      { "<leader>ts", "<cmd>Neotest summary<cr>", desc = "Show test summary" },
    },
  },

  -- work keys that collide with keys LazyVim declares in plugin specs
  -- (set here so lazy-loading the plugin doesn't bring the LazyVim key back)
  {
    "mfussenegger/nvim-dap",
    optional = true,
    -- stylua: ignore
    keys = {
      { "<leader>dn", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>ds", vim.diagnostic.setloclist, desc = "LSP diagnostic loclist" },
    },
  },
  {
    "mason-org/mason.nvim",
    keys = { { "<leader>cm", function() Snacks.picker.git_log() end, desc = "Git Commits" } },
  },
  {
    "folke/persistence.nvim",
    keys = { { "<leader>qd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Open Document Trouble" } },
  },

  -- <C-f> belongs to the float terminal, not to noice doc scrolling
  {
    "folke/noice.nvim",
    optional = true,
    keys = { { "<c-f>", false, mode = { "i", "n", "s" } } },
  },

  {
    "folke/snacks.nvim",
    opts = {
      -- terminal lives only on <C-f>: drop the buffer-local <C-/> hide keys
      terminal = { win = { keys = { hide_slash = false, hide_underscore = false } } },
      -- highlight references under the cursor immediately, like vim-illuminate delay = 0
      words = { debounce = 0 },
      dashboard = {
        preset = {
          header = [[
██╗   ██╗██╗   ██╗██╗     ██╗ ██████╗██╗  ██╗
██║   ██║╚██╗ ██╔╝██║     ██║██╔════╝██║  ██║
██║   ██║ ╚████╔╝ ██║     ██║██║     ███████║
╚██╗ ██╔╝  ╚██╔╝  ██║     ██║██║     ██╔══██║
 ╚████╔╝    ██║   ███████╗██║╚██████╗██║  ██║
  ╚═══╝     ╚═╝   ╚══════╝╚═╝ ╚═════╝╚═╝  ╚═╝

    ███╗   ██╗██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██║   ██║██║████╗ ████║
    ██╔██╗ ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
        },
      },
    },
  },

  -- <leader>w is Save, so drop the which-key "windows" proxy group
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      local function strip(spec)
        for i = #spec, 1, -1 do
          local item = spec[i]
          if type(item) == "table" then
            if item[1] == "<leader>w" then
              table.remove(spec, i)
            else
              strip(item)
            end
          end
        end
      end
      strip(opts.spec or {})
    end,
  },
}
