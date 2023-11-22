
local FACTION = Clockwork.faction:New("Cremator");

FACTION.isCombineFaction = true;
FACTION.whitelist = true;
FACTION.models = {
	male = {"models/_monsters/combine/cremator.mdl"}
};

FACTION.weapons = {
	"weapon_immolator_beta_alt"
};

FACTION.listenChannels = {
	["cp_main"] = 1,
	["combine"] = 1
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
