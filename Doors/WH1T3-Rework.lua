function spawn()

local TS = game:GetService("TweenService")
local timey = TweenInfo.new(2)
local jen = Instance.new("ColorCorrectionEffect")
jen.Parent = game.Lighting
jen.Brightness = 0.05
jen.Contrast = 0
jen.Name = "Jen"
jen.Enabled = true
jen.TintColor = Color3.fromRGB(255, 255, 255)
jen.Saturation = 0
local goal = {}
goal.Contrast = 1
goal.Saturation = 1
goal.TintColor = Color3.fromRGB(255, 0, 0)
local tw = TS:Create(jen, timey, goal)
tw:Play()
wait(2)
local goal2 = {}
goal2.Contrast = 0
goal2.Saturation = 0
goal2.TintColor = Color3.fromRGB(255, 255, 255)
goal2.Brightness = 0
local tw2 = TS:Create(jen, timey, goal2)
tw2:Play()
wait(4)
jen:Destroy()
end

local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors%20Entity%20Spawner/Source.lua"))()
-- Create entity
local entityTable = Spawner.createEntity({
    CustomName = "WH1T3", -- Custom name of your entity
    Model = "https://github.com/PABMAXICHAC/doors-monsters-models/blob/main/white_RW.rbxm?raw=true", -- Can be GitHub file or rbxassetid
    Speed = 500, -- Percentage, 100 = default Rush speed
    DelayTime = 6.5, -- Time before starting cycles (seconds)
    HeightOffset = 0,
    CanKill = true,
    KillRange = 50,
    BackwardsMovement = false,
    BreakLights = true,
    FlickerLights = {
        false, -- Enabled/Disabled
        1, -- Time (seconds)
    },
    Cycles = {
        Min = 2,
        Max = 2,
        WaitTime = 0,
    },
    CamShake = {
        true, -- Enabled/Disabled
        {10.5, 30, 1.1, 5}, -- Shake values (don't change if you don't know)
        100, -- Shake start distance (from Entity to you)
    },
    Jumpscare = {
        true, -- Enabled/Disabled
        {
            Image1 = "rbxassetid://11678966779", -- Image1 url
            Image2 = "rbxassetid://11678966779", -- Image2 url
            Shake = true,
            Sound1 = {
                5263560896, -- SoundId
                { Volume = 0.5 }, -- Sound properties
				{ PlaybackSpeed = 0.5 },
            },
            Sound2 = {
                5263560896, -- SoundId
                { Volume = 0.5 }, -- Sound properties
				{ PlaybackSpeed = 0.5 },
            },
            Flashing = {
                true, -- Enabled/Disabled
                Color3.fromRGB(0, 0, 255), -- Color
            },
            Tease = {
                false, -- Enabled/Disabled
                Min = 1,
                Max = 3,
            },
        },
    },
    CustomDialog = {"H̷̡̡̧̻̼̺̖̫̰̥͚̳͎̣͓͕̼̜̆͐ͅ0̷͇̦̬̟̱̣̠̼̻̱̩̲͇̥̪̙͎̩̈́̌́̈́̓̀̿̍͜Ẃ̵̛̛̏͑̔̏̿͊͐̆̋̈͐̐͘͜"}, -- Custom death message
})


-----[[  Debug -=- Advanced  ]]-----
entityTable.Debug.OnEntitySpawned = function()
  --  print("Entity has spawned:", entityTable)
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://"..131489490
	sound.Looped = false
	sound.Parent = workspace
	sound.Volume = 3.1
	sound:Play()
	loadstring(game:HttpGet("https://pastebin.com/raw/9nJDJFgu"))()
	spawn()
end

entityTable.Debug.OnEntityDespawned = function()
    --print("Entity has despawned:", entityTable)
if game.Players.LocalPlayer.Character.Humanoid.Health == 1 or game.Players.LocalPlayer.Character.Humanoid.Health >= 1 then
loadstring(game:HttpGet("https://github.com/PABMAXICHAC/doors-monsters-scripts/raw/main/achievement_survive_wh1t3.lua"))()
end
loadstring(game:HttpGet("https://pastebin.com/raw/G2eHuVJi"))()
end

entityTable.Debug.OnEntityStartMoving = function()
  --  print("Entity has started moving:", entityTable)
end

entityTable.Debug.OnEntityFinishedRebound = function()
--    print("Entity has finished rebound:", entityTable)
end

entityTable.Debug.OnEntityEnteredRoom = function(room)
    --print("Entity:", entityTable, "has entered room:", room)
end

entityTable.Debug.OnLookAtEntity = function()
 --   print("Player has looked at entity:", entityTable)
    if game.Players.LocalPlayer.Character:FindFirstChild("Crucifix") and (game.Players.LocalPlayer.Character.Head.Position - workspace.WH1T3.whiteyNew.Position).Magnitude < 53 then
    workspace.WH1T3:SetAttribute("NoAI",true)
