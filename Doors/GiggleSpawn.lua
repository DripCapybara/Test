-- Made by Dripcapybara / The S from kardin's server
-- a client sided remake of "Giggle" from doors.
-- Version: V2

-- written in mobile (my fingers dont hurt luckily

function Load(URL, AssetName)
    local Asset = game:GetObjects(URL)[1]
    return (typeof(Asset)=="string" and nil or Asset)
    -- Checks if the Asset has failed to load
    -- If GetObjects fails to load a object, it will return a error as a string instead of the object.
end

-- We load the Assets first so they dont return nil or fail to load.
GiggleCeiling = Load("rbxassetid://105107170981821")
GiggleCover = Load("rbxassetid://70665402954663")
GiggleRagdoll = Load("rbxassetid://137955003110738")

GiggleRagdoll.Parent = game.ReplicatedStorage
GiggleCover.Parent = game.ReplicatedStorage
GiggleCeiling.Parent = game.ReplicatedStorage

local DefaultConfigs = {
     Damage = 6,
     AttackingTime = math.random(7, 10), -- The time giggle will be attacking for.
     FallSpeed = 3,        -- Speed for when giggle spawns, can be mininum 2 and how high you want
     
     Stunnable = true,    -- If set to true, Giggle will be stunnable with glowstick
     StunTime = 5, -- The time giggle will be stun for
     
     RagdollThrowForce = 50,    -- The Ragdoll's Force when its thrown
     RagdollDissapears = true,  -- If set to true the ragdoll will dissapear once giggle finishes attacking.
  
     RoomSpawning = {
          Enabled = true   -- If set to false, giggle will spawn around the player.
     },
     
     PlayerSpawning = { -- This table will be used if Room Spawning is Disabled
          MinRadius = -20,  -- The minimum distance giggle can spawn from the player.
          MaxRadius = 20.  --  The maximum distance giggle can spawn from the player.
     },
     
     SpawningKey = { -- Key for Spawning
          Enabled = false,  -- If enabled once the key is pressed, giggle will spawn.
          Key = "G"    -- Key that is used for spawning giggle
     }
}

-- If a config is not found, it will be replaced with the default version of it
if getgenv().GIGGLE_SPAWN_CONFIG then
    local setConfig = GIGGLE_SPAWN_CONFIG
    
    for i, v in next, DefaultConfigs do
        if setConfig[i] == nil then
            setConfig[i] = v
        end
    end
    
    DefaultConfigs = setConfig
end

-- VARIABLES --

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character

local Camera = workspace.CurrentCamera

local ModuleScripts = {
MainGame = require(Player.PlayerGui.MainUI.Initiator.Main_Game),
}

local camShake = ModuleScripts.MainGame.camShaker

repeat task.wait() until Character and Player and Character ~= nil and Player ~= nil

local function SpawnGiggle()

if DefaultConfigs["SpawningKey"]["Enabled"] then
      if game.ReplicatedStorage:FindFirstChild("GiggleCeiling") then
         GiggleCeiling = game.ReplicatedStorage:FindFirstChild("GiggleCeiling"):Clone()
     else
         GiggleCeiling = Load("rbxassetid://105107170981821")
         GiggleCeiling:Clone().Parent = game.ReplicatedStorage
     end
     if game.ReplicatedStorage:FindFirstChild("GiggleCover") then
         GiggleCover = game.ReplicatedStorage:FindFirstChild("GiggleCover"):Clone()
     else
         GiggleCover = Load("rbxassetid://70665402954663")
         GiggleCover:Clone().Parent = game.ReplicatedStorage
     end
     if game.ReplicatedStorage:FindFirstChild("GiggleRagdoll_") then
         GiggleRagdoll = game.ReplicatedStorage:FindFirstChild("GiggleRagdoll_"):Clone()
      else
         GiggleRagdoll = Load("rbxassetid://137955003110738")
         GiggleRagdoll:Clone().Parent = game.ReplicatedStorage
     end
end
    
    -- spawning in roof
    if DefaultConfigs["RoomSpawning"]["Enabled"] == true then
        local LatestRoom = workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value]
        
        if LatestRoom then
            
            GiggleCeiling.Parent = LatestRoom
            local Floors = {}
            
            for _,v in pairs(LatestRoom:GetDescendants()) do
                if v:IsA("Part") or v:IsA("BasePart") or v:IsA("PartOperation") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
                    if v.Name == "Floor" or string.lower(v.Name)=="floor" then
                        table.insert(Floors, v)
                    end
                end
            end
            
            local center = Floors[math.random(1,#Floors)]
            
            if not center or center == nil then return error("Failed to get spawn center.", 0) end
                
                local minX = -center.Size.X / 2
                local maxX = center.Size.X / 2
                
                local minZ = -center.Size.Z / 2
                local maxZ = center.Size.Z / 2
                
                --Adjusting so it doesn't spawn out of bounds too much
                minX += 1
                maxX -= 1
                minZ += 1
                maxZ -= 1
                
                local x = math.random(minX,maxX)
                local z = math.random(minZ,maxZ)
                -- and we dont talk about Y coordinate.
                
                local origin = center.Position + Vector3.new(x, center.Position.Y + 8, z)
                local direction =  Vector3.new(0,999,0)
                
                -- we use raycast to get the normal and position of the supposed "roof"
                local ray = Ray.new(origin, direction)
                local hit, pos, normal = workspace:FindPartOnRay(ray)
                
                if pos and normal then
                    if normal == Vector3.new(0,0,0) then
                        normal = Vector3.new(0,-1,0) -- small fix cuz the position will get fucked up if the normal is 0.
                    end
                    
                    -- positioning with random rotation (FINALLY)
                    GiggleCeiling:PivotTo(CFrame.new(pos, pos + normal) * CFrame.new(0,0,-1))
                    GiggleCeiling:PivotTo(GiggleCeiling:GetPivot()*CFrame.Angles(0,0,math.rad(math.random(-180,180)))) -- Random Rotation!!!
                    
                    if (GiggleCeiling.Root.Position - origin).Magnitude > 100 or (GiggleCeiling.Root.Position - origin).Magnitude < 10 then
                        -- If giggle is too close or far from the ray's origin
                        GiggleCeiling:Destroy()
                        return error("Failed to spawn in correct positions",0)
                    end
                else 
                    return error("Failed to get spawn position.",0)
                end
            end
        else
        -- spawning around player
            local minX = DefaultConfigs["PlayerSpawning"]["MinRadius"]
            local minZ = DefaultConfigs["PlayerSpawning"]["MinRadius"]
            local maxX = DefaultConfigs["PlayerSpawning"]["MaxRadius"]
            local maxZ = DefaultConfigs["PlayerSpawning"]["MaxRadius"]
            local center = Character:GetPivot().Position
            local x = math.random(minX,maxX)
            local z = math.random(minZ,maxZ)
            -- and we dont talk about Y coordinate.
            
            local origin = center + Vector3.new(x, center.Y, z)
            local direction =  Vector3.new(0,999,0)
            
            -- we use raycast to get the normal and position of the supposed "roof"
            local ray = Ray.new(origin, direction)
            local hit, pos, normal = workspace:FindPartOnRay(ray)
            
            if pos and normal then
                if normal == Vector3.new(0,0,0) then
                    normal = Vector3.new(0,-1,0) -- small fix cuz the position will get fucked up if the normal is 0.
                end
                
                -- positioning with random rotation (FINALLY)
                GiggleCeiling:PivotTo(CFrame.new(pos, pos + normal) * CFrame.new(0,0,-1))
                GiggleCeiling:PivotTo(GiggleCeiling:GetPivot()*CFrame.Angles(0,0,math.rad(math.random(-180,180)))) -- Random Rotation!!!
                
                if (GiggleCeiling.Root.Position - origin).Magnitude > 100 or (GiggleCeiling.Root.Position - origin).Magnitude < 10 then
                    -- If giggle is too close or far from the ray's origin
                    GiggleCeiling:Destroy()
                    return error("Failed to spawn in correct positions",5)
                end
            else 
                return error("Failed to get spawn position.",5)
            end
        end
        
        -- Function to load anims faster
        local function LoadAnimation(GiggleModel, Animation)
            if GiggleModel:FindFirstChild("Animations") then
                return GiggleModel:FindFirstChildOfClass("AnimationController"):FindFirstChildOfClass("Animator"):LoadAnimation(GiggleModel:FindFirstChild("Animations"):FindFirstChild(Animation)) -- LONG AHH ANIMATION LOADER
            end
        end
        
        -- Setup
        local Attacked = false
        local canAttack = true
        
        local MainGiggle = GiggleCeiling
        
        local Sounds = MainGiggle.Root.Sounds
        local Laughs = Sounds.Laugh:GetChildren()
        local Smacks = Sounds.Smack:GetChildren()
        local SmackImpacts = Sounds.SmackImpact:GetChildren()
        
        local Idle = LoadAnimation(MainGiggle, "idle")
        Idle.Priority = "Idle"
        Idle.Looped = true
        Idle:Play()
        
        task.spawn(function() -- Thread to make giggle laugh every once in a while
            while not Attacked do
                task.wait(math.random(5, 9))
                if Attacked then break end   -- Once the time ends, if giggle has attacked we return.
                    if canAttack then
                        
                        local laugh = LoadAnimation(MainGiggle, "laugh")
                        laugh.Priority = "Action"
                        laugh:Play()
                        
                        local laughSound = Laughs[math.random(1,#Laughs)]:Clone()
                        laughSound.Parent = MainGiggle.Root
                        laughSound:Play()
                        laughSound.Ended:Wait()
                        
                        laughSound:Destroy()
                    end
                end
            end)
            
            -- stun being hit by a glowstick
           MainGiggle.Root.Touched:Connect(function(basepart)
                 if basepart.Name == "GlowstickLive" then
                      if not canAttack then return end
                      if not DefaultConfigs["Stunnable"] then return end
                      canAttack = false
                      Idle:Stop(0.65)
                      
                      task.spawn(function()
                      local smackSound = Smacks[math.random(1,#Smacks)]:Clone()
                      smackSound.Parent = MainGiggle.Root
                      smackSound:Play()
                      smackSound.Ended:Wait()
                      smackSound:Destroy()
                      end)
                      
                      task.spawn(function()
                      local impactSound = SmackImpacts[math.random(1,#SmackImpacts)]:Clone()
                      impactSound.Parent = MainGiggle.Root
                      impactSound:Play()
                      impactSound.Ended:Wait()
                      impactSound:Destroy()
                      end)
                      
                     local stun = LoadAnimation(MainGiggle, "stunhit")
                     stun.Priority = "Action"
                     stun:Play()
                     
                     local stunidle = LoadAnimation(MainGiggle, "stunidle")
                     stunidle.Priority = "Idle"
                     stunidle.Looped = true
                     
                     task.delay(0.375, function()
                        stunidle:Play()
                    end)
                    
                    task.wait(DefaultConfigs["StunTime"])
                    
                    local stunend = LoadAnimation(MainGiggle, "stunexit")
                    stunend.Priority = "Action"
                    stunend:Play()
                    
                    task.wait(0.5)
                    
                    canAttack = true
                    Idle:Play()
                    stunend:Stop()
                    stunidle:Stop(0.5)
                 end
           end)
           
           MainGiggle.Hitbox.Touched:Connect(function(basepart)
                if basepart.Parent:FindFirstChildOfClass("Humanoid") then
                    local player = game:GetService("Players"):GetPlayerFromCharacter(basepart.Parent) 
                    if player and player == Player then
                         if Attacked or not canAttack then return end
                         Attacked = true
                         
                         local OldGiggle = MainGiggle
                         MainGiggle = GiggleCover:Clone()
                         MainGiggle.Parent = workspace
                         MainGiggle:PivotTo(OldGiggle:GetPivot())
                         OldGiggle:Destroy()
                         
                        local Detach = LoadAnimation(MainGiggle, "detach")
                        Detach.Priority = "Action"
                        Detach.Looped = true
                        Detach:Play()
                        
                        local IsClose = false
                        local Scare = Instance.new("Sound", Player)
                        Scare.SoundId = "rbxassetid://10337055816"
                        Scare.Volume = 0.55
                        Scare:Play()
                        
                        MainGiggle.Root.Laugh:Play()
                        
                        while not IsClose do
                             task.wait()
                             
                             local Goal = Character.Head.CFrame * CFrame.new(0, 0, -0.5)
                             local Direction = -(MainGiggle.Root.Position - Goal.Position).Unit
                             local TravelDistance = Direction * DefaultConfigs["FallSpeed"]
                             local NewPosition = MainGiggle:GetPivot().Position + TravelDistance
                             local NewCFrame = MainGiggle:GetPivot():Lerp(CFrame.new(NewPosition, NewPosition + Direction), 0.3)
                             
                             MainGiggle:PivotTo(NewCFrame)
                             
                             if (NewCFrame.Position - Goal.Position).Magnitude < 3 then
                                  IsClose = true
                             end
                        end
                        
                        Detach:Stop()
                        
                        -- NOT FUNNY
                        local Attacking = LoadAnimation(MainGiggle, "stuck")
                        Attacking.Looped = true
                        Attacking:Play()
                        
                        local HELP = Instance.new("Animation")
                        HELP.AnimationId = "rbxassetid://16789462076"
                        local WHATISTHISLSPLASH = Character: FindFirstChildOfClass("Humanoid"): FindFirstChildOfClass("Animator"):LoadAnimation(HELP)
                        WHATISTHISLSPLASH.Priority = "Action"
                        WHATISTHISLSPLASH.Looped = true
                        WHATISTHISLSPLASH:Play()
                        
                        local theTime = tick()
                        local lastDamage = tick()
                        local lastShake = tick()
                                
                                local Connection
                                Connection = game:GetService("RunService").RenderStepped:Connect(function()
                                    if tick() - theTime >= math.random(4, 7) then
                                        Connection:Disconnect()
                                        return
                                    end
                                    
                                    if tick() - lastDamage >= 1.35 then
                                    lastDamage = tick()
                                        Character:FindFirstChildOfClass("Humanoid"):TakeDamage(DefaultConfigs["Damage"])   -- IT HURTS
                                        game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Giggle"
                                        
                                    end
                                    
                                    if tick() - lastShake >= 0.3 then
                                        camShake:ShakeOnce(6,25,0,5,3,16)
                                        lastShake = tick()
                                    end
                                    
                                    MainGiggle:PivotTo(Camera.CFrame * CFrame.new(0, 0, -1) * CFrame.Angles(0, math.rad(180), 0))
                                end)
                                
                                repeat task.wait() until not Connection.Connected
                                
                                WHATISTHISLSPLASH:Stop()
                                local OldGiggle = MainGiggle
                                MainGiggle = GiggleRagdoll
                                MainGiggle.Parent = workspace
                                MainGiggle:PivotTo(OldGiggle:GetPivot())
                                MainGiggle.Root.Sound_Laugh:Play()
                                OldGiggle:Destroy()
                                
                                local Direction = -(Character:GetPivot().Position - MainGiggle:GetPivot().Position).Unit
                                local ThrowForce = Instance.new("BodyVelocity", MainGiggle.Root)
                                ThrowForce.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                                ThrowForce.Velocity = Direction * DefaultConfigs["RagdollThrowForce"]
                                game:GetService("Debris"):AddItem(ThrowForce, 0.1)
                                
                                task.delay(5, function()
                                      if DefaultConfigs["RagdollDissapears"] then
                                          for _,v in pairs(MainGiggle:GetDescendants()) do
                                               if v:IsA("MeshPart") or v:IsA("Part") then
                                                    game:GetService("TweenService"):Create(v, TweenInfo.new(3), {Transparency = 1}):Play()
                                               end
                                          end
                                          
                                          game:GetService("Debris"):AddItem(MainGiggle, 3)
                                      end
                                end)
                            end
                    end
           end)
           
        end
        
        
        if DefaultConfigs["SpawningKey"]["Enabled"]==true then
        local KeyCode = DefaultConfigs["SpawningKey"]["Key"]
             local CAS = game:GetService("ContextActionService")
             CAS:BindAction("SPAWNGIGGLE", function()
                    SpawnGiggle()
             end, true, Enum.KeyCode[KeyCode])
            else
            task.spawn(SpawnGiggle) -- Spawning giggle 🔥🔥🔥
        end
        
