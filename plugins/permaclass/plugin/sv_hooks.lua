local PLUGIN = PLUGIN;

function PLUGIN:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	if !lightSpawn then 
		if (player:GetCharacterData("class")) then
			local class = Clockwork.class:FindByID(player:GetCharacterData("class"));
			if (class) then
				Clockwork.class:Set(player, class.index, nil, true);
			end;
		end;
	end;
end;