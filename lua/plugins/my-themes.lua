-- Темы из прошлого конфига (NvChad base46 / AstroNvim)
-- base46 работает только внутри NvChad, поэтому здесь отдельные плагины тех же тем
local themes = {
	"Ferouk/bearded-nvim",
	"olimorris/onedarkpro.nvim",
	"Shatur/neovim-ayu",
	"Mofiqul/dracula.nvim",
	"projekt0n/github-nvim-theme",
	"shaunsingh/nord.nvim",
	"rmehri01/onenord.nvim",
	"marko-cerovac/material.nvim",
	"oxfist/night-owl.nvim",
	"Mofiqul/vscode.nvim",
	"craftzdog/solarized-osaka.nvim",
	"maxmx03/solarized.nvim",
	"savq/melange-nvim",
	"olivercederborg/poimandres.nvim",
	"datsfilipe/vesper.nvim",
	"mhartington/oceanic-next",
	"tiagovla/tokyodark.nvim",
	"eldritch-theme/eldritch.nvim",
	"phha/zenburn.nvim",
	"wtfox/jellybeans.nvim",
	"akinsho/horizon.nvim",
	"junegunn/seoul256.vim",
	"decaycs/decay.nvim",
	"FrenzyExists/aquarium-vim",
	"kdheepak/monochrome.nvim",
	"diegoulloao/neofusion.nvim",
	"sam4llis/nvim-tundra",
}

local specs = {
	{ "AstroNvim/astrotheme", lazy = false, priority = 1000, opts = {} },
	{ "embark-theme/vim", name = "embark", lazy = false, priority = 1000 },
	{ "Everblush/nvim", name = "everblush", lazy = false, priority = 1000 },
	-- rockspec тянет fennel через luarocks, а цвета уже собраны
	{ "nyoom-engineering/oxocarbon.nvim", lazy = false, priority = 1000, build = false },
}
for _, repo in ipairs(themes) do
	table.insert(specs, { repo, lazy = false, priority = 1000 })
end

return specs
