--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	http://cloudsixteen.com/license/clockwork.html
--]]

-- Called when a player's character data should be saved.
function cwStamina:PlayerSaveCharacterData(player, data)
	local faction = string.lower(player:GetFaction()); -- We get the player's faction name (Ratatouille)
	
	if not (faction == "overwatch transhuman arm") then -- If the player is not an OTA then we set the stamina (Ratatouille)
		if (data["Stamina"]) then
			data["Stamina"] = math.Round(data["Stamina"]);
		end;
	end;
end;

-- Called when a player's character data should be restored.
function cwStamina:PlayerRestoreCharacterData(player, data)
	local faction = string.lower(player:GetFaction()); -- We get the player's faction name (Ratatouille)
	
	if not (faction == "overwatch transhuman arm") then -- If the player is not an OTA then we set the stamina (Ratatouille)
		if (!data["Stamina"]) then
			data["Stamina"] = 100;
		end;
	end;
end;

-- Called just after a player spawns.
function cwStamina:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	local faction = string.lower(player:GetFaction()); -- We get the player's faction name (Ratatouille)
	
	if not (faction == "overwatch transhuman arm") then -- If the player is not an OTA then we set the stamina (Ratatouille)
		if (!firstSpawn and !lightSpawn) then
			player:SetCharacterData("Stamina", 100);
		end;
	end;
end;

-- Called when a player attempts to throw a punch.
function cwStamina:PlayerCanThrowPunch(player)
	local faction = string.lower(player:GetFaction()); -- We get the player's faction name (Ratatouille)
	
	if (player:GetCharacterData("Stamina") <= 10 and faction != "ota") then -- If the player has stamina and is not an OTA (Ratatouille)
		return false;
	end;
end;

-- Called when a player throws a punch.
function cwStamina:PlayerPunchThrown(player)
	local faction = string.lower(player:GetFaction()); -- We get the player's faction name (Ratatouille)

	if not (faction == "overwatch transhuman arm") then -- If the player is not an OTA, he don't need to get stronger when punching stuffs (Ratatouille)
		local attribute = Clockwork.attributes:Fraction(player, ATB_STAMINA, 1.5, 0.25);
		local decrease = 5 / (1 + attribute);
		
		player:SetCharacterData("Stamina", math.Clamp(player:GetCharacterData("Stamina") - decrease, 0, 100));
	end;
end;

-- Called when a player's shared variables should be set.
function cwStamina:PlayerSetSharedVars(player, curTime)
	local faction = string.lower(player:GetFaction()); -- We get the player's faction name (Ratatouille)
	
	if not (faction == "overwatch transhuman arm") then -- If the player is not an OTA then we set the stamina (Ratatouille)
		player:SetSharedVar("Stamina", math.floor(player:GetCharacterData("Stamina")));
	end;		
end;

-- Called when a player's stamina should regenerate.
function cwStamina:PlayerShouldStaminaRegenerate(player)
	local faction = string.lower(player:GetFaction()); -- We get the player's faction name (Ratatouille)
	
	if not (faction == "overwatch transhuman arm") then -- If the player is not an OTA then he can regen stamina (Ratatouille)
		return true;
	end;
end;

-- Called when a player's stamina should drain.
function cwStamina:PlayerShouldStaminaDrain(player)
	local faction = string.lower(player:GetFaction()); -- We get the player's faction name (Ratatouille)
	
	if not (faction == "overwatch transhuman arm") then -- If the player is not an OTA then he can loose stamina (Ratatouille)
		return true;
	end;
end;

