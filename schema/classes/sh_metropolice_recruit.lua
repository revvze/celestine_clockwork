--[[
	� CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local CLASS = Clockwork.class:New("Metropolice Recruit");
	CLASS.color = Color(50, 100, 150, 255);
	CLASS.factions = {FACTION_MPF};
	CLASS.description = "A metropolice recruit working as Civil Protection.";
	CLASS.defaultPhysDesc = "Wearing a metrocop jacket with a radio";
CLASS_MPR = CLASS:Register();