-- plugin: hop
-- url: https://github.com/phaazon/hop.nvim
local ok, hop = pcall(require, 'hop')
if not ok then
    return
end

hop.setup({})
