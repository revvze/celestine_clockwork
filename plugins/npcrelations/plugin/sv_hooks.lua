--[[
	This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License.
	To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/4.0/.
]]


local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

function PLUGIN:OnEntityCreated(entity)
	if (entity:IsNPC()) then
		for _, ply in pairs(player.GetAll()) do
			if (ply:HasInitialized()) then
				local faction = Clockwork.player:GetFactionTable(ply);
				if (faction and faction.npcRelations) then
					self:SetEntityRelationship(entity, ply, faction.npcRelations[entity:GetClass()]);
				end;
			end;
		end;
	end;
end;

function PLUGIN:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	if (firstSpawn) then
		local npcRelations = Clockwork.player:GetFactionTable(player).npcRelations;
		if (npcRelations) then
			for _, entity in pairs(ents.GetAll()) do
				if (entity:IsNPC() and npcRelations[entity:GetClass()]) then
					self:SetEntityRelationship(entity, player, npcRelations[entity:GetClass()]);
				end;
			end;
		else
			for _, entity in pairs(ents.GetAll()) do
				if (entity:IsNPC()) then
					self:SetEntityRelationship(entity, player);
				end;
			end;
		end;
	end;
end;