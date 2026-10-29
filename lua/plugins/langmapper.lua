-- Все маппинги работают и на русской раскладке: langmapper оборачивает
-- vim.keymap.set и регистрирует переведённую копию каждого lhs.
-- Движения и обычные команды переводит vim.opt.langmap (config/options.lua).
return {
  "Wansmer/langmapper.nvim",
  lazy = false,
  priority = 10000, -- раньше остальных, чтобы перехватить их маппинги
  config = function()
    local langmapper = require("langmapper")
    -- раскладка ru (ЙЦУКЕН) у плагина по умолчанию
    langmapper.setup({})
    -- which-key и blink видят только латинские маппинги, без дублей
    langmapper.hack_get_keymap()

    -- маппинги, созданные до загрузки плагина (keys = {} у lazy.nvim, LazyVim),
    -- и встроенные: переводим после того, как LazyVim загрузил keymaps
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      once = true,
      callback = function()
        vim.schedule(function()
          langmapper.automapping({ global = true, buffer = true })
        end)
      end,
    })
  end,
}
