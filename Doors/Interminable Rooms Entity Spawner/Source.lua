--Services

local Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))()

local rooms = workspace.Rooms
local spawnpart = workspace.ENTITYSPAWN
local MonsterMove2Parts = workspace.MonsterMove2Parts

local CoreGui = game.CoreGui
local TS = game.TweenService
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Heartbeat = RunService.Heartbeat
local RenderStepped = RunService.RenderStepped

--Variables

local Player = Players.LocalPlayer
local Character = Player.Character
local killed = false

local Camera = workspace.CurrentCamera

local lastRoom = nil

local FindPartOnRayWithIgnoreList = workspace.FindPartOnRayWithIgnoreList

local ss = nil
local ds = nil

local Spawner = {}
Spawner.DefaultConfig = {
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

--Functions

function KillPlayer()
Character:FindFirstChildOfClass("Humanoid").Health = 0
end

function TripPlayer()
Character.HumanoidRootPart.Anchored = true
local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://10096088747"
animTrack = Character:FindFirstChildOfClass('Humanoid'):LoadAnimation(animation)
animTrack:Play()
task.wait(1.5)
Character.HumanoidRootPart.Anchored = false
end

function GetLastRoomNumber()
return workspace.Values.RoomNumber.Value
end

function GetLastRoomModel()
return workspace.Values.currentroom.Value
end

function GetGitSound(GithubSnd,SoundName)
local url=GithubSnd
if not isfile(SoundName..".mp3") then 
writefile(SoundName..".mp3", game:HttpGet(url)) 
end
local sound=Instance.new("Sound")
sound.SoundId=(getcustomasset or getsynasset)(SoundName..".mp3")
return sound end

function canSeeTarget(entity,target,size)
if entity ~= nil then
					if killed == true then
						return
					end
					local origin = entity.Position
					local direction = (target.HumanoidRootPart.Position - entity.Position).unit * size
					local ray = Ray.new(origin, direction)

					local hit, pos = workspace:FindPartOnRay(ray, entity)


					if hit then
						if hit:IsDescendantOf(target) then
							return true
						end
					else
						return false
					end
				end
end				
local function IsVisible(part)
	local vec, found=workspace.CurrentCamera:WorldToViewportPoint(part.Position)
	local onscreen = found and vec.Z > 0
	local cfg = RaycastParams.new()
	cfg.FilterType = Enum.RaycastFilterType.Blacklist
	cfg.FilterDescendantsInstances = {part}

	local cast = workspace:Raycast(part.Position, (game.Players.LocalPlayer.Character.UpperTorso.Position - part.Position), cfg)
	if onscreen then
		if cast and (cast and cast.Instance).Parent==game.Players.LocalPlayer.Character then
			return true
		end
	end
end
		
function GetTime(Distance, Speed)
local Time = Distance / Speed
return Time
end

function loadSound(soundData)
    local sound = Instance.new("Sound")
    local soundId = tostring(soundData[1])
    local properties = soundData[2]

    for i, v in next, properties do
        if i ~= "SoundId" and i ~= "Parent" then
            sound[i] = v
        end
    end

    if soundId:find("rbxasset://") then -- Custom audio
        sound.SoundId = soundId
    else
    
        local numberId = soundId:gsub("%D", "")

        sound.SoundId = "rbxassetid://".. numberId
    end
    
    sound.Parent = workspace

    return sound
end

--Spawning

Spawner.CreateEntity = function(config)
--Config Fix
for i, v in next, Spawner.DefaultConfig do
        if config[i] == nil then
            config[i] = v
        end
    end
    
config.Speed = 60/100*config.Speed


--Model
local entityModel = LoadCustomInstance(config.EntityModel)

if typeof(entityModel) == "Instance" and entityModel.ClassName == "Model" then
entityModel.PrimaryPart = entityModel:FindFirstChildOfClass("Part")

if entityModel.PrimaryPart and entityModel:FindFirstChildOfClass("Part") then
entityModel.PrimaryPart.Anchored = true

if config.Collidable then
entityModel.PrimaryPart.CanCollide = config.Collidable
else
entityModel.PrimaryPart.CanCollide = false
end

if config.EntityName then
entityModel.Name = config.EntityName
end

entityModel:SetAttribute("IsCustomEntity",true)
entityModel:SetAttribute("AI",true)

local entityTable = {
	Model = entityModel,
	Config = config,
	Functions = {
		OnEntitySpawned = function() end,
        OnEntityDespawned = function() end,
        OnEntityStartMoving = function() end,
        OnEntityFinishedRebound = function() end,
        OnEntityEnteredRoom = function() end,
        OnLookAtEntity = function() end,
        OnDeath = function() end,
        OnDestroyed = function() end,
        OnWaypointFinished = function() end
		}
	}

return entityTable

else
error("Could Not Find Any Base Part Inside Of the Entity.")
end

else
error("Entity Model is Invalid.")
end

end


Spawner.SpawnEntity = function(entityTable)
local ss = nil
local ds = nil

local entityModel = entityTable.Model:Clone()
local startPartIndex = entityTable.Config.BackwardsMovement and workspace.Values.currentroom.Value.Door.Door or spawnpart
local startNodeOffset = entityTable.Config.BackwardsMovement and -100 or 50

entityModel:PivotTo(startPartIndex.CFrame * CFrame.new(0, 0, startNodeOffset) + Vector3.new(0, entityTable.Config.HeightOffset, 0))
entityModel.Parent = workspace.Entities

if entityTable.Config.Sounds[1] then
if entityTable.Config.Sounds[2] then
ss = loadSound(entityTable.Config.Sounds[2])
end
if entityTable.Config.Sounds[3] then
ds = loadSound(entityTable.Config.Sounds[3])
end
end

if ss then
ss:Play()
end

task.spawn(entityTable.Functions.OnEntitySpawned)

    -- Movement

    task.wait(entityTable.Config.MoveDelay)

local enteredRooms = {}

    movementTick = RunService.Stepped:Connect(function()
        if entityModel.Parent and entityModel:GetAttribute("AI") and entityModel ~= nil and entityModel and entityModel.PrimaryPart then
            local entityPos = entityModel.PrimaryPart.Position
            local floorRay = FindPartOnRayWithIgnoreList(workspace, Ray.new(entityPos, Vector3.new(0, -10, 0)), {entityModel, Character})

            if floorRay ~= nil and floorRay.Name == "Floor" then
                for _, room in next, rooms:GetChildren() do
                    if floorRay:IsDescendantOf(room) and not table.find(enteredRooms, room) then
                        enteredRooms[#enteredRooms + 1] = room
                        task.spawn(entityTable.Functions.OnEntityEnteredRoom, room)

                        break
                    end
                end
            end
            
             if canSeeTarget(entityModel.PrimaryPart,Character,entityTable.Config.KillRange) then
                -- Look at entity
                
                if IsVisible(entityModel.PrimaryPart) then
                    task.spawn(entityTable.Functions.OnLookAtEntity)
                end

                -- Kill player
                
                if entityTable.Config.CanKill and not killed and not Character:GetAttribute("Invincible") and not Character.PrimaryPart.Hidden.Value == true and (Character.HumanoidRootPart.Position - entityModel.PrimaryPart.Position).Magnitude <= entityTable.Config.KillRange then
                        
                    task.spawn(function()
                    killed = true
                       
                        -- Mute entity
                        
                        -- Jumpscare
                        
                        if entityTable.Config.Jumpscare[1] then
                            Spawner.runJumpscare(entityTable.Config.Jumpscare)
                        end

                        -- Death handling
                        
                        task.spawn(entityTable.Functions.OnDeath)
                        --Hum.Health = 0
                       
                    end)
                end
            end
        end
    end)
    
    task.spawn(entityTable.Functions.OnEntityStartMoving)
    
    local cyclesConfig = entityTable.Config.Cycles

    if entityTable.Config.BackwardsMovement then
        for v = #MonsterMove2Parts:GetChildren(), 1, -1 do
             if MonsterMove2Parts:FindFirstChild(v) then
                local waypoint = MonsterMove2Parts[v]
					local Distance = (entityModel.PrimaryPart.Position - waypoint.Position).Magnitude -- Get the distance between the current position and the next node
					local fakejays = game.TweenService:Create(entityModel.PrimaryPart,TweenInfo.new(GetTime(Distance, entityTable.Config.Speed), Enum.EasingStyle.Linear,Enum.EasingDirection.Out, 0,false,0),{CFrame = waypoint.CFrame + Vector3.new(0,entityTable.Config.HeightOffset,0)})
					fakejays:Play()
					task.spawn(entityTable.Functions.OnWaypointFinished)
					fakejays.Completed:Wait()
			   end
            end
    end

    for cycle = 1, math.max(math.random(cyclesConfig.Min, cyclesConfig.Max), 1) do
        
			for v = 1, #MonsterMove2Parts:GetChildren() do
				if MonsterMove2Parts:FindFirstChild(v) then
					local waypoint = MonsterMove2Parts[v]
					local Distance = (entityModel.PrimaryPart.Position - waypoint.Position).Magnitude -- Get the distance between the current position and the next node
					local fakejays = game.TweenService:Create(entityModel.PrimaryPart,TweenInfo.new(GetTime(Distance, entityTable.Config.Speed), Enum.EasingStyle.Linear,Enum.EasingDirection.Out, 0,false,0),{CFrame = waypoint.CFrame + Vector3.new(0,entityTable.Config.HeightOffset,0)})
					fakejays:Play()
					task.spawn(entityTable.Functions.OnWaypointFinished)
					fakejays.Completed:Wait()
					else
					local Move2PartNew = Instance.new("Part",MonsterMove2Parts)
Move2PartNew.Name = v
Move2PartNew.BottomSurface = Enum.SurfaceType.Smooth
Move2PartNew.CFrame = CFrame.new(0, 1, -80.375, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Move2PartNew.CanCollide = false
Move2PartNew.CanQuery = false
Move2PartNew.CanTouch = false
Move2PartNew.EnableFluidForces = false
Move2PartNew.Size = Vector3.new(4, 1, 2)
Move2PartNew.TopSurface = Enum.SurfaceType.Smooth
Move2PartNew.Transparency = 1


				end
			end
			
	
			repeat wait() until workspace.Values.currentroom.Value:FindFirstChild("Door")
			repeat wait() until workspace.Values.currentroom.Value:FindFirstChild("Door"):FindFirstChild("Door")
			local waypoint = workspace.Values.currentroom.Value.Door.Door
			local Distance = (entityModel.PrimaryPart.Position - waypoint.Position).Magnitude -- Get the distance between the current position and the next node
		    local fakejays = game.TweenService:Create(entityModel.PrimaryPart,TweenInfo.new(GetTime(Distance, entityTable.Config.Speed), Enum.EasingStyle.Linear,Enum.EasingDirection.Out, 0,false,0),{CFrame = waypoint.CFrame + Vector3.new(0,entityTable.Config.HeightOffset-1,0)})
			fakejays:Play()
			task.spawn(entityTable.Functions.OnWaypointFinished)
			fakejays.Completed:Wait()

        if cyclesConfig.Max > 1 then
            for v = #MonsterMove2Parts:GetChildren(), 1, -1 do
               if MonsterMove2Parts:FindFirstChild(v) then
                local waypoint = MonsterMove2Parts[v]
					local Distance = (entityModel.PrimaryPart.Position - waypoint.Position).Magnitude -- Get the distance between the current position and the next node
					local fakejays = game.TweenService:Create(entityModel.PrimaryPart,TweenInfo.new(GetTime(Distance, entityTable.Config.Speed), Enum.EasingStyle.Linear,Enum.EasingDirection.Out, 0,false,0),{CFrame = waypoint.CFrame + Vector3.new(0,entityTable.Config.HeightOffset,0)})
					fakejays:Play()
					task.spawn(entityTable.Functions.OnWaypointFinished)
					fakejays.Completed:Wait()
				end
            end
        end

        -- Rebound finished

        task.spawn(entityTable.Functions.OnEntityFinishedRebound)
        entityTable.Config.Speed = entityTable.Config.Speed+entityTable.Config.Cycles.SpeedIncrease
        
        if cycle < cyclesConfig.Max then
            task.wait(cyclesConfig.WaitTime)
        end
    end
    
    if entityModel:GetAttribute("AI") then
        
        wait(0.2)
        
        task.spawn(entityTable.Functions.OnEntityDespawned)
        task.wait(entityTable.Config.TimeBeforeDestruction)
        if ds ~= nil then
        ds:Play()
        end
        entityModel:Destroy()
        task.spawn(entityTable.Functions.OnDestroyed)
    end
        
end


Spawner.runJumpscare = function(config)
    -- Variables
    local image1 = LoadCustomAsset(config[2].Image1)
    local image2 = LoadCustomAsset(config[2].Image2)
    local sound1, sound2, sound3 = nil, nil, nil

    if config[2].Sound1 then
        sound1 = loadSound(config[2].Sound1)
    end

    if config[2].Sound2 then
        sound2 = loadSound(config[2].Sound2)
    end
    
    if config[2].Ambience then
        sound3 = loadSound(config[2].Ambience)
    end
    
    if sound3 then
    sound3:Play()
    end

    -- UI Construction

    local JumpscareGui = Instance.new("ScreenGui")
    local Background = Instance.new("Frame")
    local Face = Instance.new("ImageLabel")

    JumpscareGui.Name = "JumpscareGui"
    JumpscareGui.IgnoreGuiInset = true
    JumpscareGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Background.Name = "Background"
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BorderSizePixel = 0
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.ZIndex = 999

    Face.Name = "Face"
    Face.AnchorPoint = Vector2.new(0.5, 0.5)
    Face.BackgroundTransparency = 1
    Face.Position = UDim2.new(0.5, 0, 0.5, 0)
    Face.ResampleMode = Enum.ResamplerMode.Pixelated
    Face.Size = UDim2.new(0, 150, 0, 150)
    Face.Image = image1

    Face.Parent = Background
    Background.Parent = JumpscareGui
    JumpscareGui.Parent = CoreGui
    
    -- Tease

    local teaseConfig = config[2].Tease
    local absHeight = JumpscareGui.AbsoluteSize.Y
    local minTeaseSize = absHeight / 5
    local maxTeaseSize = absHeight / 2.5

    
    if teaseConfig[1] then
        local teaseAmount = math.random(teaseConfig.Min, teaseConfig.Max)

        sound1:Play()
        
        for _ = teaseConfig.Min, teaseAmount do
            task.wait(math.random(100, 200) / 100)

            local growFactor = (maxTeaseSize - minTeaseSize) / teaseAmount
            Face.Size = UDim2.new(0, Face.AbsoluteSize.X + growFactor, 0, Face.AbsoluteSize.Y + growFactor)
        end

        task.wait(math.random(100, 200) / 100)
    end
    
    -- Flashing

    if config[2].Flashing[1] then
        task.spawn(function()
            while JumpscareGui.Parent do
                Background.BackgroundColor3 = config[2].Flashing[2]
                task.wait(math.random(25, 100) / 1000)
                Background.BackgroundColor3 = Color3.new(0, 0, 0)
                task.wait(math.random(25, 100) / 1000)
            end
        end)
    end
    
    -- Shaking

    if config[2].Shake then
        task.spawn(function()
            local origin = Face.Position

            while JumpscareGui.Parent do
                Face.Position = origin + UDim2.new(0, math.random(-10, 10), 0, math.random(-10, 10))
                Face.Rotation = math.random(-5, 5)

                task.wait()
            end
        end)
        
    end

    -- Jumpscare
    
    Face.Image = image2
    Face.Size = UDim2.new(0, maxTeaseSize, 0, maxTeaseSize)
    sound2:Play()
    
    TS:Create(Face, TweenInfo.new(0.75), {Size = UDim2.new(0, absHeight * 3, 0,  absHeight * 3), ImageTransparency = 0.5}):Play()
    task.wait(0.75)
    JumpscareGui:Destroy()
    
    if sound1 then
        sound1:Destroy()
    end
    
    if sound2 then
        sound2:Destroy()
    end
    
    if sound3 then
        sound3:Destroy()
    end
end

return Spawner
