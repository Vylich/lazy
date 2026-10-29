-- В списке пикера совпадения по умолчанию только окрашены (Special) и тонут в
-- подсветке синтаксиса grep-результатов. Даём им фон как у поиска + жирный.
local function set_match_hl()
  local search = vim.api.nvim_get_hl(0, { name = "Search", link = false })
  vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = search.fg, bg = search.bg, bold = true })
end

return {
  "folke/snacks.nvim",
  init = function()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_match_hl })
    set_match_hl()
  end,
}
