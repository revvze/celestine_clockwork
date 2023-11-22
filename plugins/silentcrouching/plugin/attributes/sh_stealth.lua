--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ATTRIBUTE = Clockwork.attribute:New();
	ATTRIBUTE.name = "Stealth";
	ATTRIBUTE.maximum = 75;
	ATTRIBUTE.uniqueID = "ste";
	ATTRIBUTE.description = "Affects how discreet your character is. (i.e: when crouching)";
	ATTRIBUTE.isOnCharScreen = true;
ATB_STEALTH = Clockwork.attribute:Register(ATTRIBUTE);