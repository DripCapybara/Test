--// Made By DripCapybara

local module = {}

local Plr = game.Players.LocalPlayer

local ModuleScripts = {
   MainGame = require(Plr.PlayerGui.MainUI.Initiator.Main_Game),
   Events = require(game:GetService("ReplicatedStorage").ClientModules.Module_Events),
}

--// Area function
function module.AreaLocation(Area)
   ModuleScripts.MainGame.titlelocation(Area)
end

--// Caption support for non-supporting firesignal executors
function module.Caption(Msg,Dur)
   ModuleScripts.MainGame.caption(Msg,true,Dur)
end

--// Spawns Glitch
function module.InitGlitch()
   require(game:GetService("ReplicatedStorage").ClientModules.EntityModules.Glitch).stuff(ModuleScripts.MainGame)
end

--// Light Flicker for non-supporting firesignal executors
function module.flickerLights(room, dur)
   ModuleScripts.Events.flicker(room,dur)
end

--// Get Git Image
function module.GetGitImage(Path,AssetName)
   local url=Path
	
   if not isfile(AssetName..".png") then
      writefile(AssetName..".png", game:HttpGet(url))
   end
	
   return (getcustomasset or getsynasset)(AssetName..".png")
end

--// Get Git Sound
function module.GetGitSound(Path,AssetName)
    local url=Path

    if not isfile(AssetName..".mp3") then 
        writefile(AssetName..".mp3", game:HttpGet(url)) 
    end

    local sound=Instance.new("Sound")
    sound.SoundId=(getcustomasset or getsynasset)(AssetName..".mp3")
    return sound 
end

--// Get Git Asset
function module.GetAsset(Path,AssetName)
    --// Get Type by matching if its a mp3 or not.
    local Type = string.match(Path,".mp3") and "Sound" or "Image"
       
    --// If type is a sound.
    if Type == "Sound" then
       return GetGitSound(Path,AssetName)
    end
    --// If type is a Image
    if Type == "Image" then
        return GetGitImage(Path,AssetName)
    end
    --// If type wasnt detected
    if Type == nil then
       --// If type is a roblox asset
        if string.match(Path,"rbxassetid://") then
           return game:GetObjects(Path)[1]
        end
    end
end

-- Main
for name, func in module do
    if typeof(func) == "function" then
        getgenv()[name] = func
    end
end

return module
