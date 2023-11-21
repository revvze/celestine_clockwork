--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "M1886 Rifle";
ITEM.cost = 300;
ITEM.model = "models/weapons/annabelle/w_annabelle.mdl";
ITEM.weight = 4;
ITEM.uniqueID = "tfa_rtbr_annabelle";
ITEM.business = false;
ITEM.description = "";
ITEM.isAttachment = true;
ITEM.loweredOrigin = Vector(3, 0, -4);
ITEM.loweredAngles = Angle(0, 45, 0);
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);
ITEM.attachmentOffsetVector = Vector(-4, 4, 4);

ITEM:Register();