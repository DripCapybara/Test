
--	firesignal(game.ReplicatedStorage.EntityInfo.UseEventModule.OnClientEvent, "flicker", game.ReplicatedStorage.GameData.LatestRoom.Value, 10)
wait(12)
--
local urla = "https://github.com/PABMAXICHAC/doors-monsters-models/blob/main/JumpscareNEW_1.mp3?raw=true"
if syn then
writefile("boops_js2.mp3", game:HttpGet(urla))
local a = Instance.new("Sound")
a.Parent = game.Workspace
a.SoundId = getsynasset("boops_js2.mp3")
a.Volume = 1
a.Name = "boops_js2mp3"
a.Looped = true
else
writefile("boops_js2mp3", game:HttpGet(urla))
local a = Instance.new("Sound")
a.Parent = game.Workspace
a.SoundId = getcustomasset("boops_js2mp3")
a.Volume = 1
a.Name = "boops_js2mp3"
a.Looped = false
end
--
--
local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors%20Entity%20Spawner/Source.lua"))()


-- Create entity
local entityTable = Spawner.createEntity({
    CustomName = "Boppies", -- Custom name of your entity
    Model = "https://github.com/BethJenniferMiller/doors-entity/blob/main/Doors/Models/Boppies.rbxm?raw=true", -- Can be GitHub file or rbxassetid
    Speed = 700, -- Percentage, 100 = default Rush speed
    DelayTime = 2, -- Time before starting cycles (seconds)
    HeightOffset = 0,
    CanKill = true,
    KillRange = 50,
    BackwardsMovement = false,
    BreakLights = true,
    FlickerLights = {
        true, -- Enabled/Disabled
        1, -- Time (seconds)
    },
    Cycles = {
        Min = 1,
        Max = 3,
        WaitTime = 0.5,
    },
    CamShake = {
        true, -- Enabled/Disabled
        {3.5, 20, 0.1, 1}, -- Shake values (don't change if you don't know)
        100, -- Shake start distance (from Entity to you)
    },
    Jumpscare = {
        true, -- Enabled/Disabled
        {
            Image1 = "rbxassetid://12093166540", -- Image1 url
            Image2 = "rbxassetid://12093393126", -- Image2 url
            Shake = true,
            Sound1 = {
                game.Workspace.boops_js2mp3.SoundId, -- SoundId
                { Volume = 0.5 }, -- Sound properties
            },
            Sound2 = {
                game.Workspace.boops_js2mp3.SoundId, -- SoundId
                { Volume = 0.5 }, -- Sound properties
            },
            Flashing = {
                true, -- Enabled/Disabled
                Color3.fromRGB(217, 0, 0), -- Color
            },
            Tease = {
                false, -- Enabled/Disabled
                Min = 1,
                Max = 2,
            },
        },
    },
    CustomDialog = {"I̷̢͡I̸̢҇I̷͢͠I̸̢͞I̷͜͞I̶̢͝I̷͢͠I̸͜͠I̷̕͜I҉̡͑͞I҈̡͐͝I̷̡̕"}, -- Custom death message
})


-----[[  Debug -=- Advanced  ]]-----
entityTable.Debug.OnEntitySpawned = function()
    print("Entity has spawned:", entityTable)
    warn("Fear Boppies.")
    game.Workspace.Boppies.RushNew.Attachment.ParticleEmitter.Rate = 15
------------- SOUNDS DO NOT TOUCH
game.Workspace.Boppies.RushNew.Footsteps.Playing = false
game.Workspace.Boppies.RushNew.PlaySound.Playing = false
--
local url = "https://github.com/PABMAXICHAC/doors-monsters-models/blob/main/Boppies2077.mp3?raw=true"

if syn then
writefile("boops_js1.mp3", game:HttpGet(url))
local b = Instance.new("Sound")
b.Parent = game.Workspace.Boppies.RushNew
b.SoundId = getsynasset("boops_js1.mp3")
b.Volume = 1
b.Name = "boops_js1.mp3"
b.Looped = true
b.Playing = true
else
writefile("boops_js1.mp3", game:HttpGet(url))
local b = Instance.new("Sound")
b.Parent = game.Workspace.Boppies.RushNew
b.SoundId = getcustomasset("boops_js1.mp3")
b.Volume = 1
b.Name = "boops_js1.mp3"
b.Looped = true
b.Playing = true
end
----------------------------------
end

entityTable.Debug.OnEntityDespawned = function()
    print("Entity has despawned:", entityTable)
    game.Workspace.boops_js2mp3:Destroy()
end

entityTable.Debug.OnEntityStartMoving = function()
    print("Entity has started moving:", entityTable)
end

entityTable.Debug.OnEntityFinishedRebound = function()

end

entityTable.Debug.OnEntityEnteredRoom = function(room)
    print("Entity:", entityTable, "has entered room:", room)
end

entityTable.Debug.OnLookAtEntity = function()
    print("Player has looked at entity:", entityTable)
end

entityTable.Debug.OnDeath = function()
    warn("Player has died.")
end
------------------------------------


-- Run the created entity
Spawner.runEntity(entityTable)
	
