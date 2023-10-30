local PLUGIN = PLUGIN;
local COMMAND = Clockwork.command:New("PTReassign");
COMMAND.tip = "Changes the number of a PT. If there are already players in the detination PT, the PTs are swapped.";
COMMAND.text = "<int From> <int To>";
COMMAND.arguments = 2;

function COMMAND:OnRun(player, arguments)
	if (Schema:PlayerIsCombine(player)) then
		if (PLUGIN:IsDispatch(player)) then
			local sourceNum = tonumber(arguments[1]);
			local destinationNum = tonumber(arguments[2]);
			local sourceTeam = {};
			local destinationTeam = {};
			local sourceIndex = false;
			local destinationIndex = false;

			if (sourceNum > 0 and destinationNum > 0) then
				for k, v in pairs(cwPlayer.GetAll()) do
					if (v:GetSharedVar("PTeam") == sourceNum) then
						table.insert(sourceTeam, v);
					elseif (v:GetSharedVar("PTeam") == destinationNum) then
						table.insert(destinationTeam, v);
					end;
				end;

				for k, v in pairs(sourceTeam) do
					if (IsValid(v)) then
						v:SetSharedVar("PTeam", destinationNum);
					end;
				end;

				for k, v in pairs(PLUGIN.ProtectionTeams) do
					if (v.number == sourceNum) then
						sourceIndex = k;
					elseif (v.number == destinationNum) then
						destinationIndex = k;
					end;
				end;

				if (sourceIndex) then
					PLUGIN.ProtectionTeams[sourceIndex].number = destinationNum;
				end;

				if (destinationIndex) then
					PLUGIN.ProtectionTeams[destinationIndex].number = sourceNum;
				end;

				for k, v in pairs(destinationTeam) do
					if (IsValid(v)) then
						v:SetSharedVar("PTeam", sourceNum);
					end;
				end;

				Clockwork.player:Notify(sourceTeam, "Your PT has been re-designated by Dispatch as 'PT-" .. destinationNum .. "'.");
				Clockwork.player:Notify(destinationTeam, "Your PT has been re-designated by Dispatch as 'PT-" .. sourceNum .. "'.");
				Clockwork.player:Notify(player, "Successfully changed PT-" .. sourceNum .. " to 'PT-" .. destinationNum .. "'.");
			else
				Clockwork.player:Notify(player, "Your arguments must be greater than zero!");
			end;
		else
			Clockwork.player:Notify(player, "You are not Dispatch!");
		end;
	else
		Clockwork.player:Notify(player, "Only the Combine may use this command!");
	end;
end;

COMMAND:Register();