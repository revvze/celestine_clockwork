local PLUGIN = PLUGIN;

surface.CreateFont("visorName", {
	font = "Default",
	weight = 800,
	size = ScreenScale(6.5),
	antialias = false,
	outline = true
});

local function drawCircle( x, y, radius, smoothness )
	local circle = {};
	for i = 1, 360, smoothness do
		circle[ #circle + 1 ] =
		{
			x = x + math.sin( -math.rad( i ) ) * radius,
			y = y + math.cos( -math.rad( i ) ) * radius,
		}
	end;

	surface.DrawPoly(circle);
end;

--[[
function PLUGIN:HUDPaint()
	if (Schema:PlayerIsCombine(Clockwork.Client)) and (Clockwork.Client:GetSharedVar("PTeam", 0) > 0) then
		for k, v in pairs(player.GetAll()) do
			if (v != Clockwork.Client and Schema:PlayerIsCombine(v) and v:GetSharedVar("PTeam", 0) == Clockwork.Client:GetSharedVar("PTeam", 0) and !v:GetNoDraw()) then
				local center = v:LocalToWorld(v:OBBCenter());
				local x, y = center:ToScreen().x, center:ToScreen().y;

				surface.SetDrawColor(0, 255, 0, 255);
				drawCircle(x, y, 5, 10);

				draw.SimpleText(v:Name(), "visorName", x + 10, y, Color(0, 255, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER);

				cam.Start3D();
					render.DrawLine(Clockwork.Client:GetPos(), center, Color(0, 255, 0, 255), false);
				cam.End3D();
			end;
		end;
	end;
end;]]

-- Called when the target player's text (Description, etc.) is needed.
function PLUGIN:GetTargetPlayerText(player, targetPlayerText)

	if (!Schema:PlayerIsCombine(Clockwork.Client)) then return; end;

	local ptNumber = player:GetSharedVar("PTeam", 0);
	
	-- If in a protectionteam
	if (ptNumber > 0) then
		local teamStatus = "Member";
		-- Blue
		local color = Color(0, 114, 188, 255);
		
		if (player:GetSharedVar("PTLead")) then
			teamStatus = "Lead";
		end;
		
		-- If in same PT - Color green
		if (ptNumber == Clockwork.Client:GetSharedVar("PTeam", 0)) then
			-- Green
			color = Color (34, 139, 34, 255);
		end;
		
		targetPlayerText:Add("PTStatus", "PT"..ptNumber.." "..teamStatus, color);
	end;
end;

Clockwork.datastream:Hook("ReceivePTInfo", function(data)
	local bNoRebuild = data[2];

	PLUGIN.ProtectionTeams = data[1];

	if !(bNoRebuild) then
		if (IsValid(PLUGIN.Menu)) then
			PLUGIN.Menu:Rebuild(true);
		end;
	end;
end);

Clockwork.datastream:Hook("OpenPT", function()
	PLUGIN:CreateMenu();
end);