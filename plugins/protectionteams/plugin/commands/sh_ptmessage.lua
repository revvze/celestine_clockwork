local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("PtMessage");
COMMAND.tip = "As Dispatch, send a radio message out to a specific protection team.";
COMMAND.text = "<number Team> <string Text>";
COMMAND.flags = bit.bor(CMD_DEFAULT, CMD_DEATHCODE, CMD_FALLENOVER);
COMMAND.arguments = 2;

function COMMAND:OnRun(player, arguments)
	if (PLUGIN:IsDispatch(player)) then
		local chan = tonumber(arguments[1]);

		PLUGIN:SayPTRadioChannel(player, table.concat(arguments, " ", 2), chan, false, true);
	else
		Clockwork.player:Notify(player, "You are not Dispatch!")
	end;
end;

COMMAND:Register();