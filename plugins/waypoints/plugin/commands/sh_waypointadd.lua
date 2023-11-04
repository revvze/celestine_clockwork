
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local CurTime = CurTime;
local string = string;
local table = table;
local tonumber = tonumber;

local COMMAND = Clockwork.command:New("WaypointAdd");
COMMAND.tip = "Add a waypoint where you are looking.";
COMMAND.text = "<string Text> <int Time> [string Color]";
COMMAND.arguments = 2;
COMMAND.optionalArguments = 1;

function COMMAND:OnRun(player, arguments)
	local factionTable = Clockwork.player:GetFactionTable(player);
	if (!(factionTable and factionTable.canAddWaypoints)) then
		Clockwork.player:Notify(player, "You cannot add waypoints.");
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
	waypoint.pos = player:GetEyeTraceNoCursor().HitPos + Vector(0, 0, 30);
	waypoint.text = text;
	waypoint.color = color;
	waypoint.addedBy = player;
	waypoint.time = CurTime() + time;

	PLUGIN:AddWaypoint(waypoint);
	Clockwork.player:Notify(player, "You have added a waypoint.");
end;

COMMAND:Register();