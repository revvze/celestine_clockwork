
local FACTION = Clockwork.faction:New("Cremator");

FACTION.isCombineFaction = true;
FACTION.whitelist = true;
FACTION.models = {
	male = {"models/combine_cremator_oc.mdl"}
};

FACTION.weapons = {
	"weapon_immolator"
};

FACTION.listenChannels = {
	["cp_main"] = 1,
	["combine"] = 1
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

-- Called when a player's model should be assigned for the faction.
function FACTION:GetModel(player, character)
	return self.models.male[1];
end;

-- Called when a player's name should be assigned for the faction.
function FACTION:GetName(player, character)
	return "CREMATOR."..Clockwork.kernel:ZeroNumberToDigits(math.random(1, 999), 3);
end;

FACTION_CREMATOR = FACTION:Register();