-- Called at an interval while a player is connected.
function cwStamina:PlayerThink(player, curTime, infoTable)
	local regenScale = Clockwork.config:Get("stam_regen_scale"):Get();
	local drainScale = Clockwork.config:Get("stam_drain_scale"):Get();
	local attribute = Clockwork.attributes:Fraction(player, ATB_STAMINA, 1, 0.25);
	local regeneration = 0;
	local maxHealth = player:GetMaxHealth();
	local healthScale = (drainScale * (math.Clamp(player:Health(), maxHealth * 0.1, maxHealth) / maxHealth));
	local decrease = (drainScale + (drainScale - healthScale)) - ((drainScale * 0.5) * attribute);
	local faction = string.lower(player:GetFaction()); -- We get the player's faction name (Ratatouille)
	
	if (!player:IsNoClipping() and player:IsOnGround() and faction != "overwatch transhuman arm") then -- If the player is not in NoClip, if he's on the ground and he's not an OTA (Ratatouille)
		local playerVelocityLength = player:GetVelocity():Length();
		if ((infoTable.isRunning or infoTable.isJogging) and playerVelocityLength != 0) then
			if (Clockwork.plugin:Call("PlayerShouldStaminaDrain", player)) then
				player:SetCharacterData("Stamina", math.Clamp(player:GetCharacterData("Stamina") - decrease, 0, 100));
				
				if (player:GetCharacterData("Stamina") > 1) then
					if (infoTable.isRunning) then
						player:ProgressAttribute(ATB_STAMINA, 0.025, true);
					elseif (infoTable.isJogging) then
						player:ProgressAttribute(ATB_STAMINA, 0.0125, true);
					end;
				end;
			end;
		elseif (playerVelocityLength == 0) then
			if (player:Crouching()) then
				regeneration = (regenScale + attribute) * 2;
			else
				regeneration = (regenScale + attribute);
			end;
		else
			regeneration = regenScale / 3;
		end;
	end;

	if (regeneration > 0 and Clockwork.plugin:Call("PlayerShouldStaminaRegenerate", player)) then
		player:SetCharacterData("Stamina", math.Clamp(player:GetCharacterData("Stamina") + regeneration, 0, 100));
	end;
	
	local newRunSpeed = infoTable.runSpeed * 2;
	local diffRunSpeed = newRunSpeed - infoTable.walkSpeed;
	local maxRunSpeed = Clockwork.config:Get("run_speed"):Get();
	
	if not (faction == "overwatch transhuman arm") then -- If the player is not an OTA then his runspeed is affected by stamina
		infoTable.runSpeed = math.Clamp(newRunSpeed - (diffRunSpeed - ((diffRunSpeed / 100) * player:GetCharacterData("Stamina"))), infoTable.walkSpeed, maxRunSpeed);
	end;
	
	if (infoTable.isJogging) then
		local walkSpeed = Clockwork.config:Get("walk_speed"):Get();
		local newWalkSpeed = walkSpeed * 1.75;
		local diffWalkSpeed = newWalkSpeed - walkSpeed;

		infoTable.walkSpeed = newWalkSpeed - (diffWalkSpeed - ((diffWalkSpeed / 100) * player:GetCharacterData("Stamina")));
		
		if (player:GetCharacterData("Stamina") < 1 or faction == "ota") then -- If player has stamina or is an OTA then he can jog (Ratatouille)
			player:SetSharedVar("IsJogMode", false);
		end;
	end;

	if not (faction == "overwatch transhuman arm") then -- If the player is not an OTA then he can play the exausted sound
		local stamina = player:GetCharacterData("Stamina");
		
		if (stamina < 30 and Clockwork.event:CanRun("sounds", "breathing")) then
			playBreathSound = true;
		end;
		
		if (!player.nextBreathingSound or curTime >= player.nextBreathingSound) then
			if (!Clockwork.player:IsNoClipping(player)) then
				player.nextBreathingSound = curTime + 1;
				
				if (playBreathSound) then
					local volume = Clockwork.config:Get("breathing_volume"):Get() - stamina;
	
					Clockwork.player:StartSound(player, "LowStamina", "player/breathe1.wav", volume / 100);
				else
					Clockwork.player:StopSound(player, "LowStamina", 4);
				end;
			end;
		end;
	end;
end;
