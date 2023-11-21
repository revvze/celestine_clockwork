--[[
	� CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local FACTION = Clockwork.faction:New("Vortigaunt");

FACTION.useFullName = true;
FACTION.whitelist = true;
FACTION.material = "hl2rp2/factions/vortigaunt";
FACTION.models = {
	male = {"models/vortigaunt_rp/vortigaunt.mdl"}
};

function FACTION:GetName(player, character)
	return "BIOTIC."..Clockwork.kernel:ZeroNumberToDigits(math.random(1, 999), 5);
end;

FACTION_VORTIGAUNT = FACTION:Register();
