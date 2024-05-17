------------------// Waiting Game Load \\------------------

if not game:IsLoaded()then
    local d=Instance.new("Message",workspace);
   d.Text='Waiting game to loaded before scripts is getting executed';
   game.Loaded:Wait();
   d:Destroy();
   task.wait(5);
   end;

   repeat wait();
   until game.Players;
   repeat wait();
   until game:GetService("Players").LocalPlayer;

------------------// Services \\------------------

local fakeStairs = {};
local vim = game:GetService("VirtualInputManager");
local players = game:GetService("Players");
local player = players.LocalPlayer;
local playerCharacter = workspace[player.Name];
local title = player.PlayerGui.GameplayGUI.Timer.Title.Text;

------------------// Send Virtual Input \\------------------

function hold(keyCode, time)
    vim:SendKeyEvent(true, keyCode, false, game);
    task.wait(time);
    vim:SendKeyEvent(false, keyCode, false, game);
end

------------------// Get Stairs \\------------------

function check()
    local pos = playerCharacter.HumanoidRootPart.Position;
    local rayOrigin = pos;
    local rayDirection = Vector3.new(0, 8, 6);
    local raycastParams = RaycastParams.new();
    if (#fakeStairs > 0) then
        fakeStairs = {};
    end
    for i, v in pairs(workspace.Stairs:GetChildren()) do
        if (v.Transparency == 0) then
            table.insert(fakeStairs, v);
        end
    end
    raycastParams.FilterDescendantsInstances = fakeStairs;
    raycastParams.FilterType = Enum.RaycastFilterType.Whitelist;
    local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams);
    if raycastResult then
    else
        return false;
    end
    return true;
end

------------------// Notification \\------------------

local Notification = loadstring(game:HttpGet("https://auztinhub.web.app/notify/NotifyLibrary.lua"))();
local SuccessExecute = Notification.new("success", "Success Execute", "Now Loading Function");
local Credit = Notification.new("info", "Credit", "Make By Zelda");
local loadFunction = Notification.new("warning", "Loading.", "Loading Function Pls Wait");

------------------// Configs \\------------------


getgenv().Stair_Taper = {
    AutoTapSpeed=25,
    AutoTap=false,
    AutoRebirth=false,
    FastMode=true,
    Autovote=true,
    Autovotemode="Classic",
    antireport=true
};

------------------// Save Settings \\------------------

function LoadSettings()
	if (readfile and writefile and isfile and isfolder) then
		if not isfolder("Auztin") then
			makefolder("Auztin");
		end

		if not isfile("Auztin/specific-game-"..game:GetService("Players").LocalPlayer.Name..game.PlaceId..".cfg") then
			writefile("Auztin/specific-game-"..game:GetService("Players").LocalPlayer.Name..game.PlaceId..".cfg", game:GetService("HttpService"):JSONEncode(getgenv().Stair_Taper));
		else
			local a = game:GetService("HttpService"):JSONDecode(readfile("Auztin/specific-game-"..game:GetService("Players").LocalPlayer.Name..game.PlaceId..".cfg"));
			for a, b in pairs(a) do
				getgenv().Stair_Taper[a] = b;
			end
		end
	else
		return warn("Status : Undetected Executor");
	end
end

function SaveSettings()
	if (readfile and writefile and isfile and isfolder) then
		if not isfile("Auztin/specific-game-"..game:GetService("Players").LocalPlayer.Name..game.PlaceId..".cfg") then
			LoadSettings();
		else
			local a = game:GetService("HttpService"):JSONDecode(readfile("Auztin/specific-game-"..game:GetService("Players").LocalPlayer.Name..game.PlaceId..".cfg"));
			local a = {};
			for b, c in pairs(getgenv().Stair_Taper) do
				a[b] = c;
			end
			writefile("Auztin/specific-game-"..game:GetService("Players").LocalPlayer.Name..game.PlaceId..".cfg", game:GetService("HttpService"):JSONEncode(a));
        		end
	else
		return warn("Status : Undetected Executor");
	end
end
LoadSettings();

------------------// Check Date \\------------------

