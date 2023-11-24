--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "H&K USP Match";
ITEM.cost = 100;
ITEM.model = "models/weapons/pistol/w_pistol.mdl";
ITEM.weight = 1;
ITEM.uniqueID = "tfa_rtbr_pistol";
ITEM.business = true;
ITEM.access = "v";
ITEM.description = "A grey, and dark grey 5.31 inc. semi automatic pistol using 9mm parabellum/.45 ACP rounds, SA trigger system with a 20 N trigger pool";
ITEM.isAttachment = true;
ITEM.loweredOrigin = Vector(3, 0, -4);
ITEM.loweredAngles = Angle(0, 45, 0);
ITEM.attachmentBone = "ValveBiped.Bip01_Pelvis";
ITEM.attachmentOffsetAngles = Angle(0, 0, 90);
ITEM.attachmentOffsetVector = Vector(0, 4, -8);

ITEM:Register();