local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PtJoin");
COMMAND.tip = "Join the specified protection team.";
COMMAND.text = "<number Team>";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 1;

function COMMAND:OnRun(player, arguments)
	local num = tonumber(arguments[1]);

	if (!arguments[1] or arguments[1] == "") then
		Clockwork.player:Notify(player, "You did not specify a valid PT number!");
		return;
	end;

	if (Schema:PlayerIsCombine(player)) then
		PLUGIN:JoinProtectionTeam(player, num);
	else
		Clockwork.player:Notify(player, "You are not on a Combine faction!");
	end;
end;

COMMAND:Register();