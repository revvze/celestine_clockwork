
local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("WaypointRemoveAll");
COMMAND.tip = "Remove all current waypoints.";

function COMMAND:OnRun(player, arguments)
	local factionTable = Clockwork.player:GetFactionTable(player);
	if (!(factionTable and factionTable.canRemoveWaypoints)) then
		Clockwork.player:Notify(player, "You cannot remove waypoints.");
		return;
	end;

	if (table.Count(PLUGIN.waypoints) > 0) then
		PLUGIN:RemoveWaypoints();
		Clockwork.player:Notify(player, "You have removed all waypoints.");
	else
		Clockwork.player:Notify(player, "There are no waypoints set.");
	end;
end;

COMMAND:Register();