--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("ammo_base");

ITEM.name = "7.62 x 39mm Ammunition";
ITEM.cost = 30;
ITEM.classes = {CLASS_EOW};
ITEM.model = "models/Items/BoxMRounds.mdl";
ITEM.plural = "Rifle Ammunition";
ITEM.weight = 1;
ITEM.uniqueID = "ammo_rifle";
ITEM.business = false;
ITEM.ammoClass = "ar2";
ITEM.ammoAmount = 30;
ITEM.description = "A cartridge containing 7.62 x 39mm rounds.";

ITEM:Register();