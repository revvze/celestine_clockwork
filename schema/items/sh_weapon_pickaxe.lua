--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "Pickaxe";
ITEM.cost = 20;
ITEM.model = "models/weapons/hl2meleepack/w_pickaxe.mdl";
ITEM.weight = 2;
ITEM.access = "v";
ITEM.uniqueID = "weapon_hl2pickaxe";
ITEM.business = true;
ITEM.description = "Hefty pickaxe with a wooden handle.";
ITEM.isAttachment = false;

ITEM:Register();