COMMAND = Clockwork.command:New("PACEditor");
COMMAND.tip = "Opens the PAC editor.";
COMMAND.flags = W;

-- Called when the command has been run.
function COMMAND:OnRun(player)
	player:ConCommand("pac_editor")
end;



COMMAND:Register(COMMAND, "PACEditor");