local tsa = game:GetService("TweenService")
--entityModel:SetAttribute("NoAI", true)
local cruxy = game.Players.LocalPlayer.Character.Crucifix.Handle:Clone()
game.Players.LocalPlayer.Character.Crucifix:Destroy()
cruxy.Parent = game.Workspace
cruxy.Name = "cruxy"
cruxy.Anchored = true
cruxy.Color = Color3.fromRGB(86, 86, 255)
cruxy.Material = Enum.Material.Neon
local cruxeffect = tsa:Create(cruxy, TweenInfo.new(5), {Transparency = 1})
cruxeffect:Play()
game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Unused.Music.Music_Stress.Volume = 0
game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Unused.Music.Music_Stress.Playing = true
game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Unused.Music.Music_Stress.TimePosition = 0
local brbrrbrb = tsa:Create(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Unused.Music.Music_Stress, TweenInfo.new(4), {Volume = 1})
brbrrbrb:Play()
	local SelfModulesa = {
    DefaultConfig = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors%20Entity%20Spawner/DefaultConfig.lua"))(),
    Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))(),
}
local EntityConnections = {}
			-- Crucifix (Repentance)
local ModuleScriptsre = game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game


require(ModuleScriptsre).camShaker:ShakeOnce(200, 5, 0.1, 0.15)
				local Repent = SelfModulesa.Functions.LoadCustomInstance("https://github.com/PABMAXICHAC/doors-monsters-models/blob/main/pentafix.rbxm?raw=true")
                Repent.Parent = game.Workspace
                local white = game.Workspace.WH1T3
				if typeof(Repent) == "Instance" and Repent.ClassName == "Model" then
                local plrpos = white.whiteyNew.CFrame.Position
                local plrpos2 = plrpos - Vector3.new(0, entityTable.Config.HeightOffset, 0)
                local plrpos3 = plrpos2 - Vector3.new(0, 3, 0)
                
Repent:MoveTo(plrpos3)
local sexye = game.Workspace.WH1T3:Clone()
sexye.Parent = game.Workspace
sexye.Name = "Wh1t3Clone"
Repent.Entity.CFrame = sexye.whiteyNew.CFrame
white:Destroy()
-- cool color
local drcolor = Color3.fromRGB(0, 0, 255)
local darkred = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.new(0, 0, 1)),
            ColorSequenceKeypoint.new(1, Color3.new(0, 0, 1))
        })
-- should recolor?
local rc = true
if rc == true then
-- here it recolors
for _, v in next, Repent:GetDescendants() do
    if v.ClassName == "Beam" then
    v.Color = darkred
    end
end
-- recolor part 2!!!
Repent.Circle.Lines.Color = darkred
Repent.Circle.Spark.Color = darkred
end
--
local goa = {}
goa.Position = sexye.whiteyNew.CFrame.Position + Vector3.new(0, 3, 0)
local goe = {}
goe.Position = sexye.whiteyNew.CFrame.Position - Vector3.new(0, 18, 0)
local bra = tsa:Create(sexye.whiteyNew, TweenInfo.new(2), goa)
local bre = tsa:Create(Repent.Entity, TweenInfo.new(2), goa)
bra:Play()
bre:Play()
wait(2)
for _, v in next, sexye.whiteyNew:GetDescendants() do
    if v.ClassName == "Sound" then
    local goaly = {}
    goaly.Volume = 0
    local brbr = tsa:Create(v, TweenInfo.new(3), goaly)
    brbr:Play()
    end
end

local bra1 = tsa:Create(sexye.whiteyNew, TweenInfo.new(3), goe)
local bre1 = tsa:Create(Repent.Entity, TweenInfo.new(3), goe)
bra1:Play()
bre1:Play()
wait(4)
sexye:Destroy()
cruxy:Destroy()
Repent:Destroy()
local Achievements = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()

-- Creates and displays your custom achievement
Achievements.Get({
    Title = "Who kills who now",
    Desc = "You wont crash my game today.",
    Reason = "Used Crucifix on ''WH1T3''",
    Image = "rbxassetid://11678973001",
})
local funnysong = game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Unused.Music.Music_Stress
local asa = tsa:Create(funnysong, TweenInfo.new(10), {Volume = 0})
asa:Play()
wait(10)
game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Unused.Music.Music_Stress.Playing = false
end
end
  --  local FPS = 60
--    local clock = tick()
--        while clock + 1 / FPS > tick() do end
--    wait()
 --   clock = tick()
end

entityTable.Debug.OnDeath = function()
    warn("P̴̖̺̙͑̍l̸̦̘̔̈́a̸̲̰̯̙͋͒̋y̷͚͖͑͋e̴͎̤̺̗͊ȓ̴̳͙̱̒̔ ̵͈̈́͜h̶͓́͐͂̇a̶̛̞̪̯̫s̸̥͝ ̷̣̲̔̆̓d̵̡̖̈͋̊ͅí̶͚͝e̴͎̅̆̇d̸̮͍͊̔̓͝.̵̢͎̹̾̃")
    wait(13)
    game:Shutdown()
end
------------------------------------


-- Run the created entity
Spawner.runEntity(entityTable)