GetSubPrefix=function(a)
    local a=tostring(a):gsub(" ","");
    local bX="";
    if#a==2 then 
        local Yp=string.sub(a,#a,#a+1);
        bX=Yp=="1"and"st"or Yp=="2"and"nd"or Yp=="3"and"rd"or"th";
    end;
    return bX;
end;

local h="%A, %B";local t=os.date(" %d",os.time());
local l=", %Y.";
h=os.date(h,os.time())..t..GetSubPrefix(t)..os.date(l,os.time());

------------------// UI Library \\------------------

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))();
local SaveManager = loadstring(game:HttpGet("https://auztinhub.web.app/Addons/SaveManager.lua"))();
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))();
local Window = Fluent:CreateWindow({Title=(("Auztin | Stair Tapper - "..tostring(h))),SubTitle="by Zelda",TabWidth=135,Size=UDim2.fromOffset(580, 460),Acrylic=true,Theme="Amethyst",MinimizeKey=Enum.KeyCode.LeftControl});
local Tabs = {Main=Window:AddTab({Title="Main",Icon="home"}),Settings=Window:AddTab({Title="Settings",Icon="settings"})};
local Options = Fluent.Options;
do
	Tabs.Main:AddSlider("AutoTapSpeed", {Title="Auto Tap Delay",Description="Auto Tap Delay (ms)",Default=getgenv().Stair_Taper.AutoTapSpeed,Min=0,Max=150,Rounding=1,Callback=function(Value)
		getgenv().Stair_Taper.AutoTapSpeed = Value;
		SaveSettings();
	end});

	local Modex = Tabs.Main:AddDropdown("Modexz", {Title="Mode",Values={"Freebies","Rising Lava","Flipped","Classic","Classic Race","Hardcore"},Multi=false,Default=getgenv().Stair_Taper.Autovotemode});
	Modex:OnChanged(function(Value)
		getgenv().Stair_Taper.Autovotemode = Value;
		SaveSettings();
	end);

	Tabs.Main:AddToggle("Auto Vote", {Title="Auto Vote [W.I.P]",Default=getgenv().Stair_Taper.Autovote}):OnChanged(function(Value)
		getgenv().Stair_Taper.Autovote = Value;
		SaveSettings();
	end);

	Tabs.Main:AddToggle("FastModex", {Title="Fast Mode",Default=getgenv().Stair_Taper.FastMode}):OnChanged(function(Value)
		getgenv().Stair_Taper.FastMode = Value;
		SaveSettings();
	end);

	Tabs.Main:AddToggle("FastModex", {Title="Anti Report",Default=getgenv().Stair_Taper.antireport}):OnChanged(function(Value)
		getgenv().Stair_Taper.antireport = Value;
		SaveSettings();
	end);

	Tabs.Main:AddToggle("Enabledz", {Title="Enabled",Default=getgenv().Stair_Taper.AutoTap}):OnChanged(function(Value)
		getgenv().Stair_Taper.AutoTap = Value;
		SaveSettings();
	end);

	Tabs.Main:AddToggle("AutoRebirthz", {Title="Auto Rebirth",Default=getgenv().Stair_Taper.AutoRebirth}):OnChanged(function(Value)
		getgenv().Stair_Taper.AutoRebirth = Value;
		SaveSettings();
	end);
end

------------------// Auto Climb \\------------------

task.spawn(function()
    while getgenv().Stair_Taper.AutoTap == true do
        if getgenv().Stair_Taper.antireport == true then
            task.wait(math.random(0.01, 0.35)/1000)
        else
            wait(0)
        end
        if (#player.PlayerGui.SpectateGUI:GetChildren() <= 0) then
            if (#workspace.Stairs:GetChildren() > 0) then
                if ((title == "Beginning In...") or (title == "Intermission")) then
                else
                    if (check() == true) then
                        hold(Enum.KeyCode.Left, 0.0015);
                    else
                        hold(Enum.KeyCode.Right, 0.0015);
                    end
                    if getgenv().Stair_Taper.FastMode == true then
                        wait()
                    else
                    wait((getgenv().Stair_Taper.AutoTapSpeed - math.random(-2,2)) / 1000)
                    end
                end
            end
        end
    end
    end)


    task.spawn(function()
        while getgenv().Stair_Taper.AutoRebirth == true do
            wait();
            game:GetService("ReplicatedStorage").Remotes.RebirthRF:InvokeServer();
        end
    end)

loadFunction:changeHeading("Loading...");
SaveManager:SetLibrary(Fluent);
InterfaceManager:SetLibrary(Fluent);
SaveManager:IgnoreThemeSettings();
SaveManager:SetIgnoreIndexes({});
InterfaceManager:SetFolder("FluentScriptHub");
SaveManager:SetFolder("FluentScriptHub/specific-game");
InterfaceManager:BuildInterfaceSection(Tabs.Settings);
SaveManager:BuildConfigSection(Tabs.Settings);
Window:SelectTab(1);
local Successload = Notification.new("success", "Success Loaded", "Now enjoy our script❤️.");
Successload:deleteTimeout(3);
loadFunction:delete();
Credit:delete();
SuccessExecute:delete();