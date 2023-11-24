--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("ammo_base");

ITEM.name = "357 Magnum Ammunition";
ITEM.cost = 40;
ITEM.model = "models/items/357ammo.mdl";
ITEM.weight = 1;
ITEM.access = "v";
ITEM.uniqueID = "ammo_357";
ITEM.business = true;
ITEM.ammoClass = "357";
ITEM.ammoAmount = 21;
ITEM.description = "A cartridge containing 357 Magnum rounds.";

ITEM:Register();