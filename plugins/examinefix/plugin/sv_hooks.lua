local PLUGIN = PLUGIN;

-- Called when an entity's menu option should be handled.
function PLUGIN:EntityHandleMenuOption(player, entity, option, arguments)
	if (entity:GetClass() == "cw_item" and option == "Examine") then
		local itemTable = entity:GetItemTable();

		if (itemTable.GetExamineText) then
			player:Notify(itemTable:GetExamineText(player, entity));
		else
			player:Notify(itemTable("description"));
		end;
	end;
end;