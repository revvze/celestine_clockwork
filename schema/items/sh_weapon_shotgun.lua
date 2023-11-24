--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "SPAS-12";
ITEM.cost = 300;
ITEM.model = "models/weapons/w_shotgun.mdl";
ITEM.weight = 4;
ITEM.uniqueID = "tfa_rtbr_shotgun";
ITEM.business = true;
ITEM.access = "v";
ITEM.description = "A black dual mode (dominantly pump action) gas chambered shotgun";
ITEM.isAttachment = true;
ITEM.loweredOrigin = Vector(3, 0, -4);
ITEM.loweredAngles = Angle(0, 45, 0);
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);
ITEM.attachmentOffsetVector = Vector(-4, 4, 4);

ITEM:Register();