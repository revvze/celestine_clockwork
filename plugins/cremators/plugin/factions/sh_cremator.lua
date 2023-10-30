
local FACTION = Clockwork.faction:New("Cremator");

FACTION.isCombineFaction = true;
FACTION.useFullName = true;
FACTION.whitelist = true;
FACTION.models = {
	male = {"models/cremato2.mdl"}
};

FACTION.noNeeds = true;

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
	return "C17:UCU.CREMATOR-"..Clockwork.kernel:ZeroNumberToDigits(math.random(1, 999), 3);
end;

FACTION_CREMATOR = FACTION:Register();
