
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

PLUGIN.waypoints = {};

local ipairs = ipairs;
local pairs = pairs;
local table = table;

function PLUGIN:GetPlayers()
	local players = {};
	for k, ply in ipairs(player.GetAll()) do
		local factionTable = Clockwork.player:GetFactionTable(ply);
		if (factionTable and factionTable.canSeeWaypoints) then
			players[#players + 1] = ply;
		end;
	end;

	return players;
end;

function PLUGIN:RemoveWaypoints()
	self.waypoints = {};
	Clockwork.datastream:Start(self:GetPlayers(), "SetupWaypoints", false);
end;

function PLUGIN:UpdateWaypoint(index, newValue)
	if (newValue == nil) then
		table.remove(self.waypoints, index);
		Clockwork.datastream:Start(self:GetPlayers(), "SetupWaypoints", self.waypoints);
	else
		self.waypoints[index] = newValue;
		Clockwork.datastream:Start(self:GetPlayers(), "UpdateWaypoint", {index, newValue});
	end;
end;

function PLUGIN:AddWaypoint(waypoint)
	local index = table.insert(self.waypoints, waypoint);

	Clockwork.datastream:Start(self:GetPlayers(), "UpdateWaypoint", {index, waypoint});
end;

PLUGIN.colors = {
	["white"] = Color(255, 255, 255),
	["blue"] = Color(0, 114, 188),
	["purple"] = Color(102, 51, 153),
	["red"] = Color(255, 0, 0),
	["maroon"] = Color(103, 0, 42),
	["orange"] = Color(255, 122, 0),
	["yellow"] = Color(255, 222, 0),
	["green"] = Color(38, 106, 46),
	["black"] = Color(0, 0, 0),
	["grey"] = Color(81, 81, 81),
	["gray"] = Color(81, 81, 81),
};

function PLUGIN:GetWaypointColor(colorName)
	return self.colors[colorName];
end;

function PLUGIN:ListColors()
	local colors = {};
	for k, v in pairs(self.colors) do
		colors[#colors + 1] = k;
	end;

	return table.concat(colors, ", ");
end;