local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PtLeave");
COMMAND.tip = "Leave your current protection team.";
COMMAND.flags = CMD_DEFAULT;

function COMMAND:OnRun(player, arguments)
	if (Schema:PlayerIsCombine(player)) then
		PLUGIN:KickFromProtectionTeam(player);
	else
		Clockwork.player:Notify(player, "You are not on a Combine faction!")
	end;
end;

COMMAND:Register();