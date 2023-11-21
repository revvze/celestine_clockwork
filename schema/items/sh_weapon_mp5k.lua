--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "H&K MP5K";
ITEM.cost = 200;
ITEM.model = "models/weapons/mp5k/w_mp5k.mdl";
ITEM.weight = 2.5;
ITEM.uniqueID = "tfa_rtbr_smg2";
ITEM.business = false;
ITEM.description = "A completely black, 4.4 compact 4.52/5.5 barrel sub machine gun";
ITEM.isAttachment = true;
ITEM.loweredOrigin = Vector(3, 0, -4);
ITEM.loweredAngles = Angle(0, 45, 0);
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.attachmentOffsetAngles = Angle(0, 0, 0);
ITEM.attachmentOffsetVector = Vector(-2, 5, 4);

ITEM:Register();