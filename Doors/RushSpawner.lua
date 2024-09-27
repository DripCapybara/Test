local a = {}

a.Init = function(Config)
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()
local entity = spawner.Create({
	Entity = {
		Name = "RushMoving",
		Asset = "https://github.com/RegularVynixu/Utilities/raw/main/Doors/Entity%20Spawner/Assets/Entities/Rush.rbxm",
		HeightOffset = 0
	},
	Lights = {
		Flicker = {
			Enabled = true,
			Duration = 2
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = (game.ReplicatedStorage.GameData.Floor.Value == "Mines" and true or false)
	},
	CameraShake = {
		Enabled = true,
		Range = 100,
		Values = {1.5, 20, 0.1, 1} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 100,
		Delay = 2,
		Reversed = false
	},
	Rebounding = {
		Enabled = false,
		Type = "Ambush", -- "Blitz"
		Min = 1,
		Max = 1,
		Delay = 2
	},
	Damage = {
		Enabled = Config.CanKill,
		Range = 40,
		Amount = 125
	},
	Crucifixion = {
		Enabled = true,
		Range = 40,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding", -- "Curious"
		Hints = {"You died to Rush...", "You will know its coming once lights flicker.", "Take cautions next time!"},
		Cause = "Rush"
	}
})
entity:SetCallback("OnDamagePlayer", function(newHealth)
	if newHealth == 0 then
		require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Jumpscares.Rush)(require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game))
	end
end)
entity:Run()
end

return a
