--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "XM29 OICW";
ITEM.cost = 400;
ITEM.model = "models/weapons/oicw/w_oicw.mdl";
ITEM.weight = 4;
ITEM.uniqueID = "tfa_rtbr_oicw";
ITEM.business = false;
ITEM.description = "A grey modified magazine fed 20mm out of service rifle with a green cope before the top-handguard.";
ITEM.isAttachment = true;
ITEM.loweredOrigin = Vector(3, 0, -4);
ITEM.loweredAngles = Angle(0, 45, 0);
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);
ITEM.attachmentOffsetVector = Vector(-3.96, 4.95, -2.97);

ITEM:Register();