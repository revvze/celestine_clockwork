--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "Civic Enforcement Baton";
ITEM.cost = 30;
ITEM.model = "models/weapons/stunstick/w_stunbaton.mdl";
ITEM.weight = 1;
ITEM.uniqueID = "tfa_rtbr_stunstick";
ITEM.business = false;
ITEM.description = "Electric powered baton used to keep the peace by Metropolice.";
ITEM.isAttachment = false;

ITEM:Register();