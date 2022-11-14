-- plugin: impatient
-- url: https://github.com/lewis6991/impatient.nvim

-- table must be populated before impatient is required
_G.__luacache_config = {
  chunks = {
    enable = true,
    path = vim.fn.stdpath('cache')..'/luacache_chunks',
  },
  modpaths = {
    enable = true, -- This optimization breaks the loading order guarantee of the paths in 'runtimepath'. If you rely on this ordering then you can disable this
    path = vim.fn.stdpath('cache')..'/luacache_modpaths',
  }
}
local ok, impatient = pcall(require, "impatient")
if not ok then
  return
end
impatient.enable_profile()
