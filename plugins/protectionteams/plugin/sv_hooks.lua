local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

Clockwork.datastream:Hook("PTCreate", function(client)
	PLUGIN:CreateProtectionTeam(client);
end);

Clockwork.datastream:Hook("PTJoin", function(client, num)
	if (client:GetFaction() == FACTION_MPF) then
		PLUGIN:JoinProtectionTeam(client, num);
	end;
end);

Clockwork.datastream:Hook("PTLeave", function(client)
	PLUGIN:KickFromProtectionTeam(client);
end);

Clockwork.datastream:Hook("PTKick", function(client, kicked)
	if ((client:GetSharedVar("PTeam") == kicked:GetSharedVar("PTeam") and client:GetSharedVar("PTLead")) or (PLUGIN:IsDispatch(client))) then
		PLUGIN:KickFromProtectionTeam(kicked, "You were kicked from your protection team by " .. client:Name() .. "!");
		Clockwork.player:Notify(client, "You have kicked " .. kicked:Name() .. " from your protection team.");
	end;
end);

Clockwork.datastream:Hook("FailedPT", function(client)
	Clockwork.player:Notify(client, "You cannot create a new Protection Team when you are already in one!");
end);

-- Info relay. Should this have security? Probably not...
Clockwork.datastream:Hook("RequestPTInfo", function(client, bNoRebuild)
	if (Schema:PlayerIsCombine(client)) then
		Clockwork.datastream:Start(client, "ReceivePTInfo", {PLUGIN.ProtectionTeams, bNoRebuild or false});
	end;
end);


-- Is he gone? KICK HIM!
function PLUGIN:PlayerDisconnected(client)
	self:KickFromProtectionTeam(client);
end;