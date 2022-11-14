-- plugin: nvim-web-devicons
-- url: https://github.com/kyazdani42/nvim-web-devicons
local ok, devicons = pcall(require, 'nvim-web-devicons')
if not ok then
    return
end


devicons.setup({
	override = {
		-- add any overrides here
		-- eg:
		zsh = {
			icon = "",
			color = "#428850",
			cterm_color = "65",
			name = "Zsh"
		},
	};
	default = true;
})
