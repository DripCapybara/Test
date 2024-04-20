return {
	EntityName = "RushMoving",
	EntityModel = "https://github.com/RegularVynixu/Utilities/blob/main/Doors%20Entity%20Spawner/Models/Rush.rbxm?raw=true",
	Speed = 60,
	KillRange = 50,
	HeightOffset = 0.5,
	MoveDelay = 2,
	TimeBeforeDestruction = 5,
	Collidable = false,
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
    SpeedIncrease = 0, -- Speed Increased after Rebounding
    WaitTime = 0 -- Time Before Next Rebound
	},
    Jumpscare = {
        false, -- Enabled
        {} -- JS Data
    }
}
