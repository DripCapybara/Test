if game:GetService("ReplicatedStorage").GameData.Floor.Value == "Hotel" then
--firesignal(game.ReplicatedStorage.EntityInfo.UseEventModule.OnClientEvent, "flicker", game.ReplicatedStorage.GameData.LatestRoom.Value, 10)
wait(12)
elseif game:GetService("ReplicatedStorage").GameData.Floor.Value == "Rooms" then
local abrt = Instance.new("ColorCorrectionEffect")
abrt.Name = "Smiler Light Flicker"
abrt.Parent = game.Lighting
abrt.Brightness = 0.1
abrt.Contrast = 0.3
abrt.Enabled = false
abrt.Saturation = -0.4
abrt.TintColor = Color3.fromRGB(255, 255, 255)
local val1 = Instance.new("IntValue")
val1.Name = "SmilerVal1"
val1.Parent = game.Players.LocalPlayer
val1.Value = 0
local val2 = Instance.new("IntValue")
val2.Name = "SmilerVal2"
val2.Parent = game.Players.LocalPlayer
val2.Value = 0
game:GetService("ReplicatedStorage").Sounds.BulbCharge:Play()
wait(0.772)
while true do
wait(0.1)
    if val1.Value == 0 then
        abrt.Enabled = true
        game:GetService("ReplicatedStorage").Sounds.BulbZap.PlaybackSpeed = 0.9
        game:GetService("ReplicatedStorage").Sounds.BulbZap:Play()
        val1.Value = val1.Value + 1
        val2.Value = val2.Value + 1
    elseif val1.Value == 1 then
        abrt.Enabled = false
        val1.Value = val1.Value + 1
        if val1.Value == 2 then
            val1.Value = 0
        end
        val2.Value = val2.Value + 1
    end
if val2.Value == 100 then
wait(0.1)
game:GetService("ReplicatedStorage").Sounds.BulbZap.PlaybackSpeed = 1
break
end
end
abrt:Destroy()
val1:Destroy()
val2:Destroy()
end
--loadstring(game:HttpGet("https://pastebin.com/raw/1LZbZBmm"))()


-- smiler sound
local Repents = false
local isDeflecting = false
local camara = workspace.CurrentCamera
local grito = Instance.new("Sound")
grito.SoundId = "rbxassetid://11567506327"
grito.Parent = camara


-- Services

local Players = game:GetService("Players")
local ReSt = game:GetService("ReplicatedStorage")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")
local CG = game:GetService("CoreGui")

-- Variables

local Plr = Players.LocalPlayer
local Char = Plr.Character or Plr.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")
local Camera = workspace.CurrentCamera

local StaticRushSpeed = 60
local StaticRushSpeed = 50
local MinTeaseSize = 150
local MaxTeaseSize = 300

local FindPartOnRayWithIgnoreList = workspace.FindPartOnRayWithIgnoreList
local WorldToViewportPoint = Camera.WorldToViewportPoint

local SelfModules = {
    DefaultConfig = {
    Speed = 100,
    DelayTime = 2,
    HeightOffset = 0,
    CanKill = true,
    KillRange = 50,
    BreakLights = true,
    BackwardsMovement = false,
    FlickerLights = {
        true,
        1
    },
    Cycles = {
        Min = 1,
        Max = 1,
        WaitTime = 2
    },
    CamShake = {
        true,
        {5, 15, 0.1, 1},
        100
    },
    Jumpscare = {
        false,
        {}
    },
    CustomDialog = {},
},
    Functions = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Functions.lua"))(),
}
local ModuleScripts = {
    ModuleEvents = require(ReSt.ClientModules.Module_Events),
    MainGame = require(Plr.PlayerGui.MainUI.Initiator.Main_Game),
}
local EntityConnections = {}

local Spawner = {}

-- Misc Functions

function onCharacterAdded(char)
    Char, Hum = char, char:WaitForChild("Humanoid")
end

function getPlayerRoot()
    return Char:FindFirstChild("HumanoidRootPart") or Char:FindFirstChild("Head")
end

