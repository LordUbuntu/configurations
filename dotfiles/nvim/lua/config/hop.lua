-- plugin: hop
-- url: https://github.com/phaazon/hop.nvim
local ok, hop = pcall(require, 'hop')
if not ok then
    return
end


-- setup plugin
hop.setup({})


-- define keymap
vim.keymap.set('n', '<leader>ha', '<cmd>HopAnywhere<CR>')
vim.keymap.set('n', '<leader>hl', '<cmd>HopLine<CR>')
vim.keymap.set('n', '<leader>hw', '<cmd>HopWord<CR>')
vim.keymap.set('n', '<leader>hp', '<cmd>HopPattern<CR>')
-- whichkey
local wk_ok, wk = pcall(require, 'which-key')
if wk_ok then
  wk.register({
    ["<leader>"] = {
      h = {
        name = "+hop",
        a = { '<cmd>HopAnywhere<CR>', "Hop to Anywhere" },
        l = { '<cmd>HopLine<CR>', "Hop to Line" },
        w = { '<cmd>HopWord<CR>', "Hop to Word" },
        p = { '<cmd>HopPattern<CR>', "Hop to Pattern" },
      }
    }
  })
end
