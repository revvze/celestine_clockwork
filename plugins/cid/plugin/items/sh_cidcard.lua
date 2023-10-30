local PLUGIN = PLUGIN;

local ITEM = Clockwork.item:New();
ITEM.name = "Civil ID Card";
ITEM.cost = 150;
ITEM.model = "models/sky/cid.mdl";
ITEM.weight = 0;
ITEM.category = "Cards";
ITEM.uniqueID = "cid_card";
ITEM.business = false;
ITEM.examineOveride = true;
ITEM.description = "A Civil Identification Card with a name, a CID number and an assigned apartment. \nThe card has a Union logo in the background.";

-- Info stored in the card.
ITEM:AddData("CardHolder", "NO HOLDER", true);
ITEM:AddData("CIDNumber", "NO CID", true);
ITEM:AddData("Residence", "NO ASSIGNED RESIDENCE", false);

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) end;

-- Called when a player uses the item.
function ITEM:OnUse(player, itemEntity)
	if (self:GetData("CardHolder") == "NO HOLDER") then
			if (player:GetCharacterData("citizenid")) then
				self:SetData("CardHolder", player:Name());
				self:SetData("CIDNumber", player:GetCharacterData("citizenid"));
				end;
			end;
	
	return false;
end;

function ITEM:GetExamineText(player, itemEntity)
	return "Card Holder: "..self:GetData("CardHolder").."\nCID Number: #"..self:getData("CIDNumber").."\nAssigned Residence: "..self:GetData("Residence");
end;

if (CLIENT) then
	function ITEM:GetClientSideInfo()
		if (!self:IsInstance()) then return; end;
		
		local clientInfo = "";
		local cardholder = self:GetData("CardHolder");
		local cidnumber = self:GetData("CIDNumber");
		local residence = self:GetData("Residence");

		if (cardholder and cidnumber and residence) then
			clientInfo = Clockwork.kernel:AddMarkupLine(clientInfo, "Card Holder: "..cardholder.."\nCID Number: #"..cidnumber.."\nResidence: "..residence);
		end;
		return (clientInfo != "" and clientInfo);
	end;
end;

ITEM:Register();