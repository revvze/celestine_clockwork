--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "AK-47";
ITEM.cost = 100;
ITEM.model = "models/weapons/akm/w_akm.mdl";
ITEM.weight = 4;
ITEM.access = "v";
ITEM.uniqueID = "tfa_rtbr_akm";
ITEM.business = true;
ITEM.description = "An green and black 4.3 7.62 mm round automatic rifle.";
ITEM.isAttachment = true;
ITEM.loweredOrigin = Vector(3, 0, -4);
ITEM.loweredAngles = Angle(0, 45, 0);
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);
ITEM.attachmentOffsetVector = Vector(-3.96, 4.95, -2.97);

ITEM:Register();