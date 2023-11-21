--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "Shovel";
ITEM.cost = 5;
ITEM.model = "models/props_junk/Shovel01a.mdl";
ITEM.weight = 1;
ITEM.uniqueID = "weapon_hl2shovel";
ITEM.business = false;
ITEM.description = "Rusty metal shovel.";
ITEM.isAttachment = false;

ITEM:Register();