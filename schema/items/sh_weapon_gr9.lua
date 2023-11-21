--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "H&K GR9";
ITEM.cost = 600;
ITEM.model = "models/weapons/hmg/w_gr9.mdl";
ITEM.weight = 6;
ITEM.uniqueID = "tfa_rtbr_hmg";
ITEM.business = false;
ITEM.description = "A modified belt fed black machine gun capable of both semi and automatic firing types, 5.56x45mm cartridge.";
ITEM.isAttachment = true;
ITEM.loweredOrigin = Vector(3, 0, -4);
ITEM.loweredAngles = Angle(0, 45, 0);
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);
ITEM.attachmentOffsetVector = Vector(-3.96, 4.95, -2.97);

ITEM:Register();