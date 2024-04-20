local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/DripCapybara/Test/main/Doors/Interminable%20Rooms%20Entity%20Spawner/Source.lua"))()

local Entity = Spawner.CreateEntity({
	EntityName = "A-60",
	EntityModel = "rbxassetid://13631038435",
	Speed = 500,
	KillRange = 50,
	HeightOffset = 1.6,
	MoveDelay = 2.5,
	TimeBeforeDestruction = 0,
	Collidable = true,
	CanKill = true,
	BackwardsMovement = false,
	Sounds = {
	    false, --Enabled
	    Spawn = nil, --Entity Spawn Sound
	    Despawn = nil, --Entity Despawn Sound		
	},
	Cycles = {
	Min = 1, -- Min Amount of Rebounds
    Max = 1, -- Max Amount of Rebounds
    SpeedIncrease = 0,-- Speed Increased after Rebounding
    WaitTime = 0 -- Time Before Next Rebound
	},
    Jumpscare = {
        false,
        {
            Image1 = "rbxassetid://10483855823", -- Image1 url
            Image2 = "rbxassetid://10483999903", -- Image2 url
            Shake = true,
            Sound1 = {
                10483790459, -- SoundId
                { Volume = 0.5 }, -- Sound properties
            },
            Sound2 = {
                10483837590, -- SoundId
                { Volume = 0.5 }, -- Sound properties
            },
            Ambience = {
            	0,
                { Volume = 0.5}
           },
            Flashing = {
                true, -- Enabled/Disabled
                Color3.fromRGB(255, 255, 255), -- Color
            },
            Tease = {
                true, -- Enabled/Disabled
                Min = 1,
                Max = 3,
            },
        },
    }
  
})

test.Functions.OnEntitySpawned = function()
--    print("Entity has spawned:", test)
end

test.Functions.OnEntityDespawned = function()
--    print("Entity has despawned:", test)
end

test.Functions.OnEntityStartMoving = function()
 --   print("Entity has started moving:", test)
end

test.Functions.OnEntityFinishedRebound = function()
--    print("Entity has finished rebound:", test)
end

test.Functions.OnEntityEnteredRoom = function(room)
  --  print("Entity:", test, "has entered room:", room)
end

test.Functions.OnLookAtEntity = function()
--    print("Player has looked at entity:", test)
end

test.Functions.OnDeath = function()
 --   warn("Player has died.")
end

test.Functions.OnDestroyed = function()
 --   print("Entity Has Been Destroyed:", test)
end

test.Functions.OnWaypointFinished = function()
--     print("Entity has Finished a Node:", test)
end

Spawner.SpawnEntity(test) 
