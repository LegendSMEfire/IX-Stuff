PLUGIN.name = "Enhanced Visual Overlay";
PLUGIN.author = "CW: viomi, NS: DrodA, IX : KINGXIII";
PLUGIN.desc = "EVO";

ix.util.IncludeDir("hooks");

local playerMeta = FindMetaTable("Player")
function playerMeta:GetDigits() -- i took the ns function to make it work (kingxiii)
	if (self:IsCombine()) then
		local name = self:Name():reverse()
		local digits = name:match("(%d+)")

		if (digits) then
			return tostring(digits):reverse()
		end
	end

	return "UNKNOWN"
end

PLUGIN.evo = {};
PLUGIN.evo.config =
{
	MaxDistance = 400,
	colormal = Color(255, 10, 0, 255),
	coloryel = Color(255, 215, 0, 255),
	colorgre = Color(50, 205, 50, 255),
	color = Color(0, 128, 255, 255),
	colorcitizen = Color(255, 250, 250, 255)
}

IX_CVAR_NAMES = CreateClientConVar("nevo_names", 1, true, true);
IX_CVAR_HUD = CreateClientConVar("nevo_hud", 1, true, true);
IX_CVAR_OUTLINES = CreateClientConVar("nevo_outlines", 1, true, true);

if (CLIENT) then
	surface.CreateFont( "HUDFont",
	{
		font = "BudgetLabel",
		size = 16,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false
	})

	surface.CreateFont( "NameFont",
	{
		font = "BudgetLabel",
		size = 18,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = true
	})

	// meh
	function PLUGIN:HUDPaint()
		local client = LocalPlayer();
		if !IsValid(client) or !client:Alive() then return end;
		if !client:IsCombine() then return end;

		local MaxDistance = self.evo.config.MaxDistance;
		local Maximum = 600;
		local Digits = client:GetDigits();

		if (Digits) then
			if (Digits == "5254") then
				Maximum = 4096;
			elseif (Digits == "0246") then
				Maximum = 3000;
			elseif (Digits == "0831") then
				Maximum = 1024;
			end;

			MaxDistance = math.Clamp(MaxDistance, 0, Maximum);
			for _, v in ipairs(player.GetAll()) do
				if (v:GetMoveType() == MOVETYPE_NOCLIP) then continue end;
				if (v == client) then continue end;
				if v:GetPos():Distance(client:GetPos()) > MaxDistance then continue end;

				local Position = (v:GetPos() + Vector(0, 0, 80)):ToScreen();

				if (IX_CVAR_NAMES:GetBool() and v:IsCombine()) then
					Position.y = Position.y + 15;

					draw.DrawText("#"..v:GetDigits(), "NameFont", Position.x, Position.y, Color(0, 128, 255, 255), 1);
				end;

				if client:IsLineOfSightClear(v:GetPos()) then
					if IX_CVAR_HUD:GetBool() then
						if (v:Health() <= 0) then
							Position.y = Position.y + 20;

							draw.DrawText("<:: "..L("EVOMainNoVital"), "HUDFont", Position.x, Position.y, self.evo.config.colormal, 1);
						elseif (v:Health() <= 10) then
							Position.y = Position.y + 20;

							draw.DrawText("<:: "..L("EVOMainNearDeath"), "HUDFont", Position.x, Position.y, self.evo.config.colormal, 1);
						elseif (v:Health() <= 90) then
							Position.y = Position.y + 20;

							draw.DrawText("<:: "..L("EVOMainInjuryDetected"), "HUDFont", Position.x, Position.y, self.evo.config.coloryel, 1);
						end;

						if (v:GetNetVar("tying") and !v:IsCombine()) then
							Position.y = Position.y + 15;

							draw.DrawText("<:: "..L("EVOMainRestrainedCitizen"), "HUDFont", Position.x, Position.y, self.evo.config.colorgre, 1);
						elseif (v:GetNetVar("tying") and v:IsCombine()) then
							Position.y = Position.y + 15;

							draw.DrawText("<:: "..L("EVOMainRestrainedUnit"), "HUDFont", Position.x, Position.y, self.evo.config.coloryel, 1);
						end;

						if v:FlashlightIsOn() then
							Position.y = Position.y + 15;

							draw.DrawText("<:: "..L("EVOMainFlashlight"), "HUDFont", Position.x, Position.y, self.evo.config.colorgre, 1);
						end;

						if v:IsRunning() then
							if !v:IsCombine() then
								Position.y = Position.y + 20;

								draw.DrawText("<:: "..L("EVOMainRunning"), "HUDFont", Position.x, Position.y, self.evo.config.coloryel, 1);
							end
						elseif (v:Crouching() and v:IsCombine()) then
							Position.y = Position.y + 20;

							draw.DrawText("<:: "..L("EVOMainStealthCitizen"), "HUDFont", Position.x, Position.y, self.evo.config.coloryel, 1);
						elseif (v:Crouching() and v:IsCombine()) then
							Position.y = Position.y + 20;

							draw.DrawText("<:: "..L("EVOMainStealthUnit"), "HUDFont", Position.x, Position.y, self.evo.config.colorgre, 1);		
						end;
					end;
				end;
			end;
		end;
	end;
end;