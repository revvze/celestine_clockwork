local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PtCreate");
COMMAND.tip = "Creates a protection team.";
COMMAND.flags = CMD_DEFAULT;

function COMMAND:OnRun(player, arguments)
	if (Schema:PlayerIsCombine(player) and player:GetFaction() == FACTION_MPF and player:GetSharedVar("PTeam") == 0) then
		PLUGIN:CreateProtectionTeam(player);
	else
		Clockwork.player:Notify(player, "You are not on a Combine faction!");
	end;
end;

COMMAND:Register();