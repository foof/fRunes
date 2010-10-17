if (select(2, UnitClass("player")) ~= "DEATHKNIGHT") then return end

local fRunesSettings = {
	texture = TukuiCF.media.normTex,
	
	width = 50,
	height = 8,
	
	anchor = UIParent,
	x = 0,
	y = 200,
}

local runecolors = {
	{.69,.31,.31}, -- blood
	{.33,.59,.33}, -- unholy
	{.31,.45,.63}, -- frost
	{.84,.75,.65}, -- death
}

local runes = {}

fRunes = CreateFrame("Frame", "fRunes", oUF_Tukz_player)
fRunes:SetSize(fRunesSettings.width, fRunesSettings.height * 6 + 9)
fRunes:SetPoint("BOTTOM", fRunesSettings.anchor, "BOTTOM", fRunesSettings.x, fRunesSettings.y)
TukuiDB.SetTemplate(fRunes)
if (TukuiDB.StyleShadow) then
	TukuiDB.StyleShadow(fRunes)
elseif (TukuiDB.CreateShadow) then
	TukuiDB.CreateShadow(fRunes)
end

for i = 1, 6 do
	local rune = CreateFrame("StatusBar", "fRunesRune"..i, fRunes)
	rune:SetStatusBarTexture(fRunesSettings.texture)
	rune:SetStatusBarColor(unpack(runecolors[math.ceil(i/2)]))
	rune:SetHeight(fRunesSettings.height)
	rune:SetMinMaxValues(0, 10)
	
	if (i == 1) then
		rune:SetPoint("TOPLEFT", fRunes, "TOPLEFT", 2, -2)
		rune:SetPoint("TOPRIGHT", fRunes, "TOPRIGHT", -2, -2)
	else
		rune:SetWidth(runes[1]:GetWidth())
		rune:SetPoint("TOP", runes[i-1], "BOTTOM", 0, -1)
	end
	
	tinsert(runes, rune)
end

local function UpdateRune(id, start, duration, finished)
	local rune = runes[id]
	
	rune:SetStatusBarColor(unpack(runecolors[GetRuneType(id)]))
	rune:SetMinMaxValues(0, duration)
	
	if (finished) then
		rune:SetValue(duration)
	else
		rune:SetValue(GetTime() - start)
	end
end

local OnUpdate = CreateFrame("Frame")
OnUpdate.TimeSinceLastUpdate = 0
OnUpdate:SetScript("OnUpdate", function(self, elapsed)
	self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed; 	

	if (self.TimeSinceLastUpdate > 0.07) then
		for i = 1, 6 do
			UpdateRune(i, GetRuneCooldown(i))
		end
		self.TimeSinceLastUpdate = 0
	end
end)


-- hide blizzard runeframe
RuneFrame:Hide()