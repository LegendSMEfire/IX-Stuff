local PLUGIN = PLUGIN

PLUGIN.name = "Weapon Warning"
PLUGIN.author = "Ported by KINGXIII and Toha3673 from Apex Gamemode"
PLUGIN.description = ""



if (CLIENT) then
	function PLUGIN:HUDPaint()
	---------------------BUG FIX--------------------------------
	if not IsValid(LocalPlayer()) then return end
	if LocalPlayer():GetActiveWeapon() == nil then return end
	if not IsValid(LocalPlayer():GetActiveWeapon()) then return end
	------------------------------------------------------------
		draw.RoundedBox(0,ScrW() * 0.1, ScrH() * 0.85 - 2.5, 260, 60, Color(0, 0, 0, 225))
		if LocalPlayer():GetActiveWeapon():GetClass()  and LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physgun" then
			draw.DrawText("Use only the "..language.GetPhrase( "weapon_physgun" ).." for build.\nUse it in a roleplay situation \nis punishable.",  "BudgetLabel", ScrW() * 0.1, ScrH() * 0.85, Color(255, 0, 0, 255), 0)
		elseif LocalPlayer():GetActiveWeapon():GetClass()  and LocalPlayer():GetActiveWeapon():GetClass() == "gmod_tool" then
			draw.DrawText("Use only the  "..language.GetPhrase( "gmod_tool" ).." for build.\nUse it in a roleplay situation \nis punishable.",  "BudgetLabel", ScrW() * 0.1, ScrH() * 0.85, Color(255, 0, 0, 255), 0)
		elseif LocalPlayer():GetActiveWeapon():GetClass()  and LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physcannon" then
			draw.DrawText("Use only the  "..language.GetPhrase( "weapon_physcannon" ).." for build.\nUse it in a roleplay situation \nis punishable.",  "BudgetLabel", ScrW() * 0.1, ScrH() * 0.85, Color(255, 0, 0, 255), 0)
		end
	end
end