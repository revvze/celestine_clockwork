-- Called when a player's footstep sound should be played.
function PLUGIN:PlayerFootstep(player, position, foot, sound, volume, recipientFilter)
	local running = nil;
	local clothes = player:GetCharacterData("clothes");
	local model = string.lower( player:GetModel() );
	local soundLevel = 100
	local attribute = Clockwork.attributes:Get(player, ATB_STEALTH)
	local quiet = math.random(1,attribute)

	if (player:Crouching() and quiet > math.random(1,8)) then
		return true
	end
	
	--[[if (clothes) then
		local itemTable = Clockwork.item:FindByID(clothes);
		
		if (itemTable) then
			if (player:IsRunning() or player:IsJogging()) then
				if (itemTable.runSound) then
					if (type(itemTable.runSound) == "table") then
						sound = itemTable.runSound[ math.random(1, #itemTable.runSound) ];
					else
						sound = itemTable.runSound;
					end;
				end;
			elseif (itemTable.walkSound) then
				if (type(itemTable.walkSound) == "table") then
					sound = itemTable.walkSound[ math.random(1, #itemTable.walkSound) ];
				else
					sound = itemTable.walkSound;
				end;
			end;
		end;
	end;
	
	if (player:IsRunning() or player:IsJogging()) then
		running = true;
	end;
	
	if (running) then
		if (string.find(model, "soldier") or string.find(model, "army")) then
			if (foot == 0) then
				local randomSounds = {1, 3, 5};
				local randomNumber = math.random(1, 3);
				
				sound = "npc/metropolice/gear"..randomSounds[randomNumber]..".wav";
			else
				local randomSounds = {2, 4, 6};
				local randomNumber = math.random(1, 3);
				
				sound = "npc/metropolice/gear"..randomSounds[randomNumber]..".wav";
			end;
		end;
	end;
	
	player:EmitSound(sound, soundLevel);
	
	return true;]]
end;