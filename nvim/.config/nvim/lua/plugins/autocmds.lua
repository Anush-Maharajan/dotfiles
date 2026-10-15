vim.api.nvim_create_autocmd("FileType", {
  pattern = "image",
  callback = function(ev)
    vim.bo[ev.buf].bufhidden = "wipe"
  end,
})

local function fix_unused()
  vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { link = "Normal" })
end

local function make_transparent()
  for _, group in ipairs({
    "NormalFloat",
    "FloatBorder",
    "BufferLineFill",
    "BufferLineBackground",
    "TabLineFill",
  }) do
    vim.api.nvim_set_hl(0, group, { bg = "NONE" })
  end
end

local function apply()
  fix_unused()
  make_transparent()
end

apply()
vim.api.nvim_create_autocmd("ColorScheme", { callback = apply })

return {}
