--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "Pan";
ITEM.model = "models/props_c17/metalPot002a.mdl";
ITEM.weight = 1;
ITEM.uniqueID = "weapon_hl2pan";
ITEM.business = false;
ITEM.description = "Rusty metal cooking pan.";
ITEM.isAttachment = false;

ITEM:Register();