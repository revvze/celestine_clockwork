local PLUGIN = PLUGIN;

PLUGIN.ProtectionTeams = {};

-- Allows me to not send protection team info to every client
function PLUGIN:GetCops()
	local tbl = {};
	for k, v in pairs(player.GetAll()) do
		if (Schema:PlayerIsCombine(v)) then
			table.insert(tbl, v);
		end;
	end;
	return tbl;
end;

-- Join a protection team!
function PLUGIN:JoinProtectionTeam(client, number)
	for k, v in pairs(self.ProtectionTeams) do
		if (number == v.number and client:GetSharedVar("PTeam") == v.number) then
			Clockwork.player:Notify(client, "You are already in this protection team!");
			return;
		end;

		if (v.number == number and #v.members >= 4) then
			Clockwork.player:Notify(client, "This protection team is full!");
			return;
		end;

		if (number == v.number) then
			if client:GetSharedVar("PTeam") > 0 then
				self:KickFromProtectionTeam(client);
			end;

			table.insert(v.members, client);
			client:SetSharedVar("PTeam", number);
			Clockwork.datastream:Start(self:GetCops(), "ReceivePTInfo", self.ProtectionTeams);
			Clockwork.player:Notify(client, "You have joined protection team " .. number .. ".");

			for k2, v2 in pairs(v.members) do
				if (v2 != client) then
					Clockwork.player:Notify(v2, client:Name() .. " has joined your protection team.");
				end;
			end;

			return;
		end;
	end;
	Clockwork.player:Notify(client, "Could not find the specified protection team!");
end;

function PLUGIN:KickFromProtectionTeam(client, msg)
	for k, v in pairs(self.ProtectionTeams) do
		if (v.number == client:GetSharedVar("PTeam")) then
			for k2, v2 in pairs(v.members) do
				if (v2 == client) then
					table.remove(v.members, k2);
				end;
			end;
		end;

		if (v.number == client:GetSharedVar("PTeam") and #v.members <= 0) then
			self:DisbandProtectionTeam(v.number);
		end;
	end;

	if (client:GetSharedVar("PTeam") > 0) then
		for k, v in pairs(player.GetAll()) do
			if (v != client and v:GetSharedVar("PTeam") == client:GetSharedVar("PTeam")) then
				Clockwork.player:Notify(v, client:Name() .. " left your protection team.");
			end;
		end;

		client:SetSharedVar("PTeam", 0);
		client:SetSharedVar("PTLead", false);
		Clockwork.player:Notify(client, msg or "You have left your protection team.");
		Clockwork.datastream:Start(self:GetCops(), "ReceivePTInfo", self.ProtectionTeams);
	end;
end;

-- Tell a protection team to disappear
function PLUGIN:DisbandProtectionTeam(number)
	for k, v in pairs(self.ProtectionTeams) do
		if (v.number == number) then
			for k2, v2 in pairs(v.members) do
				v2:SetSharedVar("PTLead", false);
				Clockwork.player:Notify(v2, "Your protection team has been disbanded.");
			end;

			table.remove(self.ProtectionTeams, k);
			Clockwork.datastream:Start(self:GetCops(), "ReceivePTInfo", self.ProtectionTeams);
			return;
		end;
	end;
end;

function PLUGIN:PlayerCharacterLoaded(client)
	self:KickFromProtectionTeam(client);
end;

-- Specify a client, because why would you need an empty protection team???
function PLUGIN:CreateProtectionTeam(client)
    local ptIndex = 1;
    local tableIndex = #self.ProtectionTeams + 1;
    local takennum = {};
    self.ProtectionTeams[tableIndex] = {};

    for k, v in pairs(self.ProtectionTeams) do
        if (v.number) then
            takennum[v.number] = true;
        end;
    end;

    -- Continue to change the number until a protection team does not already use our chosen number
    while takennum[ptIndex] do
        ptIndex = ptIndex + 1;
    end;

    self.ProtectionTeams[tableIndex].number = ptIndex;
    self.ProtectionTeams[tableIndex].members = {};
    table.insert(self.ProtectionTeams[tableIndex].members, client);
    client:SetSharedVar("PTeam", ptIndex);
    client:SetSharedVar("PTLead", true);
    Clockwork.player:Notify(client, "Protection Team " .. ptIndex .. " created.");
    Clockwork.datastream:Start(self:GetCops(), "ReceivePTInfo", self.ProtectionTeams)
end;



-- Stolen from the base radio system...
function PLUGIN:SayPTRadio(player, text, check, noEavesdrop)
	local eavesdroppers = {};
	local listeners = {};
	local canRadio = true;
	local info = {listeners = {}, noEavesdrop = noEavesdrop, text = text};

	for k, v in pairs(cwPlayer.GetAll()) do
		if (v:GetSharedVar("PTeam") == player:GetSharedVar("PTeam") or self:IsDispatch(v)) then
			listeners[v] = v;
		end;
	end;

	if (!info.noEavesdrop) then
		for k, v in pairs(cwPlayer.GetAll()) do
			if (v:HasInitialized() and !listeners[v]) then
				if (v:GetShootPos():Distance(player:GetShootPos()) <= Clockwork.config:Get("talk_radius"):Get()) then
					eavesdroppers[v] = v;
				end;
			end;
		end;
	end;

	if (check) then
		canRadio = Clockwork.plugin:Call("PlayerCanRadio", player, info.text, listeners, eavesdroppers);
	end;

	if (canRadio) then
		info = Clockwork.chatBox:Add(listeners, player, "ptradio", info.text);

		if (info and IsValid(info.speaker)) then
			Clockwork.chatBox:Add(eavesdroppers, info.speaker, "ptradio_eavesdrop", info.text);

			Clockwork.plugin:Call("PlayerRadioUsed", player, info.text, listeners, eavesdroppers);
		end;
	end;
end;

function PLUGIN:SayPTRadioChannel(player, text, channel, check, noEavesdrop)
	local eavesdroppers = {};
	local listeners = {};
	local canRadio = true;
	local info = {listeners = {}, noEavesdrop = noEavesdrop, text = text};

	for k, v in pairs(cwPlayer.GetAll()) do
		if (v:GetSharedVar("PTeam") == channel or self:IsDispatch(v)) then
			listeners[v] = v;
		end;
	end;

	if (!info.noEavesdrop) then
		for k, v in pairs(cwPlayer.GetAll()) do
			if (v:HasInitialized() and !listeners[v]) then
				if (v:GetShootPos():Distance(player:GetShootPos()) <= Clockwork.config:Get("talk_radius"):Get()) then
					eavesdroppers[v] = v;
				end;
			end;
		end;
	end;

	if (check) then
		canRadio = Clockwork.plugin:Call("PlayerCanRadio", player, info.text, listeners, eavesdroppers);
	end;

	if (canRadio) then
		info = Clockwork.chatBox:Add(listeners, player, "ptradio", info.text);

		if (info and IsValid(info.speaker)) then
			Clockwork.chatBox:Add(eavesdroppers, info.speaker, "ptradio_eavesdrop", info.text);

			Clockwork.plugin:Call("PlayerRadioUsed", player, info.text, listeners, eavesdroppers);
		end;
	end;
end;