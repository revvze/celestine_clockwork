--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "Crowbar";
ITEM.cost = 10;
ITEM.model = "models/weapons/w_crowbar.mdl";
ITEM.weight = 1;
ITEM.access = "v";
ITEM.uniqueID = "weapon_crowbar";
ITEM.business = true;
ITEM.description = "Sturdy metal crowbar.";
ITEM.isAttachment = false;

ITEM:Register();