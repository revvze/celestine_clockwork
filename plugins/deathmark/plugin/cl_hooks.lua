
local PLUGIN = PLUGIN

function PLUGIN:Tick()
	if (#self.storedDeathmarks == 0) then return; end;

	local curTime = CurTime();

	for k, v in pairs(self.storedDeathmarks) do
		local position = v.position;
		
		self.DeathMarkbuffer[k] = self.DeathMarkbuffer[k] or {};

		if (v.endTime > curTime) then
			self.DeathMarkbuffer[k].screenPosition = position:ToScreen();
			self.DeathMarkbuffer[k].name = v.name;
			self.DeathMarkbuffer[k].distance = position:Distance(Clockwork.Client:GetPos());

		else
			table.remove(self.storedDeathmarks, k);
			table.remove(self.DeathMarkbuffer, k);
		end;
	end;
end;

function PLUGIN:HUDPaintTopScreen(info)
	if (#self.DeathMarkbuffer == 0) then return; end;

	for k, v in pairs(self.DeathMarkbuffer) do
		surface.SetMaterial(PLUGIN.deathMarkIcon);
		surface.SetDrawColor( Color( 255, 255, 255, 128 ) )
		surface.DrawTexturedRect(v.screenPosition.x - 16, v.screenPosition.y, 32, 32 )

		draw.SimpleText("<:: "..v.name.." DESERVICED ::>", "BudgetLabel", v.screenPosition.x + 1, v.screenPosition.y + 31, Color(0, 0, 0, 196), TEXT_ALIGN_CENTER);
		draw.SimpleText("<:: "..v.name.." DESERVICED ::>", "BudgetLabel", v.screenPosition.x, v.screenPosition.y + 30, Color(255, 255, 255, 196), TEXT_ALIGN_CENTER);

		draw.SimpleText("<:: DISTANCE: "..tostring(math.Round(v.distance * 0.01905, 1)).." M ::>", "BudgetLabel", v.screenPosition.x + 1, v.screenPosition.y + 43, Color(0, 0, 0, 196), TEXT_ALIGN_CENTER);
		draw.SimpleText("<:: DISTANCE: "..tostring(math.Round(v.distance * 0.01905, 1)).." M ::>", "BudgetLabel", v.screenPosition.x, v.screenPosition.y + 42, Color(255, 255, 255, 196), TEXT_ALIGN_CENTER);
		
		
	end;
end;