local COMMAND = Clockwork.command:New("PtMenu");
COMMAND.tip = "Opens the protection team menu.";
COMMAND.flags = CMD_DEFAULT;

function COMMAND:OnRun(player, arguments)
	if (Schema:PlayerIsCombine(player)) then
		Clockwork.datastream:Start(player, "OpenPT");
	else
		Clockwork.player:Notify(player, "You are not on a Combine faction!")
	end;
end;

COMMAND:Register();