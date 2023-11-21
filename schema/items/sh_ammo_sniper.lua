--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("ammo_base");

ITEM.name = "50 BMG Ammunition";
ITEM.cost = 60;
ITEM.model = "models/Items/BoxMRounds.mdl";
ITEM.weight = 2;
ITEM.uniqueID = "ammo_sniper";
ITEM.business = false;
ITEM.ammoClass = "sniperpenetratedround";
ITEM.ammoAmount = 12;
ITEM.description = "A cartridge containing 50 BMG rounds.";

ITEM:Register();