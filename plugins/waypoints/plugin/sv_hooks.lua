
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local CurTime = CurTime;

PLUGIN.waypointThink = 0;

function PLUGIN:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	if (firstSpawn) then
		local factionTable = Clockwork.player:GetFactionTable(player);
		if (factionTable.canSeeWaypoints) then
			Clockwork.datastream:Start(player, "SetupWaypoints", self.waypoints);
		else
			Clockwork.datastream:Start(player, "SetupWaypoints", false);
		end;
	end;
end;

function PLUGIN:Think()
	local curTime = CurTime();
	if (self.waypointThink < curTime) then
		self.waypointThink = curTime + 60;
		local toRemove = {};
		for k, waypoint in pairs(self.waypoints) do
			if (waypoint.time < curTime) then
				toRemove[#toRemove + 1] = k;
			end;
		end;

		if (#toRemove > 0) then
			table.sort(toRemove);
			for i = #toRemove, 1, -1 do
				table.remove(self.waypoints, toRemove[i]);
			end;

			Clockwork.datastream:Start(self:GetPlayers(), "SetupWaypoints", self.waypoints);
		end;
	end;
end;
