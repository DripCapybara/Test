local LatestRoom = workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value]
local Player = game.Players.LocalPlayer
local maingame = require(Player.PlayerGui.MainUI.Initiator.Main_Game)

if LatestRoom:FindFirstChild("Assets") then

local Damage = 30

  if getgenv().Damage then
Damage = getgenv().Damage
  end
  
local Stunned = false
local Snare = game:GetObjects("rbxassetid://119802177430542")[1]

local floors = {}
    
for _,v in pairs(LatestRoom:GetDescendants()) do
    if v.Name == "Floor" then
        if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
             table.insert(floors, v)
        end
    end
end
    end
    if #floors > 0 then
        floor = floors[math.random(1,#floors)]
    end
end

if not floor or floor == nil then return end
Snare.Parent = LatestRoom:FindFirstChild("Assets") 

local maxX = floor.Size.X / 2
local minX = -floor.Size.X / 2
local maxZ = floor.Size.Z / 2
local minZ = -floor.Size.Z / 2

local randomX = math.random(minX, maxX)
local randomZ = math.random(minZ, maxZ)

local origin = floor.CFrame * CFrame.new(randomX, floor.Size.Y / 2 + 0.1, randomZ);
Snare:PivotTo(origin)

Snare.Hitbox.CanTouch = true
Snare.Hitbox.Touched:Connect(function(BasePart)
     if BasePart.Parent:IsA("Model") and game.Players:GetPlayerFromCharacter(BasePart.Parent) then
         if Stunned then return end
         
         Stunned = true
         local bruv = true
         local c
         local pos = Vector3.new(Player.Character:GetPivot().Position.X, Snare.Hitbox.Position.Y, Player.Character:GetPivot().Position.Z)
         Snare.Hitbox.CFrame = CFrame.new(Snare.Hitbox.Position, Snare.Hitbox.Position + (Snare.Hitbox.Position - pos).Unit)
         c = game:GetService("RunService").RenderStepped:Connect(function()
               if not bruv then c:Disconnect() end
               
               Player.Character:PivotTo(Snare.Hitbox.CFrame * CFrame.new(0, 1, 0))
         end)
         Player.Character:SetAttribute("Stunned",true)
         Player.Character:FindFirstChildOfClass("Humanoid"):TakeDamage(30)
         Snare.Hitbox.Sound:Play()
         Player.Character.Collision.Anchored = true
         local Model = LoadAnim(Snare.Animations.Model)
         Model.Priority = "Action"
         Model:Play()
         
         wait()
         local Start = Player.Character:FindFirstChildOfClass("Humanoid"): FindFirstChildOfClass("Animator"):LoadAnimation(Snare.Animations.Start)
         Start.Priority = "Action"
         Start:Play()
        
        task.delay(0.75, function()-- 0.75
        
                 local Loop = Player.Character:FindFirstChildOfClass("Humanoid"): FindFirstChildOfClass("Animator"):LoadAnimation(Snare.Animations.Loop)
                Loop.Priority = "Action"
                Loop.Looped = true
                Loop:Play()
                
                task.delay(3, function()
                Loop:Stop(0.5)
                local Exit = Player.Character:FindFirstChildOfClass("Humanoid"): FindFirstChildOfClass("Animator"):LoadAnimation(Snare.Animations.Exit)
                Exit.Priority = "Action"
                Exit:Play()
                
                task.delay(1, function()
                      bruv = false
                      maingame.stopcam = false
                      Player.Character.Collision.Anchored = false
                      Player.Character:SetAttribute("Stunned",false)
                end)
                
                task.delay(2, function()
                    Stunned = false
                end)
                
                end)
        end)
     end
end)

end
