local PLUGIN = PLUGIN;
local Clockwork = Clockwork;
local surface = surface;
local math = math;
local player = player;
local pairs = pairs;
local IsValid = IsValid;
local grad = surface.GetTextureID("gui/gradient");
local modelheight = 200;
local mainColor = Color(50, 50, 50);
local grey = Color(60, 60, 60);
local textCol = Color(255, 255, 255);
local columnwidth = ScrW() * 0.15625;
local bg = Material("vgui/ptmenu/cmb.png");
local tab = 0;

PLUGIN.ProtectionTeams = {};


surface.CreateFont("ptmenu", {
	size = ScreenScale(8),
	font = "DebugFixed",
	weight = 450,
	antialias = true
});

surface.CreateFont("ptheader", {
	size = ScreenScale(9),
	font = "DebugFixed",
	weight = 500,
	antialias = true
});

surface.CreateFont("ptbody", {
	size = ScreenScale(6),
	font = "DebugFixed",
	weight = 600,
	antialias = true
});

surface.CreateFont("ptbody-2", {
	size = ScreenScale(7),
	font = "DebugFixed",
	weight = 300,
	antialias = true
});


-- BASE PANEL

local panel = {};

function panel:Init()
	self.teambuttons = {};
	PLUGIN.Menu = self;
	PLUGIN.ProtectionTeams = {};
	PLUGIN:GetProtectionTeams(true);

	self:SetSize(ScrW()*0.6, ScrH()*0.75);

	self:InvalidateLayout(true);
	self:MakePopup();
	self.closebutton = self:Add("DButton");
	self.closebutton:SetText("");
	self.closebutton.Paint = function(s, w, h)
		if self.h then
			surface.SetDrawColor(255, 0, 0, 255);
		else
			surface.SetDrawColor(mainColor.r, mainColor.g, mainColor.b);
		end;
		surface.DrawRect(0, 0, w, h);

		surface.SetDrawColor(color_white);
		surface.DrawLine(w / 3.2, h / 3.2, w - (w / 3.2), h - (h / 3.2));
		surface.DrawLine(w / 3.2, h - (h / 3.2), w - (w / 3.2), h / 3.2);
	end;
	self.closebutton.OnCursorEntered = function()
		self.h = true;
	end;
	self.closebutton.OnCursorExited = function()
		self.h = false;
	end;
	self.closebutton:SetSize(32, 32);
	self.closebutton:SetPos(self:GetWide() - 32, 0);
	self.closebutton:SetZPos(1000);
	self.closebutton:SetCursor("arrow")
	self.closebutton.UpdateColours = function()
	end;
	self.closebutton.DoClick = function()
		self:Remove();
	end;

	self.column = self:Add("DScrollPanel");
	self.column:SetWidth(columnwidth);
	self.column:Dock(LEFT);
	self.column.Paint = function(col, w, h)
		surface.SetDrawColor(255, 255, 255, 255);
		surface.SetMaterial(bg);
		surface.DrawTexturedRect(0, h - (ScrH() * 0.7347), ScrW() * 0.2344, ScrH() * 0.7347);
		surface.SetDrawColor(0, 0, 0, 240);
		surface.DrawRect(0, 0, w, h);
		surface.SetDrawColor(0, 0, 0, 220);
		surface.SetTexture(grad);
		surface.DrawTexturedRectRotated(w - 5, h / 2, 10, h, 180);
	end;
	self.column:DockPadding(1, 20, 20, 5);
	self.column.VBar.btnUp:Hide();
	self.column.VBar.btnDown:Hide();
	self.column.VBar.btnGrip.Paint = function(grip, w, h)
		surface.SetDrawColor(50, 50, 50, 200);
		surface.DrawRect(0, 0, w, h);
	end;


	self.ViewAll = self.column:Add("ptmenubutton");
	self.ViewAll:Text("Protection Teams Overview");
	self.ViewAll:DockMargin(0, 0, 5, 0);
	self.ViewAll:Dock(TOP);
	self.ViewAll.DoClick = function(s)
		self:Overview();
	end;

	self.CreatePT = self.column:Add("ptmenubutton");
	self.CreatePT:Text("Create Protection Team");
	self.CreatePT:DockMargin(0, 0, 5, 0);
	self.CreatePT:Dock(TOP);
	self.CreatePT.DoClick = function()
		self.CreatePT:SetDisabled(true);
		
		if Clockwork.Client:GetSharedVar("PTeam") == 0 then
			Clockwork.datastream:Start("PTCreate");
			self:Rebuild();
		else
			Clockwork.datastream:Start("FailedPT");
		end;
		-- Enable  the button two seconds after it was pressed
		--timer.Simple(2, function() self.CreatePT:SetDisabled(false); end)
	end;


	timer.Create("ptaddbuttons", 0.1, 100, function()
		if (#PLUGIN.ProtectionTeams > 0 and IsValid(self)) then
			self:PopulateMenu();
			timer.Remove("ptaddbuttons");
			return;
		elseif !(IsValid(self)) then
			timer.Remove("ptaddbuttons");
			return;
		end;
	end);

	self:Center();
end;

function panel:PopulateMenu()
	for k, v in pairs(PLUGIN.ProtectionTeams) do
		local index = #self.teambuttons + 1;
		local text = "Viewing Protection Team " .. v.number;

		self.teambuttons[index] = self.column:Add("ptmenubutton");
		self.teambuttons[index]:DockMargin(0, 0, 5, 0);
		self.teambuttons[index]:Dock(TOP);
		self.teambuttons[index]:Text("PROTECTION TEAM " .. v.number);
		self.teambuttons[index].DoClick = function()
			self.activetab = v.number;
			tab = v.number;

			if (IsValid(self.container)) then
				self.container:Remove();
			end;

			if (IsValid(self.header)) then
				self.header:Remove();
			end;

			self.container = self:Add("DPanel");
			self.container:Dock(FILL);
			self.container:InvalidateLayout(true)
			self.container:DockPadding(10, 10, 10, 10);
			self.container.Paint = function()
			end;
			self.container.members = {};

			self.container.header = self.container:Add("DLabel");
			self.container.header:SetFont("ptheader");
			self.container.header:SetText(text);
			self.container.header:SetTextColor(textCol);
			self.container.header:SizeToContents();
			self.container.header:SetContentAlignment(5);
			self.container.header:Dock(TOP);

			if (Clockwork.Client:GetSharedVar("PTeam") == v.number) then
				self.leavebutton = self.container:Add("ptmenubutton");
				self.leavebutton:Dock(BOTTOM);
				self.leavebutton:Text("Leave Protection Team");
				self.leavebutton.DoClick = function()
					Clockwork.datastream:Start("PTLeave", v.number);
				end;
			end;
			if (Clockwork.Client:GetSharedVar("PTeam") != v.number) then
				self.joinbutton = self.container:Add("ptmenubutton");
				self.joinbutton:Dock(BOTTOM);
				self.joinbutton:Text("Join Protection Team");
				self.joinbutton.DoClick = function()
					Clockwork.datastream:Start("PTJoin", v.number);
				end;
			end;

			for k2, v2 in pairs(v.members) do
				if (!IsValid(v2)) then
					table.remove(v.members, v2);
					continue;
				end;
				
				local index = #self.container.members + 1;
				local CanKick = (Clockwork.Client:GetSharedVar("PTLead") and Clockwork.Client:GetSharedVar("PTeam") == v2:GetSharedVar("PTeam")) or (PLUGIN:IsDispatch(Clockwork.Client));

				self.container.members[index] = self.container:Add("ptinfo");
				self.container.members[index]:Dock(LEFT);
				self.container.members[index]:SetPlayer(v2);
				self.container.members[index]:SetModel(v2:GetModel());
				self.container.members[index]:SetWide((ScrW() * 0.6 - columnwidth) / 4.1);
				if (!CanKick and self.container.members[index].kick) then
					self.container.members[index].kick:Hide();
				end;
			end;
		end;
	end;
end;

function panel:Overview()
	local text = "Protection Teams Overview";
	self.activetab = "overview";
	tab = 0;
	self.teams = {};
	PLUGIN.ProtectionTeams = {};
	PLUGIN:GetProtectionTeams(true);

	if (IsValid(self.container)) then
		self.container:Remove();
	end;

	if (IsValid(self.header)) then
		self.header:Remove();
	end;

	self.header = self:Add("DLabel");
	self.header:SetFont("ptheader");
	self.header:SetText(text);
	self.header:SetTextColor(textCol);
	self.header:SizeToContents();
	self.header:SetContentAlignment(5);
	self.header:DockMargin(0, 10, 0, 0);
	self.header:Dock(TOP);

	self.container = self:Add("DScrollPanel");
	self.container:Dock(FILL);
	self.container:InvalidateLayout(true)
	self.container:DockPadding(5, 5, 5, 5)
	self.container.Paint = function()
	end;

	timer.Create("ptoverviewload", 0.1, 100, function()
		if (#PLUGIN.ProtectionTeams > 0) and IsValid(self) and (self.activetab == "overview") then
			for k, v in pairs(PLUGIN.ProtectionTeams) do
				local index = #self.teams + 1;
				self.teams[index] = self.container:Add("ptoverinfo");
				self.teams[index]:SetTall(320)
				self.teams[index]:Dock(TOP);
				self.teams[index]:SetTitle("Protection Team " .. v.number);
				self.teams[index]:SetMembers(v.members);
			end;
			timer.Remove("ptoverviewload");
			return;
		end;
		if (self.activetab != "overview") then
			timer.Remove("ptoverviewload");
			return;
		end;
	end);
end;

function panel:Rebuild(bRestoreTab)
	self:Remove();
	PLUGIN.Menu = vgui.Create("pteam");

	if (bRestoreTab) then
		timer.Create("protectionTeamRebuild", 0.03, 100, function()
			if !(PLUGIN.Menu.teambuttons) then return; end;

			for k, v in pairs(PLUGIN.Menu.teambuttons) do
				local tabnum = tonumber(v:GetText():sub(17, -1));
				-- print(tostring(tabnum));

				if (tab == 0) then
					PLUGIN.Menu.ViewAll:DoClick();
					timer.Remove("protectionTeamRebuild");
					return;
				end;

				if ((tabnum) == tab) then
					v:DoClick();
					timer.Remove("protectionTeamRebuild");
					return;
				end;
			end;
		end);
	end;
end;

function panel:Paint(w, h)
	surface.SetDrawColor(mainColor);
	surface.DrawRect(0, 0, w, h);
end;

vgui.Register("pteam", panel);


-- BUTTONS

panel = {};

function panel:Init()
	self:SetFont("ptmenu");
	self:SetTextColor(textCol)
end;

function panel:Text(text)
	self:SetText(text);
	self:SizeToContents();
	self:SetTall(self:GetTall() + 15);
end;

function panel:UpdateColours(skin)
end;

function panel:OnCursorEntered()
	self:SetTextColor(Color(70, 185, 220));
end;

function panel:Think()
	if (self:GetText():sub(1, 16) == "PROTECTION TEAM") then
		local ptnum = tonumber(self:GetText():sub(17, -1))

		if (ptnum == Clockwork.Client:GetSharedVar("PTeam")) then
			self.set = true;

			self:SetTextColor(Color(70, 190, 225));
		end
	else
		if self.set then
			self.set = false;

			self:SetTextColor(textCol);
		end;
	end;
end;

function panel:OnCursorExited()
	self:SetTextColor(textCol);
end;

function panel:Paint(w, h)
	surface.SetDrawColor(grey);
	surface.DrawRect(5, 5, w - 5, h - 5);
end;

vgui.Register("ptmenubutton", panel, "DButton");




-- INFOLABELS

panel = {};

function panel:Init()
	self:SetTall(64);
	self:DockPadding(10, 20, 10, 10);
	self.title = self:Add("DLabel");
	self.title:SetMouseInputEnabled(false);
	self.title:SetTextColor(textCol);
	self.title:SetFont("ptheader");
	self.title:Dock(TOP);

	// self.members = self:Add("DLabel");
	// self.members:SetFont("ptbody");
	// self.members:SetTextColor(color_black);
	// self.members:Dock(BOTTOM);
end;

function panel:SetTitle(text)
	self.title:SetText(text);
	self.title:SizeToContents();
end;

function panel:SetMembers(members)
	self.members = {};

	for k, v in pairs(members) do
		if (IsValid(v)) then
			local index = #self.members + 1;
			self.members[index] = self:Add("ptmemberoverview");
			self.members[index]:SetPlayer(v);
			self.members[index]:SetTall(64);
			self.members[index]:DockMargin(0, 2, 0, 0);
			self.members[index]:Dock(TOP);

			if (((v:GetSharedVar("PTeam") == Clockwork.Client:GetSharedVar("PTeam") and Clockwork.Client:GetSharedVar("PTLead")) or PLUGIN:IsDispatch(Clockwork.Client)) and v != Clockwork.Client) then
				self.members[index]:AddKickButton();
			end;
		end;
	end;
end;

function panel:Paint(w, h)
	surface.SetDrawColor(0, 0, 0, 20);
	surface.DrawRect(0, h - 2.5, w, 5);
end;

vgui.Register("ptoverinfo", panel);

panel = {};

function panel:Init()
	self.model = self:Add("DModelPanel");
	self.model:SetTall(self:GetTall());
	self.model:Dock(LEFT);
	self.model:SetFOV(20);
	self.model.LayoutEntity = function(s, ent)
		ent:SetIK(false);
	end;

	self.tagline = self:Add("DLabel");
	self.tagline:SetTextColor(textCol)
	self.tagline:SetFont("ptbody-2");
	self.tagline:DockMargin(20, 0, 0, 0);
	self.tagline:Dock(LEFT);
end;

function panel:SetModel(model)
	local entity = ents.CreateClientProp("models/error.mdl");

	self.model:SetModel(model);
	entity:SetAngles(Angle(0, 0, 0));
	entity:SetPos(Vector(-1, 0, 0));
	entity:SetModel(model);
	entity:Spawn();
	entity:Activate();
	entity:PhysicsInit(SOLID_VPHYSICS);

	local obbCenter = entity:OBBCenter();

	obbCenter.z = obbCenter.z + 31;

	local distance = entity:BoundingRadius() * 0.8;

	entity:Remove();

	self.model:SetLookAt(obbCenter + Vector(5, 0, 0));
	self.model:SetCamPos(obbCenter + Vector(distance * 1.1, distance * -0.5, 0));
end;

function panel:SetPlayer(client)
	self.player = client;
	self.tagline:SetText(client:Name());
	self.tagline:SizeToContents();
	self:SetModel(client:GetModel());
end;

function panel:AddKickButton()
	self.kick = self:Add("ptmenubutton");
	self.kick:Text("[KICK]");
	self.kick:SetWide(150);
	self.kick:Dock(RIGHT);
	self.kick.DoClick = function(s)
		Clockwork.datastream:Start("PTKick", self.player);
	end;
end;

vgui.Register("ptmemberoverview", panel);

-- PROTECTION MEMBER BOX

panel = {};

function panel:Init()
	self:DockPadding(0, 0, 0, (ScrH() * 0.75) / 3);
	self:InvalidateLayout(true)
	self.model = self:Add("DModelPanel");
	self.model:SetCamPos(Vector(100, 0, 25));
	self.model:SetFOV(40);
	self.model:SetTall(modelheight);
	self.model:SetWide(self:GetWide());
	self.model:Dock(FILL);

	local x, y = self.model:GetPos();
	self.kick = self:Add("ptmenubutton");
	self.kick:Text("[KICK]");
	self.kick:SetWide((PLUGIN.Menu:GetWide() - columnwidth) / 4.1);
	self.kick:SetPos(0, PLUGIN.Menu:GetTall() - self.kick:GetTall()*6)
	self.kick.DoClick = function()
		Clockwork.datastream:Start("PTKick", self:GetPlayer());
	end;

	function self.model:LayoutEntity(ent)
		ent:SetIK(false);
	end;
end;

function panel:SetModel(model)
	local entity = ents.CreateClientProp("models/error.mdl");

	self.model:SetModel(model);
	entity:SetAngles(Angle(0, 0, 0));
	entity:SetPos(Vector(0, 0, 0));
	entity:SetModel(model);
	entity:Spawn();
	entity:Activate();
	entity:PhysicsInit(SOLID_VPHYSICS);

	local obbCenter = entity:OBBCenter();

	obbCenter.z = obbCenter.z * 1.09;

	local distance = entity:BoundingRadius() * 1.2;

	entity:Remove();

	self.model:SetLookAt(obbCenter);
	self.model:SetCamPos(obbCenter + Vector(distance * 1.1, distance * 0.25, distance * 0.4));
	self.model:SetPos(0, self:GetTall() - self.model:GetTall() / 2);
	self.model:SetWide(self:GetWide());
end;

function panel:SetPlayer(client)
	self.client = client;

	if (client == Clockwork.Client and IsValid(self.kick)) then
		self.kick:Hide();
	end;
end;

function panel:GetPlayer()
	return self.client or Clockwork.Client;
end;

function panel:Paint(w, h)
	local name = self:GetPlayer():Name():upper();
	surface.SetFont("ptbody")
	local w, h = surface.GetTextSize("HEALTH");
	local x, y = self.model:GetPos();

	surface.SetFont("ptbody");
	draw.SimpleText(name, "ptbody", self:GetWide() / 2, self.model:GetTall(), textCol, TEXT_ALIGN_CENTER);
	draw.SimpleText("HEALTH: " .. (self:GetPlayer():Health()/self:GetPlayer():GetMaxHealth() * 100) .. "%", "ptbody", self:GetWide() / 2, self.model:GetTall() + h, textCol, TEXT_ALIGN_CENTER);
end;

vgui.Register("ptinfo", panel);