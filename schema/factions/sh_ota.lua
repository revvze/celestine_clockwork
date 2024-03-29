--[[
	� CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local FACTION = Clockwork.faction:New("Overwatch Transhuman Arm");

FACTION.isCombineFaction = true;
FACTION.whitelist = true;
FACTION.material = "celestine/factions/overwatch";
FACTION.maxHealth = 150;
FACTION.maxArmor = 150;
FACTION.startChatNoise = "npc/overwatch/radiovoice/on1.wav";
FACTION.endChatNoise = "npc/overwatch/radiovoice/off4.wav";
FACTION.models = {
	male = {"models/lantern/npc/rtb_combine_soldier_npc.mdl"}
};
FACTION.ranks = {
	["OWS"] = {
		position = 2,
		class = CLASS_OWS
	},
	["OWC"] = {
		position = 1,
		class = CLASS_OWC,
		model = "models/lantern/npc/rtb_combine_super_soldier_npc.mdl",
		canPromote = 2,
		canDemote = 2
	}
};
FACTION.startingInv = {
	["handheld_radio"] = 1,
	["tfa_rtbr_oicw"] = 1,
	["ammo_ar2"] = 2
};
FACTION.respawnInv = {
	["handheld_radio"] = 1,
	["tfa_rtbr_oicw"] = 1,
	["ammo_ar2"] = 2
};
FACTION.entRelationship = {
	["npc_combine_s"] = "Like",
	["npc_helicopter"] = "Like",
	["npc_metropolice"] = "Like",
	["npc_manhack"] = "Like",
	["npc_combinedropship"] = "Like",
	["npc_rollermine"] = "Like",
	["npc_stalker"] = "Like",
	["npc_turret_floor"] = "Like",
	["npc_combinegunship"] = "Like",
	["npc_cscanner"] = "Like",
	["npc_clawscanner"] = "Like",
	["npc_strider"] = "Like",
	["npc_turret_ceiling"] = "Like",
	["npc_turret_ground"] = "Like",
	["npc_combine_camera"] = "Like",
	["Beta_Stalker"] = "Like",
	["npc_hunter"] = "Like"
};

-- Called when a player's name should be assigned for the faction.
function FACTION:GetName(player, character)
	local unitID = math.random(1, 99999);
	
	return "OTA..TAGLINE-"..Clockwork.kernel:ZeroNumberToDigits(unitID, 5);
end;

-- Called when a player's model should be assigned for the faction.
function FACTION:GetModel(player, character)
	if (character.gender == GENDER_MALE) then
		return self.models.male[1];
	else
		return self.models.female[1];
	end;
end;

-- Called when a player is transferred to the faction.
function FACTION:OnTransferred(player, faction, name)
	if (faction.name == FACTION_MPF or faction.name == FACTION_SCANNER) then
		Clockwork.player:SetName(player, string.gsub(player:QueryCharacter("name"), ".+(%d%d%d%d%d)", "OTA-ECHO.OWS-%1"), true);
	else
		Clockwork.player:SetName(player, self:GetName(player, player:GetCharacter()), true);
	end;
	
	if (player:QueryCharacter("gender") == GENDER_MALE) then
		player:SetCharacterData("model", self.models.male[1], true);
	else
		player:SetCharacterData("model", self.models.female[1], true);
	end;
end;

FACTION_OTA = FACTION:Register();
