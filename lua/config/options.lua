-- Options are automatically loaded before lazy.nvim startup.
require("config.remote_clipboard").setup()

vim.opt.relativenumber = true
-- рамка у всех всплывающих окон (фон у них прозрачный, см. plugin/after/transparency.lua)
vim.o.winborder = "rounded"
vim.g.autoformat = false

-- Normal-mode commands keep working with the Russian layout active
-- (mappings are duplicated by langmapper.nvim, see plugins/langmapper.lua)
local function escape(str)
  return vim.fn.escape(str, [[;,."|\]])
end
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm,.]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмитьбю]]
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]
vim.opt.langmap = table.concat({
  escape(ru_shift) .. ";" .. escape(en_shift),
  escape(ru) .. ";" .. escape(en),
}, ",")
