local PLUGIN = PLUGIN;

function PLUGIN:Tick()
	for k, v in pairs(player.GetAll()) do
		if (v:GetFaction() == FACTION_MPF) then
			if (v:Alive() and v:GetSharedVar("ChatterEnabled")) then
				if (CurTime() > (v.nextChatter or 0)) then
					v.nextChatter = math.random(20, 30);
					self:PlayConversation(v);
				end;
			end;
		end;
	end;
end;

Clockwork.datastream:Hook("GetConversationLength", function(player, length)
	timer.Simple(length, function()
		player.conversationPlaying = false;
	end)
	player.nextChatter = CurTime() + length + math.random(15, 30);
end);