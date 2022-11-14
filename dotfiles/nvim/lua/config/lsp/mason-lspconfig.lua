-- plugin: mason-lspconfig
-- url: https://github.com/williamboman/mason-lspconfig.nvim
-- note: probably dumb to put this here
local mason_ok, masonlsp = pcall(require, "mason-lspconfig")
if not mason_ok then
  return
end


masonlsp.setup({
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "sumneko_lua" }
    ensure_installed = { "clangd", "lua-language-server" },

    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    automatic_installation = false,
})
