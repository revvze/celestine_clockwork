--[[
	� CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local FACTION = Clockwork.faction:New("Citizen");

FACTION.useFullName = true;
FACTION.material = "hl2rp2/factions/citizen";
FACTION.startingInv = {
	["cw_suitcase"] = 1
};
FACTION.models = {
	female = {
		"models/humans/pandafishizens/female_01.mdl",
		"models/humans/pandafishizens/female_02.mdl",
		"models/humans/pandafishizens/female_03.mdl",
		"models/humans/pandafishizens/female_04.mdl",
		"models/humans/pandafishizens/female_06.mdl",
		"models/humans/pandafishizens/female_07.mdl"
},
	male = {
		"models/humans/pandafishizens/male_01.mdl",
		"models/humans/pandafishizens/male_02.mdl",
		"models/humans/pandafishizens/male_03.mdl",
		"models/humans/pandafishizens/male_04.mdl",
		"models/humans/pandafishizens/male_05.mdl",
		"models/humans/pandafishizens/male_06.mdl",
		"models/humans/pandafishizens/male_07.mdl",
		"models/humans/pandafishizens/male_08.mdl",
		"models/humans/pandafishizens/male_09.mdl",
		"models/humans/pandafishizens/male_10.mdl"
}
};

-- Called when a player is transferred to the faction.
function FACTION:OnTransferred(player, faction, name)
	if (Schema:PlayerIsCombine(player)) then
		if (name) then
			local models = self.models[ string.lower(player:QueryCharacter("gender")) ];
			
			if (models) then
				player:SetCharacterData("model", models[ math.random(#models) ], true);
				
				Clockwork.player:SetName(player, name, true);
			end;
		else
			return false, "You need to specify a name as the third argument!";
		end;
	end;
end;

FACTION_CITIZEN = FACTION:Register();
