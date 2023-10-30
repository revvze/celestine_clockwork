local COMMAND = Clockwork.command:New("ChatterToggle");
COMMAND.tip = "Toggles ambient radio chatter.";
COMMAND.flags = CMD_DEFAULT;

function COMMAND:OnRun(player, arguments)
	if (player:GetFaction() == FACTION_MPF or player:GetFaction() == FACTION_OTA) then
		local inverse = !player:GetSharedVar("ChatterEnabled");

		player:SetSharedVar("ChatterEnabled", inverse);
		Clockwork.player:Notify(player, (inverse and "Enabled " or "Disabled ") .. "ambient radio chatter.");
	end;
end;

COMMAND:Register();