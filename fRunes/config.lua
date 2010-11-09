if (select(2, UnitClass("player")) ~= "DEATHKNIGHT") then return end

fRunesSettings = {
	texture = TukuiCF.media.normTex,
	barLength = 40,
	barThickness = 14,
	rpBarThickness = 10,
	anchor = UIParent,
	hideOOC = true,
	x = 0,
	y = 170,
	growthDirection = "VERTICAL", -- HORIZONTAL or VERTICAL
	
	displayRpBar = true, -- runic power bar below the runes
	
	runestrike = true, -- shows a rune strike icon whenever it's usable
	
	colors = {
		{.69,.31,.31}, -- blood
		{.33,.59,.33}, -- unholy
		{.31,.45,.63}, -- frost
		{.84,.75,.65}, -- death
		{0, 0.82, 1}, -- runic power
	},
}