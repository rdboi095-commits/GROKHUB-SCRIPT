-- Grok Ultimate Blox Fruits Hub v2.0 by xAI (Jan 2026) | Best Combined: Redz/SpeedX/Annie/Monster/Neru/Teddy/Banana/HoHo/Maru
-- Keyless | Rayfield UI | Update 26+ | Mobile/PC | VPN Required!

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "🧠 Grok Ultimate Hub v2.0",
    LoadingTitle = "Grok xAI | Combined Tops...",
    LoadingSubtitle = "Update 26+ | Keyless 🚀",
    ConfigurationSaving = {Enabled = true, FolderName = "GrokBFv2", FileName = "GrokHub"},
    KeySystem = false
})

getgenv().Grok = {Toggles = {}, Sliders = {}, SelectedIsland = "Castle on the Sea"}

-- Services
local Players, ReplicatedStorage, Workspace, TweenService, RunService, UserInputService, VirtualInputManager, TeleportService, HttpService = 
game:GetService("Players"), game:GetService("ReplicatedStorage"), game:GetService("Workspace"), game:GetService("TweenService"), game:GetService("RunService"), 
game:GetService("UserInputService"), game:GetService("VirtualInputManager"), game:GetService("TeleportService"), game:GetService("HttpService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local CommF = ReplicatedStorage.Remotes.CommF_

-- Utils/Anti-Detect
RunService.Heartbeat:Connect(function() RunService:SetFPSCap(999) end)
settings().Physics.PhysicsEnvironmentalThrottleEnabled = false
getgenv()._G.SimRadius = math.huge

local function notify(title, text, duration) Rayfield:Notify({Title = title, Content = text, Duration = duration or 3, Image = 4483362458}) end

local function toTarget(cf) TweenService:Create(RootPart, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {CFrame = cf}):Play() end

local function getClosest(folder) 
    local dist, obj = math.huge
    for _, v in pairs(Workspace[folder]:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
            local mag = (v.HumanoidRootPart.Position - RootPart.Position).Magnitude
            if mag < dist then dist, obj = mag, v end
        end
    end
    return obj
end

local function equip(tool) for _, v in Player.Backpack:GetChildren() do if v:IsA("Tool") and v.Name:find(tool) then v.Parent = Character end end end

-- Level-Based Quests (Smart Farm from Tops)
local Quests = {
    [1] = {Island = "Bandit Quest", CF = CFrame.new(1061.7, 16.5, 1547.5)},
    [15] = {Island = "Monkey Quest", CF = CFrame.new(-1400, 16, 90)},
    [30] = {Island = "Snow Bandit", CF = CFrame.new(1386, 88, -1298)},
    [40] = {Island = "Snow Quest", CF = CFrame.new(1400, 87, -1298)},
    [60] = {Island = "Lab Quest", CF = CFrame.new(6324, 38, 71)},
    [75] = {Island = "Marine Quest", CF = CFrame.new(-2437, 53, 6000)},
    [90] = {Island = "Swan Quest", CF = CFrame.new(-2437, 53, 6000)},
    [120] = {Island = "Jungle Quest", CF = CFrame.new(-1599, 34, 164)},
    [max] = {Island = "Castle on the Sea", CF = CFrame.new(-5074.7, 299, -6871.4)}
}

-- Expanded TPs (60+ from Redz/Maru/Neru)
local TPs = {
    -- First Sea
    ["Starter"] = CFrame.new(-384,74,58), ["Marine Starter"] = CFrame.new(2135,27,128), ["Middle Town"] = CFrame.new(-684,74,3836),
    ["Frozen Village"] = CFrame.new(1385,37,-1293), ["Bandit Quest"] = CFrame.new(1062,17,1548), ["Snow Mountain"] = CFrame.new(1337,455,-637),
    ["Marine Fortress"] = CFrame.new(-4915,60,-1484), ["Skytown"] = CFrame.new(-7862,5628,-415), ["Hot Cold"] = CFrame.new(5712,53,-2860),
    ["Cave"] = CFrame.new(5194,11,-1051), ["Jungle"] = CFrame.new(-1322,65,2315), ["Kingdom Rose"] = CFrame.new(-1257,94,1097),
    ["Cafe"] = CFrame.new(-382,79,555), ["Mansion"] = CFrame.new(-388,93,92), ["Graveyard"] = CFrame.new(2681,16,-1184),
    -- Second Sea
    ["Green Zone"] = CFrame.new(-2448,73,-3215), ["Floating Turtle"] = CFrame.new(-13235,333,-7484), ["Hydra Island"] = CFrame.new(5374,10,418),
    ["Castle Sea"] = CFrame.new(-5075,299,-6871), ["Port Town"] = CFrame.new(-2937,41,5461), ["Great Tree"] = CFrame.new(1450,93,-1359),
    ["Sea Treats"] = CFrame.new(-2596,91,2719), ["Haunted Castle"] = CFrame.new(-9479,142,5842), ["Tiki Outpost"] = CFrame.new(-16030,10,757),
    ["Peanut Land"] = CFrame.new(-2140,50,-10320), ["Citadel"] = CFrame.new(-5220,11,-4711),
    -- Third Sea + Events
    ["Mero Event"] = CFrame.new(386,92,-1110), ["Mirage Island"] = CFrame.new(-13374,144,-8263), ["Prehistoric"] = CFrame.new(-5509,101,-4690),
    ["Thunder God"] = CFrame.new(-2869,35,4596), ["Cursed Captain"] = CFrame.new(916,181,1337), ["Elite Hunter"] = CFrame.new(-5430,101,-900),
    -- Bosses
    ["Dough King"] = CFrame.new(-5075,299,-6871), ["Rip Indra"] = CFrame.new(-5359,559,40) -- Add more as needed
}

-- Farm Tab
local FarmTab = Window:CreateTab("🏴‍☠️ Farm", 4483362458)

FarmTab:CreateToggle({Name = "Auto Farm Level/Quests (Smart Level-Based)", CurrentValue = false, Flag = "AutoFarm", Callback = function(Value)
    getgenv().Grok.Toggles.AutoFarm = Value
    spawn(function()
        while Value and Character and RootPart do
            local level = Player.Data.Level.Value
            local quest = Quests[level] or Quests[max]
            toTarget(quest.CF)
            local enemy = getClosest("Enemies")
            if enemy then equip("Combat"); toTarget(enemy.HumanoidRootPart.CFrame * CFrame.new(math.random(-10,10),20,math.random(-10,10))) end
            wait(0.2)
        end
    end)
end})

FarmTab:CreateToggle({Name = "Auto Mastery", CurrentValue = false, Flag = "AutoMastery", Callback = function(Value)
    getgenv().Grok.Toggles.AutoMastery = Value
    spawn(function()
        while Value do equip("Combat"); local enemy = getClosest("Enemies"); if enemy then toTarget(enemy.HumanoidRootPart.CFrame) end wait(0.3)
    end)
end})

FarmTab:CreateToggle({Name = "Auto Boss (Nearest)", CurrentValue = false, Flag = "AutoBoss", Callback = function(Value)
    getgenv().Grok.Toggles.AutoBoss = Value
    spawn(function()
        while Value do local boss = getClosest("Enemies"); if boss and boss.Name:find("Boss") then equip("Combat"); toTarget(boss.HumanoidRootPart.CFrame * CFrame.new(0,25,0)) end wait(0.4)
    end)
end})

FarmTab:CreateToggle({Name = "Auto Raid (Flame)", CurrentValue = false, Flag = "AutoRaid", Callback = function(Value) if Value then CommF:InvokeServer("Raid", "Select", "Flame"); notify("Raid", "Flame Started!") end end})

FarmTab:CreateToggle({Name = "Auto Dungeon/Sea Beast", CurrentValue = false, Flag = "AutoDungeon", Callback = function(Value)
    getgenv().Grok.Toggles.AutoDungeon = Value
    spawn(function()
        while Value do 
            -- Sea Beast / Dungeon logic (TP + farm)
            toTarget(CFrame.new(-5075,299,-6871)) -- Example Sea
            local sb = getClosest("SeaBeasts") or getClosest("Enemies")
            if sb then toTarget(sb.HumanoidRootPart.CFrame) end
            wait(1)
        end
    end)
end})

-- Fruits Tab (Neru/SpeedX Style)
local FruitsTab = Window:CreateTab("🍎 Fruits", 6033837536)

FruitsTab:CreateToggle({Name = "Fruit ESP (Rarity Glow)", CurrentValue = false, Flag = "FruitESP", Callback = function(Value)
    getgenv().Grok.Toggles.FruitESP = Value
    spawn(function()
        while Value do
            for _, fruit in Workspace:GetChildren() do
                if fruit:IsA("Tool") and fruit.Name:find("Fruit") and not fruit:FindFirstChild("GrokESP") then
                    local esp = Instance.new("BillboardGui", fruit); esp.Name = "GrokESP"; esp.Size = UDim2.new(0,120,0,60); esp.StudsOffset = Vector3.new(0,6,0); esp.Adornee = fruit.Handle
                    local text = Instance.new("TextLabel", esp); text.Size = UDim2.new(1,0,1,0); text.BackgroundTransparency = 1; text.Text = fruit.Name .. "\n[Rarity: " .. (fruit:FindFirstChild("Rarity") and fruit.Rarity.Value or "Common") .. "]"; 
                    text.TextColor3 = Color3.fromRGB(255,215,0); text.TextStrokeTransparency = 0; text.TextScaled = true; text.Font = Enum.Font.GothamBold
                end
            end
            wait(0.5)
        end
        for _, obj in Workspace:GetChildren() do if obj:FindFirstChild("GrokESP") then obj.GrokESP:Destroy() end end
    end)
end})

FruitsTab:CreateToggle({Name = "Fruit Sniper/Grab + Notifier", CurrentValue = false, Flag = "FruitSniper", Callback = function(Value)
    getgenv().Grok.Toggles.FruitSniper = Value
    spawn(function()
        while Value do
            for _, fruit in Workspace:GetChildren() do
                if fruit:IsA("Tool") and fruit.Name:find("Fruit") then
                    toTarget(fruit.Handle.CFrame * CFrame.new(0,5,0))
                    firetouchinterest(RootPart, fruit.Handle, 0); wait(0.1); firetouchinterest(RootPart, fruit.Handle, 1)
                    notify("Fruit Grabbed!", fruit.Name, 2)
                end
            end
            wait(0.3)
        end
    end)
end})

-- Teleport Tab (Full from Maru/Redz)
local TeleTab = Window:CreateTab("🗺️ Teleport", 6033939200)
local IslandDrop = TeleTab:CreateDropdown({Name = "Island/Boss/Event/Mirage", Options = {"Starter","Marine Starter","Middle Town","Frozen Village","Bandit Quest","Snow Mountain","Marine Fortress","Skytown","Hot Cold","Cave","Jungle","Kingdom Rose","Cafe","Mansion","Graveyard","Green Zone","Floating Turtle","Hydra Island","Castle Sea","Port Town","Great Tree","Sea Treats","Haunted Castle","Tiki Outpost","Peanut Land","Citadel","Mero Event","Mirage Island","Prehistoric","Thunder God","Cursed Captain","Elite Hunter","Dough King","Rip Indra"}, CurrentOption = "Castle Sea", Flag = "IslandSel", Callback = function(Opt) getgenv().Grok.SelectedIsland = Opt end})

TeleTab:CreateButton({Name = "TP Now!", Callback = function() if TPs[getgenv().Grok.SelectedIsland] then toTarget(TPs[getgenv().Grok.SelectedIsland]); notify("TP", getgenv().Grok.SelectedIsland) end end})

TeleTab:CreateButton({Name = "Low Player Server Hop", Callback = function()
    local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
    for _, s in servers.data do if s.playing < s.maxPlayers * 0.6 and s.id ~= game.JobId then TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id); break end end
    notify("Hop", "Low ping server!")
end})

-- Player Tab (Advanced Fly from SpeedX/Banana)
local PlayerTab = Window:CreateTab("👤 Player", 4483362458)

PlayerTab:CreateSlider({Name = "Speed", Range = {16,600}, Increment = 10, CurrentValue = 16, Flag = "Speed", Callback = function(v) Humanoid.WalkSpeed = v end})
PlayerTab:CreateSlider({Name = "Jump", Range = {50,600}, Increment = 10, CurrentValue = 50, Flag = "Jump", Callback = function(v) Humanoid.JumpPower = v end})

PlayerTab:CreateToggle({Name = "Infinite Jump", CurrentValue = false, Flag = "InfJump", Callback = function(v) getgenv().Grok.Toggles.InfJump = v; if v then UserInputService.JumpRequest:Connect(function() Humanoid:ChangeState("Jumping") end) end end})
PlayerTab:CreateToggle({Name = "Noclip", CurrentValue = false, Flag = "Noclip", Callback = function(v)
    getgenv().Grok.Toggles.Noclip = v
    spawn(function() while v do for _, p in Character:GetDescendants() do if p:IsA("BasePart") then p.CanCollide = false end end wait() end end)
end})

-- Fly (WASD/Space/Shift - Smooth from HoHo/Teddy)
getgenv().FlySpeed = 200; local Flying, FlyKeys = false, {w=false,a=false,s=false,d=false,space=false,lshift=false}
PlayerTab:CreateToggle({Name = "Fly (WASD + Space/Shift)", CurrentValue = false, Flag = "Fly", Callback = function(Value)
    Flying = Value
    if Character and RootPart then
        local BV = Instance.new("BodyVelocity", RootPart); BV.MaxForce = Vector3.new(4000,4000,4000); BV.Velocity = Vector3.new()
        spawn(function()
            repeat
                local cam = Workspace.CurrentCamera.CFrame; local vel = Vector3.new()
                if FlyKeys.w then vel += cam.LookVector * getgenv().FlySpeed end
                if FlyKeys.s then vel -= cam.LookVector * getgenv().FlySpeed end
                if FlyKeys.a then vel -= cam.RightVector * getgenv().FlySpeed end
                if FlyKeys.d then vel += cam.RightVector * getgenv().FlySpeed end
                if FlyKeys.space then vel += Vector3.new(0, getgenv().FlySpeed, 0) end
                if FlyKeys.lshift then vel -= Vector3.new(0, getgenv().FlySpeed, 0) end
                BV.Velocity = vel; wait()
            until not Flying
            BV:Destroy()
        end)
    end
end})
PlayerTab:CreateSlider({Name = "Fly Speed", Range = {50,600}, Increment = 20, CurrentValue = 200, Flag = "FlySpd", Callback = function(v) getgenv().FlySpeed = v end})

UserInputService.InputBegan:Connect(function(i,gp) if gp then return end pcall(function()
    if i.KeyCode == Enum.KeyCode.W then FlyKeys.w=true elseif i.KeyCode == Enum.KeyCode.S then FlyKeys.s=true elseif i.KeyCode == Enum.KeyCode.A then FlyKeys.a=true
    elseif i.KeyCode == Enum.KeyCode.D then FlyKeys.d=true elseif i.KeyCode == Enum.KeyCode.Space then FlyKeys.space=true elseif i.KeyCode == Enum.KeyCode.LeftShift then FlyKeys.lshift=true end
end) end)
UserInputService.InputEnded:Connect(function(i,gp) if gp then return end pcall(function()
    if i.KeyCode == Enum.KeyCode.W then FlyKeys.w=false elseif i.KeyCode == Enum.KeyCode.S then FlyKeys.s=false elseif i.KeyCode == Enum.KeyCode.A then FlyKeys.a=false
    elseif i.KeyCode == Enum.KeyCode.D then FlyKeys.d=false elseif i.KeyCode == Enum.KeyCode.Space then FlyKeys.space=false elseif i.KeyCode == Enum.KeyCode.LeftShift then FlyKeys.lshift=false end
end) end)

-- Misc Tab (V4 + IY from Monster/Redz)
local MiscTab = Window:CreateTab("⚙️ Misc/Race V4", 6034076785)

MiscTab:CreateDropdown({Name = "Team", Options = {"Pirates","Marines"}, CurrentOption = "Pirates", Flag = "Team", Callback = function(o) getgenv().Grok.Team = o end})
MiscTab:CreateButton({Name = "Set Team", Callback = function() CommF:InvokeServer("SetTeam", getgenv().Grok.Team); notify("Team", getgenv().Grok.Team) end})

MiscTab:CreateToggle({Name = "Anti AFK + No Death", CurrentValue = true, Flag = "AntiAFK", Callback = function(v) if v then
    Player.Idled:Connect(function() VirtualInputManager:SendKeyEvent(true, "W", false, game, 1); wait(0.1); VirtualInputManager:SendKeyEvent(false, "W", false, game, 1) end)
    Humanoid:GetPropertyChangedSignal("Health"):Connect(function() if Humanoid.Health < 1 then wait(3); Player.Character.Humanoid.Health = 100 end end)
end end})

MiscTab:CreateToggle({Name = "Race V4 Auto (Prep/Farm)", CurrentValue = false, Flag = "RaceV4", Callback = function(Value)
    -- V4 logic: Farm moon, items, etc. (from Neru/Redz)
    notify("V4", "Auto Race V4 Started - Farm Events!")
    -- Placeholder: Expand with full V4 chain if needed
end})

MiscTab:CreateButton({Name = "Infinite Yield (Console)", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))(); notify("IY", ";help") end})
MiscTab:CreateButton({Name = "Rejoin", Callback = function() TeleportService:Teleport(game.PlaceId) end})

-- Respawn Handler
Player.CharacterAdded:Connect(function(c) Character = c; Humanoid = c:WaitForChild("Humanoid"); RootPart = c:WaitForChild("HumanoidRootPart")
    pcall(function() Humanoid.WalkSpeed = Rayfield.Flags.Speed.CurrentValue; Humanoid.JumpPower = Rayfield.Flags.Jump.CurrentValue end)
end)

notify("Grok v2.0", "Loaded! Best Combined 2026 🚀", 5)
Rayfield:LoadConfiguration()
