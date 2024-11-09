-- Bird Statue
-- Not FE
-- Made By DripCapybara

local CanCrash = false

local player = game.Players.LocalPlayer
local humanoid = player.Character.Humanoid
local studs = 2 --Normal: 2.  This is basically how much studs the statue advances to the player if higher the statue will be faster
local tweenspeed = 0.25 --Normal: 0.25.  This is the tween speed for the statue to move the desired studs on the var up here
local distancefromsee = 50 --Normal:  50. This is how far the bird/bird statue can see the player which means if you are [studamount] close it will chase start chasing you when you dont look at it
local waittime = -1

local statuemodel = Instance.new("Model")
statuemodel.Name = "Statue"
statuemodel.Parent = workspace

local statue = Instance.new("Part")
statue.Size = Vector3.new(10, 20, 10) -- Adjust the size as needed
statue.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position+Vector3.new(50,0,0) -- Adjust the position as needed
statue.BrickColor = BrickColor.new("Medium stone grey")
statue.Anchored = true -- Prevents the statue from falling
statue.Parent = statuemodel
statue.Transparency = 1
statue.CanCollide = false

local movingsound = Instance.new("Sound")
movingsound.Parent = statue
movingsound.SoundId = "rbxassetid://6461862392"
movingsound.Looped = true
movingsound.Name = "MOVING"
movingsound.Volume = 10

local fakestatue = game:GetObjects("rbxassetid://5023627637")[1]
fakestatue.Parent = statuemodel
fakestatue.MeshPart.Anchored = true

fakestatue.MeshPart.Touched:Connect(function(p)
if p.Parent.Name == player.Name and humanoid.Health > 1 then
humanoid.Health = 0
wait(1)
statue.Anchored = false
statue.CanCollide = false
movingsound:Destroy()
end
end)

local function moveStatue()
    while true do
        local distance = (player.Character.HumanoidRootPart.Position - statue.Position).Magnitude
        local direction = (player.Character.HumanoidRootPart.Position - statue.Position).Unit
        local angle = math.acos(direction:Dot(player.Character.HumanoidRootPart.CFrame.LookVector))
        
        if distance > 5 and humanoid.FloorMaterial ~= Enum.Material.Air and math.deg(angle) > 90 then        
           movingsound:Stop()
        else
        if distance < distancefromsee then
           movingsound:Play()
           local tween = game.TweenService:Create(statue,TweenInfo.new(tweenspeed),{CFrame = CFrame.new(statue.Position + direction * studs, player.Character.HumanoidRootPart.Position)})
           tween:Play()
           fakestatue.MeshPart.CanCollide = false
           fakestatue.MeshPart.CFrame = statue.CFrame*CFrame.Angles(0,15.65,0)*CFrame.new(0,2.7,0)
        end
        end
        task.wait(waittime)
    end
end

moveStatue()
--THIS IS A 1 TIME SCRIPT MEANING THAT WHEN YOU DIE THE BIRD DISSAPEARS DUE TO A ERROR I CANT FIX.
