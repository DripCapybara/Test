-- Made by Dripcapybara
-- a client sided remake of "Giggle" from doors.

local funnyguyragdoll = game:GetObjects("rbxassetid://137955003110738")[1]
local funnyguycover = game:GetObjects("rbxassetid://70665402954663")[1]
local funnyguy = game:GetObjects("rbxassetid://105107170981821")[1]
local cameraShaker = require(game.ReplicatedStorage.CameraShaker)
local camera = workspace.CurrentCamera
local camShake = cameraShaker.new(Enum.RenderPriority.Camera.Value, function(cf)
camera.CFrame = camera.CFrame * cf
end)
camShake:Start()

funnyguy.Parent = workspace
funnyguy:PivotTo(CFrame.new())

local minRadius = -20
local maxRadius = 20

local damage = 2
local ragdollDissapears = true

if getgenv().minRadius ~= nil then
    minRadius = getgenv().minRadius
end

if getgenv().maxRadius ~= nil then
    maxRadius = getgenv().maxRadius
end

if getgenv().damage ~= nil then
    damage = getgenv().damage
end

if getgenv().ragdollDissapears ~= nil then
     ragdollDissapears = getgenv().ragdollDissapears
end

local char = game.Players.LocalPlayer.Character

repeat task.wait() until char ~= nil
repeat wait() until funnyguy:FindFirstChild("AnimationController")
local spawnPoint = char:GetPivot()*CFrame.new(math.random(minRadius,maxRadius),5,math.random(minRadius,maxRadius))
local ray = Ray.new(spawnPoint.Position, Vector3.new(0,999,0))
local hit,pos,normal = workspace:FindPartOnRay(ray)

if pos and normal then
     if normal == Vector3.new(0,0,0) then
        normal = Vector3.new(0,-1,0)
     end
     funnyguy:PivotTo(CFrame.new(pos, pos+normal)*CFrame.new(0,0,-1))
     
else
      funnyguy:Destroy()
      return
end

wait()
function loadAnim(anim)
     return funnyguy.AnimationController.Animator:LoadAnimation(anim)
end

local attacked = false
local canAttack = true
local idletrack = loadAnim(funnyguy.Animations.idle)
idletrack.Priority = "Idle"
idletrack.Looped = true
idletrack:Play()

spawn(function()
     while not attacked do
         wait(math.random(5,14))
         if attacked then break end
         if canAttack then
         local laughTrack = loadAnim(funnyguy.Animations.laugh)
         laughTrack.Priority = "Action"
         laughTrack:Play()
         local s = funnyguy.Root.Sounds.Laugh:GetChildren()
         s = s[math.random(1,#s)]:Clone()
         s.Parent = funnyguy.Root
         s:Play()
         game.Debris:AddItem(s, 3)
         end
     end
end)

funnyguy.Root.Touched:Connect(function(b)
     if b.Name == "GlowstickLive" then
         if not canAttack then return end
         canAttack = false
         idletrack:Stop(0.5)
         local s = funnyguy.Root.Sounds.Smack:GetChildren()
         s = s[math.random(1,#s)]:Clone()
         s.Parent = funnyguy.Root
         s:Play()
         
         local stunTrack = loadAnim(funnyguy.Animations.stunhit)
         stunTrack.Priority = "Action"
         stunTrack:Play()
         
         local idleStunTrack = loadAnim(funnyguy.Animations.stunidle)
         delay(1,function()
         
         idleStunTrack.Priority = "Idle"
         idleStunTrack.Looped = true
         idleStunTrack:Play()
         end)
         
         wait(4)
         
         local stunend = loadAnim(funnyguy.Animations.stunexit)
         stunend.Priority = "Action"
         stunend:Play()
         
         wait(0.5)
         
         canAttack = true
         idletrack:Play()
         stunend:Stop()
         idleStunTrack:Stop(0.5)
     end
end)

funnyguy.Hitbox.Touched:Connect(function(b)
      if b.Parent:FindFirstChildOfClass("Humanoid") then
          if game.Players:GetPlayerFromCharacter(b.Parent) then
              if attacked then return end
              if not canAttack then return end
              attacked = true
              local oldfunnyguy = funnyguy
              funnyguy = funnyguycover:Clone()
              funnyguy.Parent = workspace
              funnyguy:PivotTo(oldfunnyguy:GetPivot())
              oldfunnyguy:Destroy()
              local detach = loadAnim(funnyguy.Animations.detach)
              detach.Priority = "Action"
              detach.Looped = true
              detach:Play()
        
local isclose = false
local scare = Instance.new("Sound",workspace)
scare.SoundId = "rbxassetid://10337055816"
scare.Volume = 0.55
scare:Play()
funnyguy.Root.Laugh:Play()
              while not isclose do
                  task.wait()
                  local speedy = 3
                  local charPos = char.Head.CFrame
                  local dir = -(funnyguy.Root.Position-charPos.Position).Unit
                  local dist = dir * speedy
                  local newPos = funnyguy:GetPivot().Position + dist
                  local c = funnyguy:GetPivot():Lerp(CFrame.new(newPos, newPos + dir), 0.3)
                  
                  funnyguy:PivotTo(c)
                  
                  local dist = (funnyguy.Root.Position-charPos.Position).Magnitude
                  if dist < 3 then
                      isclose = true
                  end
              end
              
              detach:Stop()
              
              local attacking = loadAnim(funnyguy.Animations.stuck)
              attacking.Looped = true
              attacking:Play()
              
              local HELP = Instance.new("Animation")
              HELP.AnimationId = "rbxassetid://16789462076"
              HELP = char.Humanoid.Animator:LoadAnimation(HELP)
              HELP.Priority = "Action"
              HELP:Play()
              
              local theTime = tick()
              local lastDamage = tick()
              local lastShake = tick()
              
              local c
              c = game:GetService("RunService").RenderStepped:Connect(function()
                    if tick() - theTime >= math.random(5,7) then
                        c:Disconnect()
                        return
                    end
                    if tick() - lastDamage >= 0.75 then
                         char.Humanoid:TakeDamage(damage)
                         game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Giggle"
                         lastDamage = tick()
                    end
                    
                    if tick() - lastShake >= 0.3 then
                         camShake:ShakeOnce(6,25,0,5,3,16)
                         lastShake = tick()
                    end
                    
                    funnyguy:PivotTo(char.Head.CFrame*CFrame.new(0,0.45,-1.5)*CFrame.Angles(0,math.rad(180),0))
              end)
              
              repeat task.wait() until not c.Connected
              
              HELP:Stop()
              funnyguyragdoll.Parent = workspace
              funnyguyragdoll:PivotTo(funnyguy:GetPivot())
              funnyguyragdoll.Root.Sound_Laugh:Play()
              funnyguy:Destroy()
              
              local dir = -(char:GetPivot().Position-funnyguyragdoll:GetPivot(). Position).Unit
              local throw = Instance.new("BodyVelocity",funnyguyragdoll.Root)
              throw.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
              throw.Velocity = dir * 35
              game.Debris:AddItem(throw,0.1)
              
              task.delay(5, function()
                   if ragdollDissapears then
                         for _,v in pairs(funnyguyragdoll:GetDescendants())do
                              if v:IsA("MeshPart") then
                                  game.TweenService:Create(v,TweenInfo.new(3),{Transparency = 1}):Play()
                              end
                         end
                         game.Debris:AddItem(funnyguyragdoll,3)
                   end
              end)
          end
      end
end)
