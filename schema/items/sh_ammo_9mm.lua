--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("ammo_base");

ITEM.name = "9mm Ammunition";
ITEM.cost = 20;
ITEM.classes = {CLASS_EMP, CLASS_EOW};
ITEM.model = "models/items/boxsrounds.mdl";
ITEM.weight = 1;
ITEM.access = "V";
ITEM.uniqueID = "ammo_9mm";
ITEM.business = false;
ITEM.ammoClass = "pistol";
ITEM.ammoAmount = 20;
ITEM.description = "A cartridge containing 9mm rounds.";

ITEM:Register();