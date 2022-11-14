-- plugin: lsp-colors
-- url: https://github.com/folke/lsp-colors.nvim
local ok, lspcolors = pcall(require, 'lsp-colors')
if not ok then
    return
end

lspcolors.setup({
        -- default colors if something went wrong
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10B981"
})
