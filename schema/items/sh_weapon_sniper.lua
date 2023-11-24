--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "LAR Grizzly Big Bore";
ITEM.cost = 500;
ITEM.model = "models/weapons/sniper/w_sniper.mdl";
ITEM.weight = 5;
ITEM.uniqueID = "tfa_rtbr_sniperrifle";
ITEM.business = true;
ITEM.access = "v";
ITEM.description = "A black, red scope. breech loading, single shot sniper rifle chambered for . 50 BMG rounds.";
ITEM.isAttachment = true;
ITEM.attachmentBone = "ValveBiped.Bip01_Spine";
ITEM.loweredOrigin = Vector(3, 0, -4);
ITEM.loweredAngles = Angle(0, 45, 0);
ITEM.attachmentOffsetAngles = Angle(270, 0, 0);
ITEM.attachmentOffsetVector = Vector(3, 7, -3);

ITEM:Register();