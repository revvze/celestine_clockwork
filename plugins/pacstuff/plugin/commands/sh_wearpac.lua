COMMAND = Clockwork.command:New("WearPAC");
COMMAND.tip = "Wears your PAC creation.";
COMMAND.flags = W;
COMMAND.arguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player)
	player:ConCommand("pac_wear_parts")
end;



COMMAND:Register(COMMAND, "WearPAC");