-- plugin: nvim-lspconfig
-- url: https://github.com/neovim/nvim-lspconfig
-- ref: https://langserver.org/
-- note: servers must be physically installed on machine to work
local lsp_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_ok then
  return
end



----------------
-- GLOBAL LSP
----------------

-- there must be a better way to modify a single table for global settings
--[[local servers = {
  -- c, c++
  "clangd",
  -- lua
  "sumneko_lua",
  -- python
    "pyright",  -- type checking
    "pylsp",    -- full lsp
  -- haskell
  "hls",
  -- javascript, typescript
  "tsserver",
  -- html
  "html",
   -- css
  "cssls"
}
for _, server in ipairs(servers) do
  lspconfig.server.setup({})
end
--]]


------------------
-- LANGUAGE LSP
------------------

-- configure servers
--[[
note: often of the form
require('lspconfig').[server].setup({
    -- configs go here, see url
})
]]--
lspconfig.sumneko_lua.setup({
  -- ... other configs
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      },
      telemetry = {
        enable = false
      },
    },
  },
})


lspconfig.clangd.setup({
  arguments = { "Wall" },
})


-- add marked words to dictionary, can't figure out a better way right now...
local words = {}
for word in io.open((vim.fn.stdpath("config").."/spell/en.utf-8.add"), "r"):lines() do
  table.insert(words, word)
end
lspconfig.ltex.setup({
  settings = {
    ltex = {
      enabled = { "latex", "tex", "bibtex", "bib", "markdown", "text", "html" },
      language = "en-CA",
      dictionary = {
        ["en-CA"] = words,
      },
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "en-CA",
      },
      enabledRules = {},
      disabledRules = {},
      hiddenFalsePositives = {},
      diagnosticSeverity = "information",
      trace = { server = "verbose" },
      sentenceCacheSize = 3000,
    }
  }
})


lspconfig.pylsp.setup({
  settings = {
    pylsp = {  -- python-lsp-server
    }
  }
})
