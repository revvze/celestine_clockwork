--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "Axe";
ITEM.cost = 10;
ITEM.model = "models/weapons/hl2meleepack/w_axe.mdl";
ITEM.weight = 1;
ITEM.uniqueID = "weapon_hl2axe";
ITEM.business = false;
ITEM.description = "Old woodcutter's axe.";
ITEM.isAttachment = false;

ITEM:Register();