function dragEntity(entityModel, pos, speed)
    local entityConnections = EntityConnections[entityModel]

    if entityConnections.movementNode then
        entityConnections.movementNode:Disconnect()
    end

    entityConnections.movementNode = RS.Stepped:Connect(function(_, step)
        if entityModel.Parent and not entityModel:GetAttribute("NoAI") then
            local rootPos = entityModel.PrimaryPart.Position
            local diff = Vector3.new(pos.X, pos.Y, pos.Z) - rootPos

            if diff.Magnitude > 0.1 then
                entityModel:PivotTo(CFrame.new(rootPos + diff.Unit * math.min(step * speed, diff.Magnitude)))
            else
                entityConnections.movementNode:Disconnect()
            end
        end
    end)

    repeat task.wait() until not entityConnections.movementNode.Connected
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

-- Functions

local function GetGitModel(ModelUrl,ModelName)
				if not isfile(ModelName..".txt") then writefile(ModelName..".txt", game:HttpGet(ModelUrl)) end
				local a=game:GetObjects((getcustomasset or getsynasset)(ModelName..".txt"))[1]
				a.Name=ModelName
				return a
end

Spawner.createEntity = function(config)
    for i, v in next, SelfModules.DefaultConfig do
        if config[i] == nil then
            config[i] = v
        end
    end

    config.Speed = StaticRushSpeed / 100 * config.Speed

    -- Model

    local entityModel = GetGitModel(config.Model,"Smiler_Model")

    if typeof(entityModel) == "Instance" and entityModel.ClassName == "Model" then
        entityModel.PrimaryPart = entityModel.PrimaryPart or entityModel:FindFirstChildWhichIsA("BasePart")
        
        if entityModel.PrimaryPart then
            entityModel.PrimaryPart.Anchored = true
            
            if config.CustomName then
                entityModel.Name = config.CustomName
            end

            entityModel:SetAttribute("IsCustomEntity", true)
            entityModel:SetAttribute("NoAI", false)

            -- EntityTable

            local entityTable = {
                Model = entityModel,
                Config = config,
                Debug = {
                    OnEntitySpawned = function() end,
                    OnEntityDespawned = function() end,
                    OnEntityStartMoving = function() end,
                    OnEntityFinishedRebound = function() end,
                    OnEntityEnteredRoom = function() end,
                    OnLookAtEntity = function() end,
                    OnDeath = function() end
                }
            }

            return entityTable
        end
    end
end

local function destroy(entityTable)
    for _, v in next, Connections[entityTable.Model] do
        v:Disconnect()
    end

    Connections[entityTable.Model] = nil
    entityTable.Model:Destroy()
    entityTable.Debug.OnEntityDespawned(entityTable)
end


local function shouldDeflect()
    if workspace:FindFirstChild("Doggo") then
        return true
    elseif Char:FindFirstChild("Crucifix") then
        return true
    end

    return false
end


