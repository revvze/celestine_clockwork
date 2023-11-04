
local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local CurTime = CurTime;
local draw = draw;
local pairs = pairs;
local surface = surface;
local tostring = tostring;

PLUGIN.waypoints = {};
PLUGIN.displayWaypoints = {};

Clockwork.datastream:Hook("SetupWaypoints", function(data)
	PLUGIN.waypoints = data or {};
end);

Clockwork.datastream:Hook("UpdateWaypoint", function(data)
	PLUGIN.waypoints[data[1]] = data[2];
end);

function PLUGIN:HUDPaint()
	local height = draw.GetFontHeight("BudgetLabel");
	local clientPos = Clockwork.Client:EyePos();

	for k, waypoint in pairs(self.waypoints) do
		if (waypoint.time < CurTime()) then
			continue;
		end;

		local screenPos = waypoint.pos:ToScreen();
		local color = waypoint.color;
		local text = "<:: "..waypoint.text.." ::>";
		local x, y = screenPos.x, screenPos.y;

		surface.SetDrawColor(color);
		surface.DrawLine(x + 15, y, x - 15, y);
		surface.DrawLine(x, y + 15, x, y - 15);
		surface.DrawOutlinedRect(x - 8, y - 8, 17, 17);
		if (Clockwork.player:CanSeePosition(Clockwork.Client, waypoint.pos, 0.99, player.GetAll())) then
			surface.DrawOutlinedRect(x - 5, y - 5, 11, 11);
		end;

		surface.SetFont("BudgetLabel");
		surface.SetTextColor(color);
		local width = surface.GetTextSize(text);
		surface.SetTextPos(x - width / 2, y + 17);
		surface.DrawText(text);

		if (!waypoint.noDistance) then
			local distanceText = tostring(math.Round(clientPos:Distance(waypoint.pos) * 0.01905, 2)).."m";
			width = surface.GetTextSize(distanceText);
			surface.SetTextPos(x - width / 2, y - (15 + height));
			surface.DrawText(distanceText);
		end;
	end;
end;