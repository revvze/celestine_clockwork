--[[
	© 2012 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("Nick");
COMMAND.tip = "Set your nickname.";
COMMAND.text = "<string Name>";
COMMAND.flags = CMD_DEFAULT
COMMAND.arguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	if(string.len(arguments[1]) > 24) then 
		Clockwork.player:Notify(player, "The name you chose is too long!")
		return;
	end;
	
	if(!string.find(player:Name(), "'")) then
		local name = string.gsub(player:Name(), " ", " '"..arguments[1].."' ")
		Clockwork.player:SetName(player, name)
		Clockwork.player:Notify(player, "You are now known as "..name..".")
	else
		local name = string.gsub(player:Name(), "'.*'", "'"..arguments[1].."'")
		Clockwork.player:SetName(player, name)
		Clockwork.player:Notify(player, "You are now known as "..name..".")
	end;
end;

COMMAND:Register();