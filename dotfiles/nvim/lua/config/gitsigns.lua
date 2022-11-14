-- plugin: Gitsigns
-- url: https://github.com/lewis6991/gitsigns.nvim
local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then
    return
end


gitsigns.setup({
	signcolumn = true,
	current_line_blame = false, -- toggle with `:Gitsigns toggle_current_line_blame
	current_line_blame_opts = {
		virt_text_pos = 'eol',
		delay = 500,
	},
})