Spawner.runEntity = function(entityTable)
    -- Nodes

    local nodes = {}

    for _, room in next, workspace.CurrentRooms:GetChildren() do
        local pathfindNodes = room:FindFirstChild("PathfindNodes")
        
        if pathfindNodes then
            pathfindNodes = pathfindNodes:GetChildren()
        else
            local fakeNode = Instance.new("Part")
            fakeNode.Name = "1"
            fakeNode.CFrame = room:WaitForChild("RoomExit").CFrame - Vector3.new(0, room.RoomExit.Size.Y / 2, 0)

            pathfindNodes = {fakeNode}
        end

        table.sort(pathfindNodes, function(a, b)
            return tonumber(a.Name) < tonumber(b.Name)
        end)

        for _, node in next, pathfindNodes do
            nodes[#nodes + 1] = node
        end
    end

    -- Spawn

    local entityModel = entityTable.Model:Clone()
    local startNodeIndex = entityTable.Config.BackwardsMovement and #nodes or 1
    local startNodeOffset = entityTable.Config.BackwardsMovement and -50 or 50

    EntityConnections[entityModel] = {}
    local entityConnections = EntityConnections[entityModel]
    
    entityModel:PivotTo(nodes[startNodeIndex].CFrame * CFrame.new(0, 0, startNodeOffset) + Vector3.new(0, 3.5 + entityTable.Config.HeightOffset, 0))
    entityModel.Parent = workspace
    task.spawn(entityTable.Debug.OnEntitySpawned)

    -- Mute entity on spawn

    if CG:FindFirstChild("JumpscareGui") or (Plr.PlayerGui.MainUI.Death.HelpfulDialogue.Visible and not Plr.PlayerGui.MainUI.DeathPanelDead.Visible) then
        warn("on death screen, mute entity")

        for _, v in next, entityModel:GetDescendants() do
            if v.ClassName == "Sound" and v.Playing then
                v:Stop()
            end
        end
    end

    -- Flickering

    if entityTable.Config.FlickerLights[1] then
        ModuleScripts.ModuleEvents.flicker(workspace.CurrentRooms[ReSt.GameData.LatestRoom.Value], entityTable.Config.FlickerLights[2])
    end

    -- Movement

    task.wait(entityTable.Config.DelayTime)

    local enteredRooms = {}

    entityConnections.movementTick = RS.Stepped:Connect(function()
        if entityModel.Parent and not entityModel:GetAttribute("NoAI") then
            local entityPos = entityModel.PrimaryPart.Position
            local rootPos = getPlayerRoot().Position
            local floorRay = FindPartOnRayWithIgnoreList(workspace, Ray.new(entityPos, Vector3.new(0, -10, 0)), {entityModel, Char})
            local playerInSight = FindPartOnRayWithIgnoreList(workspace, Ray.new(entityPos, rootPos - entityPos), {entityModel, Char}) == nil
            
            -- Entered room

            if floorRay ~= nil and floorRay.Name == "Floor" then
                for _, room in next, workspace.CurrentRooms:GetChildren() do
                    if floorRay:IsDescendantOf(room) and not table.find(enteredRooms, room) then
                        enteredRooms[#enteredRooms + 1] = room
                        task.spawn(entityTable.Debug.OnEntityEnteredRoom, room)

                        -- Break lights
                        
                        if entityTable.Config.BreakLights then
                            ModuleScripts.ModuleEvents.shatter(room)
                        end

                        break
                    end
                end
            end

            -- Camera shaking
            
            local shakeConfig = entityTable.Config.CamShake
            local shakeMag = (getPlayerRoot().Position - entityModel.PrimaryPart.Position).Magnitude

            if shakeConfig[1] and shakeMag <= shakeConfig[3] then
                local shakeRep = {}

                for i, v in next, shakeConfig[2] do
                    shakeRep[i] = v
                end
                shakeRep[1] = shakeConfig[2][1] / shakeConfig[3] * (shakeConfig[3] - shakeMag)

                ModuleScripts.MainGame.camShaker.ShakeOnce(ModuleScripts.MainGame.camShaker, table.unpack(shakeRep))
            end

            -- Player in sight

            if playerInSight then
                -- Look at entity

                local _, onScreen = WorldToViewportPoint(Camera, entityModel.PrimaryPart.Position)

                if onScreen then
                    task.spawn(entityTable.Debug.OnLookAtEntity)
                end
                
                                -- Within kill range

                if (Char.PrimaryPart.Position - entityModel.PrimaryPart.Position).Magnitude <= entityTable.Config.KillRange then
                    -- Entity deflection
                   
                    local crucifix = Char:FindFirstChild("Crucifix")
                    
                    if Repents and crucifix then
                    print("found")
           
                        entityModel:SetAttribute("NoAI", true)
			local effect = game:GetObjects("rbxassetid://11645395085")[1]
	   effect.Parent = game.Workspace
	   effect:PivotTo(entityModel.SmilerNew.CFrame - Vector3.new(0,3,0))
	   effect.Chain1.Attachment:FindFirstChildOfClass("Beam").Attachment1 = entityModel.SmilerNew.Attachment
	   effect.Chain2.Attachment:FindFirstChildOfClass("Beam").Attachment1 = entityModel.SmilerNew.Attachment
	   effect.Chain3.Attachment:FindFirstChildOfClass("Beam").Attachment1 = entityModel.SmilerNew.Attachment
	   effect.Chain4.Attachment:FindFirstChildOfClass("Beam").Attachment1 = entityModel.SmilerNew.Attachment
           wait(0.5)
	   local ts = game:GetService("TweenService")
           ts:Create(entityModel.SmilerNew,TweenInfo.new(2, Enum.EasingStyle.Sine,Enum.EasingDirection.In),{CFrame = entityModel.SmilerNew.CFrame + Vector3.new(0,20,0)}):Play()
           wait(2)
	   effect:Destroy()
	   entityModel:Destroy()
                        else
                            --doggo.Growl:Play()
                            -- Repent

                            local nodeIdx, nearest = nil, math.huge

                            for i, v in next, nodes do
                                local dist = (v.Position - entityPos).Magnitude

                                if dist < nearest then
                                    nodeIdx, nearest = i, dist
                                end
                            end
isDeflecting = true
                            for i = nodeIdx, 1, -1 do
                                dragEntity(entityModel, nodes[i].Position + Vector3.new(0, 3.5 + entityTable.Config.HeightOffset, 0), 45)
                            end
	isDeflecting = false
                            --destroy(entityTable)

                            return
                        end
                    end

                -- Kill player

                if entityTable.Config.CanKill and not Char:GetAttribute("IsDead") and not Char:GetAttribute("Invincible") and not Char:GetAttribute("Hiding") and (getPlayerRoot().Position - entityModel.PrimaryPart.Position).Magnitude <= entityTable.Config.KillRange then
                    task.spawn(function()
                        Char:SetAttribute("IsDead", true)

                        -- Mute entity

                        warn("mute entity")

                        for _, v in next, entityModel:GetDescendants() do
                            if v.ClassName == "Sound" and v.Playing then
                                v:Stop()
                            end
                        end

                        -- Jumpscare
                        
                        if entityTable.Config.Jumpscare[1] then
                            Spawner.runJumpscare(entityTable.Config.Jumpscare[2])
                        end

                        -- Death handling
                        
                        task.spawn(entityTable.Debug.OnDeath)
                        Hum.Health = 0
                        ReSt.GameStats["Player_".. Plr.Name].Total.DeathCause.Value = entityModel.Name
                        
                        if #entityTable.Config.CustomDialog > 0 then
                            firesignal(ReSt.EntityInfo.DeathHint.OnClientEvent, entityTable.Config.CustomDialog, "Blue")
                        end
                        
                        -- Unmute entity

                        task.spawn(function()
                            repeat task.wait() until Plr.PlayerGui.MainUI.DeathPanelDead.Visible

                            warn("unmute entity:", entityModel)

                            for _, v in next, entityModel:GetDescendants() do
                                if v.ClassName == "Sound" then
                                    local oldVolume = v.Volume
                                
                                    v.Volume = 0
                                    v:Play()
                                    TS:Create(v, TweenInfo.new(2), {Volume = oldVolume}):Play()
                                end
                            end
                        end)
                    end)
                end
            end
        end
    end)

    task.spawn(entityTable.Debug.OnEntityStartMoving)

    -- Cycles

    local cyclesConfig = entityTable.Config.Cycles

    if entityTable.Config.BackwardsMovement then
        local inverseNodes = {}

        for nodeIdx = #nodes, 1, -1 do
            inverseNodes[#inverseNodes + 1] = nodes[nodeIdx]
        end

        nodes = inverseNodes
    end

    for cycle = 1, math.max(math.random(cyclesConfig.Min, cyclesConfig.Max), 1) do
         if isDeflecting then
         else
            for nodeIdx = 1, #nodes, 1 do
                 dragEntity(entityModel, nodes[nodeIdx].Position + Vector3.new(0, 3.5 + entityTable.Config.HeightOffset, 0), entityTable.Config.Speed)
            end
         end

            if cyclesConfig.Max > 1 then
                  for nodeIdx = #nodes, 1, -1 do
                        dragEntity(entityModel, nodes[nodeIdx].Position + Vector3.new(0, 3.5 + entityTable.Config.HeightOffset, 0), entityTable.Config.Speed)
                  end
             end
             
             -- Rebound finished

        task.spawn(entityTable.Debug.OnEntityFinishedRebound)
        
        if cycle < cyclesConfig.Max then
            task.wait(cyclesConfig.WaitTime)
        end
        
        end

        --task.spawn(entityTable.Debug.OnEntityDespawned)
        entityModel:SetAttribute("NoAI",true)

    -- Destroy

    if entityModel:GetAttribute("NoAI") == true then
        for _, v in next, entityConnections do
            v:Disconnect()
        end
        
        entityModel:Destroy()
        task.spawn(entityTable.Debug.OnEntityDespawned)
    end
end

Spawner.runJumpscare = function(config)
    -- Variables

    local image1 = LoadCustomAsset(config.Image1)
    local image2 = LoadCustomAsset(config.Image2)
    local sound1, sound2 = nil, nil

    if config.Sound1 then
        sound1 = loadSound(config.Sound1)
    end

    if config.Sound2 then
        sound2 = loadSound(config.Sound2)
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
    JumpscareGui.Parent = CG
    
    -- Tease

    local teaseConfig = config.Tease
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

    if config.Flashing[1] then
        task.spawn(function()
            while JumpscareGui.Parent do
                Background.BackgroundColor3 = config.Flashing[2]
                task.wait(math.random(25, 100) / 1000)
                Background.BackgroundColor3 = Color3.new(0, 0, 0)
                task.wait(math.random(25, 100) / 1000)
            end
        end)
    end
    
    -- Shaking

  if config.Shake then
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
end

-- Scripts

Plr.CharacterAdded:Connect(onCharacterAdded)

if not SpawnerSetup then
    getgenv().SpawnerSetup = true

    workspace.DescendantRemoving:Connect(function(des)
        if des.Name == "PathfindNodes" then
            des:Clone().Parent = des.Parent
        end
    end)
end

local entity = Spawner.createEntity({
    CustomName = "Smiler", -- Custom name of your entity
    Model = "https://github.com/PABMAXICHAC/doors-monsters-models/blob/main/Smiler.rbxm?raw=true", -- Can be GitHub file or rbxassetid
    Speed = 850, -- Percentage, 100 = default Rush speed
    DelayTime = 4, -- Time before starting cycles (seconds)
    HeightOffset = 0,
    CanKill = false,
    BreakLights = true,
    FlickerLights = {
        true, -- Enabled
        10, -- Time (seconds)
    },
    Cycles = {
        Min = 2,
        Max = 20,
        WaitTime = 0,
    },
    CamShake = {
        true, -- Enabled
        {5, 15, 0.1, 1}, -- Shake values (don't change if you don't know)
        100, -- Shake start distance (from Entity to you)
    },
    Jumpscare = {
        true, -- Enabled ('false' if you don't want jumpscare)
        {
            Image1 = "rbxassetid://11417375410", -- Image1 url
            Image2 = "rbxassetid://11417375410", -- Image2 url
            Shake = true,
            Sound1 = {
                5263560566, -- SoundId
                { Volume = 2.1 }, -- Sound properties
            },
            Sound2 = {
                5263560566, -- SoundId
                { Volume = 2.1 }, -- Sound properties
            },
            Flashing = {
                true, -- Enabled
                Color3.fromRGB(255, 0, 0), -- Color
            },
            Tease = {
                false, -- Enabled ('false' if you don't want tease)
                Min = 1,
                Max = 3,
            },
        },
    },
    CustomDialog = {"SMILE AGAIN", "It seems like you got access to a entity that isn't released yet.", "Please report this to LSplash#1234 and Redibles#7070 if this happens again."}, -- Custom death message (can be as long as you want)
})
 
-----[[ Advanced ]]-----
entity.Debug.OnEntitySpawned = function(entityModel)
   
end
 
entity.Debug.OnEntityDespawned = function(entityModel)
    
end
 
entity.Debug.OnEntityStartMoving = function(entityModel)
    
end
 
entity.Debug.OnEntityFinishedRebound = function(entityModel)
   
end
 
entity.Debug.OnDeath = function()
    
end
------------------------
 
-- Run the created entity
Spawner.runEntity(entity)
