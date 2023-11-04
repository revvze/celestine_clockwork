
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local CurTime = CurTime;
local pairs = pairs;
local string = string;
local table = table;
local tonumber = tonumber;

local COMMAND = Clockwork.command:New("WaypointUpdate");
COMMAND.tip = "Update an existing waypoint closest to where you are looking.";
COMMAND.text = "<string Text> <int Time> [string Color]";
COMMAND.arguments = 2;
COMMAND.optionalArguments = 1;

function COMMAND:OnRun(player, arguments)
	local pos = player:GetEyeTraceNoCursor().HitPos + Vector(0, 0, 30);
	local index = nil;
	local minDistanceSqr = nil;
	local factionTable = Clockwork.player:GetFactionTable(player);
	local onlyOwnWaypoints = !(factionTable and factionTable.canUpdateWaypoints);

	for k, point in pairs(PLUGIN.waypoints) do
		if (onlyOwnWaypoints and point.addedBy != player) then
			continue;
		end;

		if (!index) then
			index = k;
			minDistanceSqr = point.pos:DistToSqr(pos);
		else
			local dist = point.pos:DistToSqr(pos);
			if (dist < minDistanceSqr) then
				index = k;
				minDistanceSqr = dist;
			end;
		end;
	end;

	if (!index) then
		Clockwork.player:Notify(player, "There are no waypoints you can update.");
		return;
	elseif (index and minDistanceSqr > 40000) then
		Clockwork.player:Notify(player, "There are no waypoints you can update near where you are looking.");
		return;
	end;

	local text, time, color;
	if (tonumber(arguments[#arguments])) then
		text = table.concat(arguments, " ", 1, #arguments - 1);
		time = tonumber(arguments[#arguments]);
		color = Clockwork.class:FindByID(player:Team()).color or Color(255, 255, 255, 255);
	elseif (#arguments > 2 and tonumber(arguments[#arguments - 1])) then
		text = table.concat(arguments, " ", 1, #arguments - 2);
		time = tonumber(arguments[#arguments - 1]);

		local colorName = string.lower(arguments[#arguments]);
		color = PLUGIN:GetWaypointColor(colorName);
		if (!color) then
			Clockwork.player:Notify(player, "'"..colorName.."' is not a valid color! Use one of these instead:");
			Clockwork.player:Notify(player, PLUGIN:ListColors());
			return;
		end;
	else
		Clockwork.player:Notify(player, "You did not enter a valid amount of time!");
		return;
	end;

	local waypoint = {};
	waypoint.pos = PLUGIN.waypoints[index].pos;
	waypoint.noDistance = PLUGIN.waypoints[index].noDistance;
	waypoint.text = text;
	waypoint.color = color;
	waypoint.time = CurTime();

	PLUGIN:UpdateWaypoint(index, waypoint);
	Clockwork.player:Notify(player, "You have updated a waypoint.");
end;

COMMAND:Register();