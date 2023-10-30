local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("RadioPT");
COMMAND.tip = "Send a radio message out to other members of your protection team.";
COMMAND.text = "<string Text>";
COMMAND.flags = bit.bor(CMD_DEFAULT, CMD_DEATHCODE, CMD_FALLENOVER);
COMMAND.arguments = 1;

function COMMAND:OnRun(player, arguments)
	if (Schema:PlayerIsCombine(player)) then
		if (player:GetSharedVar("PTeam") > 0) then
			PLUGIN:SayPTRadio(player, table.concat(arguments, " "), false);
		else
			Clockwork.player:Notify(player, "You are not currently in a protection team!");
		end;
	else
		Clockwork.player:Notify(player, "You are not on a Combine faction!")
	end
end;

COMMAND:Register();