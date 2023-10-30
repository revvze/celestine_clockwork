local PLUGIN = PLUGIN;

local COMMAND = Clockwork.command:New("PTLead");
COMMAND.tip = "If PT lead, elect a new member to take over. If no PT lead exists, assumes PT lead instead.";
COMMAND.text = "[string Player]";
COMMAND.flags = CMD_DEFAULT;
COMMAND.optionalArguments = 1;

function COMMAND:OnRun(player, arguments)
	if (Schema:PlayerIsCombine(player)) then
		local newLeader = Clockwork.player:FindByID(arguments[1] or "") or false;

		if (PLUGIN:IsDispatch(player)) then
			if (IsValid(newLeader)) then
				if (newLeader:GetSharedVar("PTeam") > 0) then
					local ptNum = newLeader:GetSharedVar("PTeam");

					for k, v in pairs(cwPlayer.GetAll()) do
						if (v == newLeader) then continue; end;

						if (v:GetSharedVar("PTeam") == ptNum) then
							if (v:GetSharedVar("PTLead")) then
								v:SetSharedVar("PTLead", false);
								Clockwork.player:Notify(v, "Dispatch has removed you from PT lead and assigned lead to " .. newLeader:Name() .. ".");
							else
								Clockwork.player:Notify(v, "Dispatch has given " .. newLeader:Name() .. " PT lead.");
							end;
						end;
					end;

					newLeader:SetSharedVar("PTLead", true);
					Clockwork.player:Notify(newLeader, "Dispatch has assigned you PT lead.");
				else
					Clockwork.player:Notify(player, "That player is not currently assigned to a protection team!");
				end;
			else
				Clockwork.player:Notify(player, "Could not find the specified player!");
			end;
		else
			if (player:GetSharedVar("PTeam") > 0) then
				local ptNum = player:GetSharedVar("PTeam");
				local hasLeader = false;

				for k, v in pairs(cwPlayer.GetAll()) do
					if (v:GetSharedVar("PTeam") == ptNum and v:GetSharedVar("PTLead")) then
						hasLeader = true;
					end;
				end;

				if (hasLeader) then
					if (IsValid(newLeader)) then
						if (player:GetSharedVar("PTLead")) then
							if (newLeader:GetSharedVar("PTeam") == ptNum) then
								player:SetSharedVar("PTLead", false);
								newLeader:SetSharedVar("PTLead", true);

								Clockwork.player:Notify(player, "You have successfully transferred PT lead to " .. newLeader:Name() .. ".");
								Clockwork.player:Notify(newLeader, player:Name() .. " has transferred PT lead to you.");
							else
								Clockwork.player:Notify(player, "That player is not in your protection team!");
							end;
						else
							Clockwork.player:Notify(player, "You do not have the authority to perform this action!");
						end;
					else
						Clockwork.player:Notify(player, "Could not find the specified player!");
					end;
				else
					player:SetSharedVar("PTLead", true);
					Clockwork.player:Notify(player, "You have successfully claimed PT lead.");
					for k, v in pairs(cwPlayer.GetAll()) do
						if (v:GetSharedVar("PTeam") == ptNum and v != player) then
							Clockwork.player:Notify(v, player:Name() .. " has claimed PT lead.");
						end;
					end;
				end;
			else
				Clockwork.player:Notify(player, "You are not currently in a protection team!");
			end;
		end;
	end;
end;

COMMAND:Register();