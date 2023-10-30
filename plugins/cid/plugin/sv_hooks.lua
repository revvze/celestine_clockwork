local PLUGIN = PLUGIN;

local residenceFemale = {}
residenceFemale[1] = "UNASSIGNED"
local residenceMale = {}
residenceMale[1] = "UNASSIGNED"
local residenceCwu = {}
residenceCwu[1] = "UNASSIGNED"


function assign()
    if (player:HasItemByID("cid_card") or player:HasItemByID("loyal_card"))then
	return false;
	elseif (player:GetFaction() == FACTION_CITIZEN and player:GetGender() == GENDER_FEMALE)then
		local name = player:Name();
		local cid = player:GetCharacterData("citizenid");
		local id = player:GiveItem(Clockwork.item:CreateInstance("cid_card"));
					
		id:SetData("CardHolder", name);
		id:SetData("CIDNumber", cid);
		id:SetData("Residence", residenceFemale[math.random( 1, #residenceFemale )]);
		player:SetCharacterData("issuedCard", "true");
	elseif (player:GetFaction() == FACTION_CITIZEN and player:GetGender() == GENDER_MALE)then
		local name = player:Name();
		local cid = player:GetCharacterData("citizenid");
		local id = player:GiveItem(Clockwork.item:CreateInstance("cid_card"));
					
		id:SetData("CardHolder", name);
		id:SetData("CIDNumber", cid);
		id:SetData("Residence", residenceMale[math.random( 1, #residenceMale )]);
		player:SetCharacterData("issuedCard", "true");
	elseif (player:GetFaction() == FACTION_CWU)then
		local name = player:Name();
		local cid = player:GetCharacterData("citizenid");
		local id = player:GiveItem(Clockwork.item:CreateInstance("loyal_card"));
					
		id:SetData("CardHolder", name);
		id:SetData("CIDNumber", cid);
		id:SetData("Residence", residenceCwu[math.random( 1, #residenceCwu )]);
		player:SetCharacterData("issuedCard", "true");
	end;
end;

-- Called when a player's default inventory is needed.
function PLUGIN:GetPlayerDefaultInventory(player, character, inventory)
	local factionTable = Clockwork.faction:FindByID(character.faction);
	if (factionTable.relocationCoupon) then
		Clockwork.inventory:AddInstance(
			inventory, Clockwork.item:CreateInstance("cid_card")
		);
	end;
end;