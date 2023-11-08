--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("ammo_base");

ITEM.name = ".38 Special Ammunition";
ITEM.cost = 40;
ITEM.classes = {CLASS_EOW};
ITEM.model = "models/items/357ammo.mdl";
ITEM.weight = 1;
ITEM.access = "V";
ITEM.uniqueID = "ammo_38";
ITEM.business = false;
ITEM.ammoClass = "357";
ITEM.ammoAmount = 21;
ITEM.description = "A cartridge containing .38 special wadcutter rounds.";

ITEM:Register();