--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("NickRemove");
COMMAND.tip = "Remove your nickname.";
COMMAND.flags = CMD_DEFAULT

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local name = string.gsub(player:Name(), "'.*' ", "")
	Clockwork.player:SetName(player, name)
	Clockwork.player:Notify(player, "You are now known as "..name..".")
end;

COMMAND:Register();