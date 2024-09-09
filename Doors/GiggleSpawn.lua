local funnyguyragdoll = game:GetObjects("rbxassetid://70665402954663")[1]
local funnyguy = game:GetObjects("rbxassetid://105107170981821")[1]
local cameraShaker = require(game.ReplicatedStorage.CameraShaker)
			local camera = workspace.CurrentCamera

			local camShake = cameraShaker.new(Enum.RenderPriority.Camera.Value, function(cf)
				camera.CFrame = camera.CFrame * cf
			end)
			camShake:Start()


funnyguy.Parent = workspace
funnyguy:PivotTo(CFrame.new())

local char = game.Players.LocalPlayer.Character
local spawnPoint = char:GetPivot()*CFrame.new(math.random(-20,20),5,math.random(-20,20))
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

function loadAnim(anim)
     return funnyguy.AnimationController.Animator:LoadAnimation(anim)
end

local attacked = false
local idletrack = loadAnim(funnyguy.Animations.idle)
idletrack.Priority = "Idle"
idletrack.Looped = true
idletrack:Play()

spawn(function()
     while not attacked do
         wait(math.random(5,14))
         if attacked then break end
         local laughTrack = loadAnim(funnyguy.Animations.laugh)
         laughTrack.Priority = "Action"
         laughTrack:Play()
         local s = funnyguy.Root.Sounds.Laugh:GetChildren()
         s = s[math.random(1,#s)]:Clone()
         s.Parent = funnyguy.Root
         s:Play()
         game.Debris:AddItem(s, 3)
     end
end)

funnyguy.Hitbox.Touched:Connect(function(b)
      if b.Parent:FindFirstChildOfClass("Humanoid") then
          if game.Players:GetPlayerFromCharacter(b.Parent) then
              if attacked then return end
              attacked = true
              local oldfunnyguy = funnyguy
              funnyguy = funnyguyragdoll:Clone()
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
                    if tick() - theTime >= math.random(3,5) then
                        c:Disconnect()
                        return
                    end
                    if tick() - lastDamage >= 0.75 then
                         char.Humanoid:TakeDamage(4)
                         lastDamage = tick()
                    end
                    
                    if tick() - lastShake >= 0.3 then
                         camShake:ShakeOnce(6,25,0,2,1,16)
                         lastShake = tick()
                    end
                    
                    funnyguy:PivotTo(char.Head.CFrame*CFrame.new(0,0,-1.5)*CFrame.Angles(0,math.rad(180),0))
              end)
              
              repeat task.wait() until not c.Connected
              
              HELP:Stop()
              funnyguy.Root.Laugh:Stop()
              funnyguy:Destroy()
          end
      end
end)

