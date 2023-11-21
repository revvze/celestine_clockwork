--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "Pipe";
ITEM.model = "models/props_canal/mattpipe.mdl";
ITEM.weight = 1;
ITEM.uniqueID = "weapon_hl2pipe";
ITEM.business = false;
ITEM.description = "Blunt metal pipe.";
ITEM.isAttachment = false;

ITEM:Register();