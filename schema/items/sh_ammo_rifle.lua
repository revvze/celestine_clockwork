--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("ammo_base");

ITEM.name = "7.62 x 39mm Ammunition";
ITEM.cost = 50;
ITEM.model = "models/Items/BoxMRounds.mdl";
ITEM.weight = 1;
ITEM.access = "v";
ITEM.uniqueID = "ammo_ar2";
ITEM.business = true;
ITEM.ammoClass = "ar2";
ITEM.ammoAmount = 30;
ITEM.description = "A cartridge containing 7.62 x 39mm rounds.";

ITEM:Register();