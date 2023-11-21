--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "Pot";
ITEM.model = "models/props_interiors/pot02a.mdl";
ITEM.weight = 1;
ITEM.uniqueID = "weapon_hl2pot";
ITEM.business = false;
ITEM.description = "Rusty metal cooking pot.";
ITEM.isAttachment = false;

ITEM:Register();