local PLUGIN = PLUGIN;

PLUGIN.storedDeathmarks = PLUGIN.storedDeathmarks or {};
PLUGIN.DeathMarkbuffer = PLUGIN.DeathMarkbuffer or {};

PLUGIN.deathMarkIcon = Clockwork.kernel:GetMaterial("icon16/exclamation.png");

Clockwork.datastream:Hook("DeathmarkAdded", function(data)
	local curTime = CurTime();
	local position = data.position + Vector(0, 0, 50);
	local name = data.name;

	PLUGIN.storedDeathmarks[#PLUGIN.storedDeathmarks + 1] = 
	{
		endTime = curTime + 60,
		position = position,
		name = name
	};
	
end);
