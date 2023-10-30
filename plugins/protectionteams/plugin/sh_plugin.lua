local PLUGIN = PLUGIN;

function PLUGIN:ClockworkAddSharedVars(globalVars, playerVars)
	playerVars:Number("PTeam");
	playerVars:Bool("PTLead");
end;

function PLUGIN:IsDispatch(client)
	if(IsValid(client)) then
		return client:GetFaction() == FACTION_OVERWATCH;
	end;
end;



Clockwork.kernel:IncludePrefixed("sv_plugin.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_plugin.lua");
Clockwork.kernel:IncludePrefixed("cl_menu.lua");