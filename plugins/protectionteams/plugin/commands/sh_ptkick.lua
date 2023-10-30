local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PtKick");
COMMAND.tip = "Kick a player from your protection team.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 1;
COMMAND.text = "<string Player>";

function COMMAND:OnRun(player, arguments)
	local client = Clockwork.player:FindByID(arguments[1] or "") or false;

	if !(client) then
		Clockwork.player:Notify(player, "Unable to find the specified player!");
		return;
	end;

	local CanKick = ((player:GetSharedVar("PTLead") and player:GetSharedVar("PTeam") == client:GetSharedVar("PTeam")) or (PLUGIN:IsDispatch(player)));

	if ((player:GetFaction() == FACTION_MPF and CanKick) or (player:GetFaction() == FACTION_OVERWATCH)) then
		PLUGIN:KickFromProtectionTeam(client, "You were kicked from your protection team by " .. player:Name() .. "!");
		Clockwork.player:Notify(player, "You have kicked " .. client:Name() .. " from your protection team.");
	else
		Clockwork.player:Notify(player, "You are not allowed to use this function.");
	end;
end;

COMMAND:Register();