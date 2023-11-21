--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("ammo_base");

ITEM.name = "4.6x30mm Ammunition";
ITEM.cost = 30;
ITEM.model = "models/items/boxmrounds.mdl";
ITEM.weight = 2;
ITEM.uniqueID = "ammo_mp7";
ITEM.business = false;
ITEM.ammoClass = "smg1";
ITEM.ammoAmount = 30;
ITEM.description = "A cartridge containing 4.6x30mm rounds.";

ITEM:Register();