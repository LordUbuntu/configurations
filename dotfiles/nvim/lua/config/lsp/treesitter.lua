-- plugin: nvim-treesitter
-- url: https://github.com/nvim-treesitter/nvim-treesitter
local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not ok then
  return
end


treesitter.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
      "c",
      "cpp",
      "lua",
      "python",
      "haskell",
      "javascript",
      "html",
      "css",
      "bash",
  },
  sync_install = false,
  auto_install = false,  -- set to true for automagic install of missing TS
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- additional_vim_regex_highlighting = false,  -- may cause slowdowns and duplications
  },
}
