local a  = {}

a.Init = function(Config)
local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

local entity = spawner.Create({
	Entity = {
		Name = "Ambush",
		Asset = "100877991864244",
		HeightOffset = 1
	},
	Lights = {
		Flicker = {
			Enabled = false,
			Duration = 0.1
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled =true
	},
	CameraShake = {
		Enabled = true,
		Range = 100,
		Values = {10, 20, 0.5, 2} -- Magnitude, Roughness, FadeIn, FadeOut
	},
	Movement = {
		Speed = 175,
		Delay = 5,
		Reversed = false
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush", -- "Blitz"
		Min = 2,
		Max = 6,
		Delay = 2
	},
	Damage = {
		Enabled = Config.CanKill,
		Range = 50,
		Amount = 200
	},
	Crucifixion = {
		Enabled = true,
		Range = 50,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding", -- "Curious"
		Hints = {"You died to Ambush...", "It is a tricky one.", "Instead of coming back once it comes back multiple times..", "You can tell Ambush spawns because of his scream.", "Better luck next time!"},
		Cause = "Ambush"
	}
})

entity:SetCallback("OnDamagePlayer", function(newHealth)
	if newHealth == 0 then
		require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Jumpscares.Ambush)(require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game))
	end
end)

entity:Run()
end

return a
