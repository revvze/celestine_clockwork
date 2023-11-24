--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New("weapon_base");

ITEM.name = "Colt Python";
ITEM.cost = 300;
ITEM.model = "models/weapons/357/w_357.mdl";
ITEM.weight = 2;
ITEM.access = "v";
ITEM.uniqueID = "tfa_rtbr_357";
ITEM.business = true;
ITEM.description = "A silver and black double 4.25 inch action revolver chambered for the . 357 Magnum cartridge.";
ITEM.isAttachment = true;
ITEM.loweredOrigin = Vector(3, 0, -4);
ITEM.loweredAngles = Angle(0, 45, 0);
ITEM.attachmentBone = "ValveBiped.Bip01_Pelvis";
ITEM.attachmentOffsetAngles = Angle(-180, 180, 90);
ITEM.attachmentOffsetVector = Vector(-4.19, 0, -8.54);

ITEM:Register();