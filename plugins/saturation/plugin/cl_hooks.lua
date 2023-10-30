local PLUGIN = PLUGIN;

function PLUGIN:PlayerAdjustColorModify(colorMod)
	if (Clockwork.Client and Clockwork.Client:HasInitialized()) then
		if (Clockwork.Client:Health() < (Clockwork.Client:GetMaxHealth() * 0.75)) then
			local maxHealth = Clockwork.Client:GetMaxHealth();
			local curHealth = Clockwork.Client:Health();
			local brightness = math.Remap(curHealth, maxHealth, 0, 0, -0.1);
			local contrast = math.Remap(curHealth, maxHealth, 0, 1, 1.5);
			local color = math.Remap(curHealth, maxHealth, 0, 0.5, 0);

			colorMod["$pp_colour_brightness"] = brightness;
			colorMod["$pp_colour_contrast"] = contrast;
			colorMod["$pp_colour_colour"] = color;
		end;
	end;
end;

function PLUGIN:DrawPlayerScreenDamage()
	return false;
end;