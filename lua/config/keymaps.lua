-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Keymaps below mirror the work (AstroNvim) config and override LazyVim defaults where they clash.
-- Keys LazyVim declares in plugin specs (neotest, dap, mason, persistence) are overridden in plugins/work.lua.

local map = vim.keymap.set

-- LazyVim window maps under <leader>w would make <leader>w (Save) wait for timeoutlen
pcall(vim.keymap.del, "n", "<leader>wd")
pcall(vim.keymap.del, "n", "<leader>wm")

-- terminal lives only on <C-f>
for _, lhs in ipairs({ "<c-/>", "<c-_>" }) do
  pcall(vim.keymap.del, { "n", "t" }, lhs)
end

map("n", ";", ":", { desc = "CMD enter command" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<C-q>", "<cmd>q!<cr>", { desc = "Force Quit" })

-- float terminal: the only terminal toggle, sized like nvterm at work.
-- Kept as one instance: Snacks.terminal() keys terminals by cwd, and LazyVim.root()
-- inside the terminal differs from the file's root, so a second press opened a new one.
local float_term
map({ "n", "t" }, "<C-f>", function()
  if float_term and float_term:buf_valid() then
    float_term:toggle()
    return
  end
  float_term = Snacks.terminal.open(nil, {
    cwd = LazyVim.root(),
    win = { position = "float", width = 0.7, height = 0.6, row = 0.2, col = 0.15, border = "single" },
  })
end, { desc = "Toogle Terminal Float" })
map("t", "<C-x>", "<C-\\><C-n>", { desc = "Terminal Escape" })

-- insert mode
map("i", "оо", "<Esc>")
map("i", "<C-b>", "<Esc>^i", { desc = "Move Beginning of Line" })
map("i", "<C-e>", "<End>", { desc = "Move End of Line" })
map("i", "<C-h>", "<Left>", { desc = "Move Left" })
map("i", "<C-l>", "<Right>", { desc = "Move Right" })
map("i", "<C-j>", "<Down>", { desc = "Move Down" })
map("i", "<C-k>", "<Up>", { desc = "Move Up" })

-- pickers
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Find Files" })
map("n", "<leader>fa", function() Snacks.picker.files({ hidden = true, ignored = true, follow = true }) end, { desc = "Find All Files" })
map("n", "<leader>fw", function() Snacks.picker.grep() end, { desc = "Live Grep" })
map("n", "<leader>fz", function() Snacks.picker.lines() end, { desc = "Find in Current Buffer" })
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Find Buffers" })
map("n", "<leader>fh", function() Snacks.picker.help() end, { desc = "Help Pages" })
map("n", "<leader>fo", function() Snacks.picker.recent() end, { desc = "Find Oldfiles" })
map("n", "<leader>ft", function() Snacks.picker.todo_comments() end, { desc = "Find Todo" })
map("n", "<leader>ma", function() Snacks.picker.marks() end, { desc = "Find Marks" })
map("n", "<leader>th", function() Snacks.picker.colorschemes() end, { desc = "Themes" })

-- quickfix
map("n", "<leader>fq", "<cmd>copen<cr>", { desc = "Open Quickfix List" })
map("n", "<leader>fn", "<cmd>cnext<cr>", { desc = "Quickfix Next" })
map("n", "<leader>fp", "<cmd>cprev<cr>", { desc = "Quickfix Prev" })

-- comments
map("n", "<leader>/", "gcc", { remap = true, desc = "Toggle Comment" })
map("x", "<leader>/", "gc", { remap = true, desc = "Toggle Comment" })

-- diagnostics
map("n", "<leader>a", vim.diagnostic.open_float, { desc = "Show Trouble" })
map("n", "<leader>k", vim.diagnostic.open_float, { desc = "Open Diagnostic" })

-- trouble
map("n", "<leader>qx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Open Trouble" })
map("n", "<leader>qw", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Open Workspace Trouble" })
map("n", "<leader>qq", "<cmd>Trouble qflist toggle<cr>", { desc = "Open Quickfix" })
map("n", "<leader>ql", "<cmd>Trouble loclist toggle<cr>", { desc = "Open Location List" })
map("n", "<leader>qt", "<cmd>Trouble todo toggle<cr>", { desc = "Open Todo Trouble" })

-- git
map("n", "<leader>i", "<cmd>Gitsigns blame_line<cr>", { desc = "Gitsigns Blame" })
map("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
map("n", "<leader>gl", "<cmd>Flog<cr>", { desc = "Git Log" })
map("n", "<leader>gf", "<cmd>DiffviewFileHistory<cr>", { desc = "Git File History" })
map("n", "<leader>gc", "<cmd>DiffviewOpen HEAD~1<cr>", { desc = "Git Last Commit" })
map("n", "<leader>gt", function() Snacks.picker.git_status() end, { desc = "Git Status" })
map("n", "<leader>lg", function() Snacks.lazygit() end, { desc = "LazyGit" })
map("n", "<C-d>", "<cmd>DiffviewOpen<cr>", { desc = "Show Diff" })
map("n", "<C-e>", "<cmd>DiffviewClose<cr>", { desc = "Exit Diff" })
map("n", "<C-w>", "<cmd>DiffviewFileHistory<cr>", { desc = "Diff File History" })

-- buffers
map("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", { desc = "Buffer Goto Next" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Buffer Goto Prev" })
map("n", "<leader>x", function() Snacks.bufdelete() end, { desc = "Buffer Close" })
map("n", "<leader>cx", function() Snacks.bufdelete.all() end, { desc = "Close All Buffers" })
map("n", "<leader>bC", function() Snacks.bufdelete.all() end, { desc = "Close All Buffers" })

-- explorer
map("n", "<C-n>", "<cmd>Neotree toggle<cr>", { desc = "Explorer Toggle" })
map("n", "<leader>1", "<cmd>Neotree reveal filesystem<cr>", { desc = "Set Tab File" })
map("n", "<leader>2", "<cmd>Neotree reveal buffers<cr>", { desc = "Set Tab Buffs" })
map("n", "<leader>3", "<cmd>Neotree reveal git_status<cr>", { desc = "Set Tab Git" })

-- windows
map("n", "\\", "<cmd>vsplit<cr>", { desc = "Vertical Split" })
map("n", "-", "<cmd>split<cr>", { desc = "Horizontal Split" })

local function resize_window(direction, amount)
  local win = vim.api.nvim_get_current_win()
  if direction == "left" then
    vim.api.nvim_win_set_width(win, math.max(10, vim.api.nvim_win_get_width(win) - amount))
  elseif direction == "right" then
    vim.api.nvim_win_set_width(win, vim.api.nvim_win_get_width(win) + amount)
  elseif direction == "up" then
    vim.api.nvim_win_set_height(win, math.max(5, vim.api.nvim_win_get_height(win) - amount))
  elseif direction == "down" then
    vim.api.nvim_win_set_height(win, vim.api.nvim_win_get_height(win) + amount)
  end
end

map("n", "<A-h>", function() resize_window("left", 5) end, { desc = "Decrease Window Width" })
map("n", "<A-l>", function() resize_window("right", 5) end, { desc = "Increase Window Width" })
map("n", "<A-k>", function() resize_window("up", 3) end, { desc = "Decrease Window Height" })
map("n", "<A-j>", function() resize_window("down", 3) end, { desc = "Increase Window Height" })

local function move_float(drow, dcol)
  local win = vim.api.nvim_get_current_win()
  local config = vim.api.nvim_win_get_config(win)
  if config.relative ~= "" then
    config.row = config.row + drow
    config.col = config.col + dcol
    vim.api.nvim_win_set_config(win, config)
  end
end

map("n", "<A-y>", function() move_float(-3, 0) end, { desc = "Move Float Up" })
map("n", "<A-u>", function() move_float(3, 0) end, { desc = "Move Float Down" })
map("n", "<A-i>", function() move_float(0, -5) end, { desc = "Move Float Left" })
map("n", "<A-o>", function() move_float(0, 5) end, { desc = "Move Float Right" })

-- misc
map("n", "<C-c>", "<cmd>%y+<cr>", { desc = "Copy Whole File" })
map("n", "<leader>n", "<cmd>set number!<cr>", { desc = "Toggle Line Number" })
map("n", "<leader>rn", "<cmd>set relativenumber!<cr>", { desc = "Toggle Relative Number" })
map("n", "<leader>fm", function() LazyVim.format({ force = true }) end, { desc = "Format File" })
map("n", "<leader>rf", "<cmd>GrugFar<cr>", { desc = "Find and Replace" })
map("n", ">", "<cmd>JsDoc<cr>", { desc = "JsDoc" })
