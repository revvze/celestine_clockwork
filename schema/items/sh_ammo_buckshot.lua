--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("ammo_base");

ITEM.name = "12 Gauge Ammunition";
ITEM.cost = 30;
ITEM.model = "models/items/boxbuckshot.mdl";
ITEM.weight = 1;
ITEM.uniqueID = "ammo_buckshot";
ITEM.business = true;
ITEM.ammoClass = "buckshot";
ITEM.ammoAmount = 16;
ITEM.description = "ItemShotgunShellsDesc";

ITEM:Register();