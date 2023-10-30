--[[
	This work is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License.
	To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/4.0/.
]]

local PLUGIN = PLUGIN;
local Clockwork = Clockwork;

local D_HT = D_HT;

-- Function to set a entity's relationship with a player
function PLUGIN:SetEntityRelationship(entity, player, relation)
	entity:AddEntityRelationship(player, relation or D_HT, 0);
end;