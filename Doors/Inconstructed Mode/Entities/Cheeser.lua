local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Test/main/Doors/Backup/Source.lua"))()


-- Create entity
local entityTable = Spawner.createEntity({
    CustomName = "Cheeser", -- Custom name of your entity
    Model = "rbxassetid://76359429327872", -- Can be GitHub file or rbxassetid
    Speed = 250, -- Percentage, 100 = default Rush speed
    DelayTime = 5, -- Time before starting cycles (seconds)
    HeightOffset = 2,
    CanKill = true,
    KillRange = 50,
    BackwardsMovement = false,
    BreakLights = true,
    FlickerLights = {
        true, -- Enabled/Disabled
        10, -- Time (seconds)
    },
    Cycles = {
        Min = 3,
        Max = 3,
        WaitTime = 2,
    },
    CamShake = {
        true, -- Enabled/Disabled
        {5, 20, 0.1, 4,6,2}, -- Shake values (don't change if you don't know)
        150, -- Shake start distance (from Entity to you)
    },
    Jumpscare = {
        true, -- Enabled/Disabled
        {
            Image1 = "rbxassetid://11858566660", -- Image1 url
            Image2 = "rbxassetid://11858566660", -- Image2 url
            Shake = true,
            Sound1 = {
                5567523008, -- SoundId
                { Volume = 0.5 }, -- Sound properties
            },
            Sound2 = {
                5567523008, -- SoundId
                { Volume = 11 }, -- Sound properties
            },
            Flashing = {
                true, -- Enabled/Disabled
                Color3.fromRGB(255, 255, 0), -- Color
            },
            Tease = {
                false, -- Enabled/Disabled
                Min = 1,
                Max = 3,
            },
        },
    },
    CustomDialog = {"Cheese"}, -- Custom death message
})


-----[[  Debug -=- Advanced  ]]-----
entityTable.Debug.OnEntitySpawned = function()
    
end

entityTable.Debug.OnEntityDespawned = function()
    
end

entityTable.Debug.OnEntityStartMoving = function()
    
end

entityTable.Debug.OnEntityFinishedRebound = function()
    
end

entityTable.Debug.OnEntityEnteredRoom = function(room)
    
end

entityTable.Debug.OnLookAtEntity = function()
    
end

entityTable.Debug.OnDeath = function()
end
------------------------------------


-- Run the created entity
Spawner.runEntity(entityTable)
