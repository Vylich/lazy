-- Перевод LSP на русский: диагностика текущей строки, а если её нет — hover.
-- Переводит `claude -p` (Haiku): сохраняет markdown и код, ~3 сек на запрос.

local M = {}

local prompt = "Translate the user text to Russian. Keep markdown structure, code blocks, inline code, "
  .. "identifiers, error codes and URLs unchanged. Output only the translation."

local cache = {} ---@type table<string, string>

local function show(text)
  vim.lsp.util.open_floating_preview(vim.split(text, "\n"), "markdown", {
    border = "rounded",
    max_width = 90,
    max_height = 30,
    focus_id = "ru_translate",
  })
end

local function translate(text)
  if cache[text] then
    return show(cache[text])
  end
  vim.notify("Перевожу…", vim.log.levels.INFO, { id = "ru_translate", title = "Перевод" })
  vim.system({
    "claude", "-p",
    "--model", "haiku",
    "--tools", "",
    "--no-session-persistence",
    "--strict-mcp-config",
    "--disable-slash-commands",
    "--system-prompt", prompt,
  }, { stdin = text, text = true }, function(res)
    vim.schedule(function()
      local out = vim.trim(res.stdout or "")
      if res.code ~= 0 or out == "" then
        vim.notify("Не удалось перевести:\n" .. (res.stderr or ""), vim.log.levels.ERROR, { title = "Перевод" })
        return
      end
      cache[text] = out
      show(out)
    end)
  end)
end

local function diagnostics_text()
  local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
  local lines = {}
  for _, d in ipairs(vim.diagnostic.get(0, { lnum = lnum })) do
    local src = d.source and ("**" .. d.source .. "**: ") or ""
    lines[#lines + 1] = "- " .. src .. d.message:gsub("\n", "\n  ")
  end
  return #lines > 0 and table.concat(lines, "\n") or nil
end

function M.cursor()
  local diag = diagnostics_text()
  if diag then
    return translate(diag)
  end
  local params = function(client)
    return vim.lsp.util.make_position_params(0, client.offset_encoding)
  end
  vim.lsp.buf_request_all(0, "textDocument/hover", params, function(results)
    local parts = {}
    for _, r in pairs(results) do
      if r.result and r.result.contents then
        local md = vim.lsp.util.convert_input_to_markdown_lines(r.result.contents)
        if #md > 0 then
          parts[#parts + 1] = table.concat(md, "\n")
        end
      end
    end
    if #parts == 0 then
      return vim.notify("Под курсором нечего переводить", vim.log.levels.WARN, { title = "Перевод" })
    end
    translate(table.concat(parts, "\n\n---\n\n"))
  end)
end

return M
