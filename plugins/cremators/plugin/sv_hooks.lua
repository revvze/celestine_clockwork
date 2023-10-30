
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;
local Schema = Schema;

local crematorSoundDuration = SoundDuration("npc/cremator/amb_loop.wav");

-- Called at an interval while a player is connected.
function PLUGIN:PlayerThink(player, curTime, infoTable)
	local faction = player:GetFaction();

	if (player:Alive() and !player:IsRagdolled()) then
		if (faction == FACTION_CREMATOR) then
			infoTable.walkSpeed = Clockwork.config:Get("walk_speed"):Get() * 0.75;
			
			if (!player.cwCrematorSound) then
				player.cwCrematorSound = CreateSound(player, "npc/cremator/amb_loop.wav");
			end;

			if (!player.cwNextPlayCrematorSound or curTime > player.cwNextPlayCrematorSound) then
				player.cwNextPlayCrematorSound = curTime + crematorSoundDuration;
				player.cwCrematorSound:PlayEx(50, 100);
			end;
		else
			if (player.cwCrematorSound) then
				player.cwCrematorSound:Stop();
				player.cwCrematorSound = nil;
				player.cwNextPlayCrematorSound = nil;
			end;
		end;
	end;
end;

-- Called when a player's typing display has started.
function PLUGIN:PlayerStartTypingDisplay(player, code)
	local faction = player:GetFaction();

	if (faction == FACTION_CREMATOR) then
		if (code == "n" or code == "y" or code == "w" or code == "r") then
			if (!player.typingBeep) then
				player.typingBeep = true;
				
				player:EmitSound("npc/overwatch/radiovoice/on3.wav");
				return true;
			end;
		end;
	end;
end;

-- Called when a player's typing display has finished.
function PLUGIN:PlayerFinishTypingDisplay(player, textTyped)
	local faction = player:GetFaction();

	if (faction == FACTION_CREMATOR and textTyped) then
		if (player.typingBeep) then
			player:EmitSound("npc/overwatch/radiovoice/off4.wav");
			return true;
		end;
	end;
end;

-- Called when a player's character has initialized.
function PLUGIN:PlayerCharacterInitialized(player)
	local faction = player:GetFaction();
	
	if (faction == FACTION_CREMATOR) then
		Schema:AddCombineDisplayLine("Rebuilding active Cremator Unit Manifest..", Color(255, 165, 0, 255));
	end;
end;

-- Called when a player's death sound should be played.
function PLUGIN:PlayerPlayDeathSound(player, gender)
	local faction = player:GetFaction();
		
	if (faction == FACTION_CREMATOR) then		
		return  "npc/cremator/crem_die.wav";
	end;
end;

-- Called when a player's footstep sound should be played.
function PLUGIN:PlayerFootstep(player, position, foot, sound, volume, recipientFilter)
	local model = string.lower(player:GetModel());
	
	if (string.find(model, "cremator") or string.find(model, "cremato2")) then			
		sound = "npc/cremator/foot"..math.random(1, 3)..".wav";
		player:EmitSound(sound);
		return true;
	end;
end;

function PLUGIN:PlayerStepSoundTime(player, iType, bWalking)
	local model = string.lower(player:GetModel());
	if(string.find(model, "cremator") or string.find(model, "cremato2")) then
		return 800;
	end;
end;
-- Called just after a player spawns.
function PLUGIN:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	local faction = player:GetFaction();

	if (!lightSpawn) then
		if (faction == FACTION_CREMATOR) then
			player:SetMaxHealth(150);
			player:SetMaxArmor(100);
			player:SetHealth(150);
			player:SetArmor(100);
		end;
	end;
end;

-- Called when a player's pain sound should be played.
function PLUGIN:PlayerPlayPainSound(player, gender, damageInfo, hitGroup)
	local faction = player:GetFaction();

	if (faction == FACTION_CREMATOR) then
		return "npc/combine_soldier/pain"..math.random(1, 3)..".wav";
	end;
end;

-- Called to check if a player does recognise another player.
function PLUGIN:PlayerDoesRecognisePlayer(player, status, isAccurate, realValue)
	local faction = player:GetFaction();

	if (faction == FACTION_CREMATOR) then
		return true;
	end;
end;
