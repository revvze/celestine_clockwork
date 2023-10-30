local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

function PLUGIN:GetProtectionTeams(bNoRebuild)
	Clockwork.datastream:Start("RequestPTInfo", bNoRebuild);
end;

function PLUGIN:CreateMenu()
	if !(IsValid(self.Menu)) then
		vgui.Create("pteam");
	end;
end;

Clockwork.chatBox:RegisterClass("ptradio", nil, function(info)
	if (info.shouldHear) then
		local color = Color(100, 100, 255, 255);
		local pteam = info.speaker:GetSharedVar("PTeam");

		if (info.focusedOn) then
			color = Color(150, 150, 255, 255);
		end;

		if (PLUGIN:IsDispatch(info.speaker)) then
			if (Clockwork.Client == info.speaker or PLUGIN:IsDispatch(Clockwork.Client)) then
				Clockwork.chatBox:Add(info.filtered, nil, color, "Dispatch to protection team: \"" .. info.text .. "\"");
			else
				Clockwork.chatBox:Add(info.filtered, nil, color, "Dispatch to your protection team: \"" .. info.text .. "\"");
			end;
		else
			Clockwork.chatBox:Add(info.filtered, nil, color, info.name .. " to your protection team: \"" .. info.text .. "\"");
		end;
	end;
end);

Clockwork.chatBox:RegisterClass("ptradio_eavesdrop", nil, function(info)
	local color = Color(255, 255, 175, 255);

	if (info.focusedOn) then
		color = Color(175, 255, 175, 255);
	end;
	Clockwork.chatBox:Add(info.filtered, nil, color, info.name .. " to protection team: \"" .. info.text .. "\"");
end);