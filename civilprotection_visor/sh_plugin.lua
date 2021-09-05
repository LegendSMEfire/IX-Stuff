PLUGIN.name = "New (old) civil protection display";
PLUGIN.author = "DrodA | Ported by KINGXIII";
PLUGIN.desc = "Adds some shity dislay";

Schema.displays = {};
Schema.NextRandomLineTime = 24;

if (CLIENT) then
	surface.CreateFont( "VisorFont",
	{
		font = "BudgetLabel",
		size = 16,
		weight = 250,
		blursize = 0,
		scanlines = 0,
		antialias = false,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = true
	});

	function Schema:HUDPaint()
		Schema.randomDisplayLines =
		{
			L("DisplayLines_1"),
			L("DisplayLines_2"),
			L("DisplayLines_3"),
			L("DisplayLines_4"),
			L("DisplayLines_5"),
			L("DisplayLines_6"),
			L("DisplayLines_7"),
			L("DisplayLines_8"),
			L("DisplayLines_9"),
			L("DisplayLines_10"),
			L("DisplayLines_11"),
			L("DisplayLines_12"),
			L("DisplayLines_13"),
			L("DisplayLines_14"),
			L("DisplayLines_15")
		};

		local scrW, scrH = ScrW(), ScrH();

		local client = LocalPlayer();
		local IsCombine = client:IsCombine();

		if (IsCombine and !IsValid(ix.gui.char)) then
			local x, y = 8, 20;
			local w, h = scrW * 0.5, scrH * 0.2;

			for i = 1, #self.displays do
				local data = self.displays[i];

				if (data) then
					local y2 = y + (i * 22);

					if ((i * 22 + 24) > h) then table.remove(self.displays, 1) end;

					if (#data.realText != #data.text) then
						data.i = (data.i or 0) + 0.4;
						data.realText = data.text:sub(1, data.i);
					end;

					draw.SimpleText("<:: "..data.realText, "VisorFont", x + 8, y2 + 12, data.color);
				end;
			end;
		end;
	end;

	function Schema:Tick()
		local curTime = CurTime();

		local client = LocalPlayer();

		if (IsValid(client) and client:IsCombine()) then
			if (!self.nextRandomLine or curTime >= self.nextRandomLine) then
				local text = self.randomDisplayLines[math.random(1, #self.randomDisplayLines)];

				if (text && self.lastRandomDisplayLine != text) then
					self:addDisplay(text);

					self.lastRandomDisplayLine = text;
				end;

				self.nextRandomLine = curTime + Schema.NextRandomLineTime;
			end;
		end;
		
		if (IsValid(ix.gui.combine)) then
			ix.gui.combine:Remove();
		end;
	end;

	function Schema:addDisplay(text, color)
		local client = LocalPlayer();

		if (client:IsCombine()) then
			color = color or color_white;
			Schema.displays[#Schema.displays + 1] = {text = tostring(text), color = color, realText = ""};

			client:EmitSound("buttons/button16.wav", 30, 120);
		end;
	end;
end;
