-- plugin: mason
-- url: https://github.com/williamboman/mason.nvim
local ok, mason = pcall(require, "mason")
if not ok then
  return
end


mason.setup({
  ui = {
    border = "rounded",
  },
  max_concurrent_installers = 8,
})
