--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).

	Clockwork was created by Conna Wiles (also known as kurozael.)
	https://creativecommons.org/licenses/by-nc-nd/3.0/legalcode
--]]

local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("CharSetClass");
COMMAND.tip = "Set the class of a character.";
COMMAND.text = "<string Name> <string Class>";
COMMAND.flags = "a";
COMMAND.arguments = 2;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);
	local class = Clockwork.class:FindByID(arguments[2]);

	if (target) then
		if (target:InVehicle()) then
			Clockwork.player:Notify(player, "You cannot do this action at the moment!");
			return;
		end;
		
		if (class) then
			Clockwork.class:Set(target, class.index, nil, true);
			target:SetCharacterData("class", class.name)
		else
			Clockwork.player:Notify(player, "This is not a valid class!");
		end;
	else
		Clockwork.player:Notify(player, "That is not a valid player!");
	end;
end;

COMMAND:Register();