--[[
	� CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

Clockwork.kernel:IncludePrefixed("cl_schema.lua");
Clockwork.kernel:IncludePrefixed("cl_hooks.lua");
Clockwork.kernel:IncludePrefixed("cl_theme.lua");
Clockwork.kernel:IncludePrefixed("sh_hooks.lua");
Clockwork.kernel:IncludePrefixed("sv_schema.lua");
Clockwork.kernel:IncludePrefixed("sv_hooks.lua");

Schema.customPermits = {};

for k, v in pairs(_file.Find("models/humans/group17/*.mdl", "GAME")) do
	Clockwork.animation:AddMaleHumanModel("models/humans/group17/"..v);
end;

Clockwork.option:SetKey("default_date", {month = 1, year = 2016, day = 1});
Clockwork.option:SetKey("default_time", {minute = 0, hour = 0, day = 1});
Clockwork.option:SetKey("model_shipment", "models/items/item_item_crate.mdl");
Clockwork.option:SetKey("intro_image", "celestine/HL2RP_Logo");
Clockwork.option:SetKey("schema_logo", "celestine/HL2RP_Logo");
Clockwork.option:SetKey("menu_music", "music/operation_stabilization.mp3");
Clockwork.option:SetKey("model_cash", "models/uupack/10tokens.mdl");
Clockwork.option:SetKey("gradient", "hl2rp2/gradient");

Clockwork.config:ShareKey("intro_text_small");
Clockwork.config:ShareKey("intro_text_big");
Clockwork.config:ShareKey("business_cost");
Clockwork.config:ShareKey("permits");

Clockwork.flag:Add("v", "Black Market", "Access to blackmarket goods.");

Clockwork.quiz:SetEnabled(true);
Clockwork.quiz:AddQuestion("QuizOption1", 1, "QuizAnswerYes", "QuizAnswerNo");
Clockwork.quiz:AddQuestion("QuizOption2", 2, "QuizAnswerBadGrammar", "QuizAnswerGoodGrammar");
Clockwork.quiz:AddQuestion("QuizOption3", 1, "QuizAnswerYes", "QuizAnswerNo");
Clockwork.quiz:AddQuestion("QuizOption4", 1, "QuizAnswerYes", "QuizAnswerNo");
Clockwork.quiz:AddQuestion("QuizOption5", 2, "QuizAnswerCollectingItems", "QuizAnswerDevelopingChar");
Clockwork.quiz:AddQuestion("QuizOption6", 2, "QuizAnswerRealLife", "QuizAnswerHalfLife2");

Clockwork.command:AddAlias("StorageGiveCash", "StorageGiveTokens");
Clockwork.command:AddAlias("StorageTakeTokens", "StorageTakeTokens");
Clockwork.command:AddAlias("GiveCash", "GiveTokens");
Clockwork.command:AddAlias("DropCash", "DropTokens");
Clockwork.command:AddAlias("SetCash", "SetTokens");

-- A function to add a custom permit.
function Schema:AddCustomPermit(name, flag, model)
	local formattedName = string.gsub(name, "[%s%p]", "");
	local lowerName = string.lower(name);
	
	self.customPermits[ string.lower(formattedName) ] = {
		model = model,
		name = name,
		flag = flag,
		key = Clockwork.kernel:SetCamelCase(formattedName, true)
	};
end;

-- A function to get if a faction is Combine.
function Schema:IsCombineFaction(faction)
	local factionTable = Clockwork.faction:FindByID(faction);

	return factionTable and factionTable.isCombineFaction or false;
end;
