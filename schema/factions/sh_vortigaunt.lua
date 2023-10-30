--[[
	� CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local FACTION = Clockwork.faction:New("Vortigaunt");

FACTION.useFullName = true;
FACTION.whitelist = true;
FACTION.material = "hl2rp2/factions/vortigaunt";
FACTION.models = {
	male = {"models/vortigaunt_slave.mdl"}
};

FACTION_VORTIGAUNT = FACTION:Register();
