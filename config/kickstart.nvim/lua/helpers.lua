local M = {}

--- Extends list, ensuring unique values
--- @param original string[]
--- @param ext string[]
function M.list_extend_unique(original, ext)
  for v in ext do
    if not vim.list_contains(original, v) then
      vim.list_extend(original, v)
    end
  end
end

return M
