local PLUGIN = PLUGIN;

Clockwork.kernel:IncludePrefixed("cl_plugin.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");


function PLUGIN:PlayerDeath(player, inflictor, attacker, damageInfo)
	if (Schema:PlayerIsCombine(player)) then

		local recipients = {};

		for k, v in pairs(_player.GetAll()) do
			if Schema:PlayerIsCombine(v) then
				recipients[#recipients + 1] = v;
			end
		end;

		Clockwork.datastream:Start(recipients, "DeathmarkAdded", 
		{
			position = player:GetPos(),
			name = player:Name(),
		});
	end;
end;