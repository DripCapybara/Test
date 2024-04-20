New = function(Object, Parent, Name, Data)
	local Object = Instance.new(Object)
	for Index, Value in pairs(Data or {}) do
	   if Index then
		Object[Index] = Value
	   end
	end
	Object.Parent = Parent
	if Name ~= nil then
	Object.Name = Name
	else
	
	end
	return Object
end

local usePathfind=true
local morph = false
local Player = game.Players.LocalPlayer
local Character = Player.Character

local AgentParams = {
	["AgentHeight"] = 100,
	["AgentRadius"] = 30,
	["AgentCanJump"] = true,
	["AgentCanClimb"] = true,
	["WaypointSpacing"] = 2
}
local pathFindingS=game:GetService("PathfindingService")

local target = nil

local debounce = false

spawnlocation=nil
foundSpawn=false

for _,Spawn in pairs(workspace:GetDescendants()) do
if Spawn:IsA("SpawnLocation") then
print("Checking")
if foundSpawn == false then
if (Spawn.Position-Character.Head.Position).Magnitude<500 then
foundSpawn=true
print("Found spawn!")
spawnlocation=Spawn
end
end
end
end

if spawnlocation == nil then warn("Spawn not found.") return end
if not foundSpawn then warn("Spawn not found") return end

local ambienceSmiler = Instance.new("Sound",workspace)
ambienceSmiler.PlayOnRemove = true
ambienceSmiler.Volume = 3
ambienceSmiler.SoundId = "rbxassetid://3347506450"
ambienceSmiler:Destroy()

tween=game.TweenService:Create(game.Lighting,TweenInfo.new(1),{FogEnd=100})
tween:Play()
game.Lighting.FogStart = 1

Message=New("Message",workspace,"HeIsHere!",{Text="Silly Is Here!"}) game.Debris:AddItem(Message,5)

spawn(function()
wait(0.5)
Message.Text = "Silly Is Here! H"
wait(0.5)
Message.Text = "Silly Is Here! HI"
wait(0.5)
Message.Text = "Silly Is Here! HID"
wait(0.5)
Message.Text = "Silly Is Here! HIDE"
wait(0.5)
Message.Text = "Silly Is Here! HIDE!"
wait(0.5)
Message.Text = "Silly Is Here! HIDE!!"
wait(0.5)
Message.Text = "Silly Is Here! HIDE!!!"
wait(0.2)
Message.Text = "Silly Is Here! HIDEEEE!!!!"
wait(0.1)
wait(0.03)
Message.Text = "Silly Is Here! HIDEEEE!!!!"
wait(0.03)
Message.Text = "RILLY Rs Rere! HIDE!!EEE!!!!"
wait(0.03)
Message.Text = "RUY RU RUe! HID!!!!EEEE!!!!"
wait(0.03)
Message.Text = "RUN RUN RUN! HIDEEE!!!E!!!!"
wait(0.03)
Message.Text = "Silly Is Here! HIDEEEE!!!!"
wait(0.03)
Message.Text = "RILLY Rs Rere! HIDE!!EEE!!!!"
wait(0.03)
Message.Text = "RUY RU RUe! HID!!!!EEEE!!!!"
wait(0.03)
Message.Text = "RUN RUN RUN! HIDEEE!!!E!!!!"
wait(0.03)
Message.Text = "RUY RU RUe! HID!!!!EEEE!!!!"
wait(0.03)
Message.Text = "RUN RUN RUN! HIDEEE!!!E!!!!"
wait(0.03)
Message.Text = "Silly Is Here! HIDEEEE!!!!"
wait(0.03)
Message.Text = "RILLY Rs Rere! HIDE!!EEE!!!!"
wait(0.03)
Message.Text = "RUY RU RUe! HID!!!!EEEE!!!!"
wait(0.03)
Message.Text = "RUN RUN RUN! HIDEEE!!!E!!!!"
Message.Text = "RUY RU RUe! HID!!!!EEEE!!!!"
wait(0.03)
Message.Text = "RUN RUN RUN! HIDEEE!!!E!!!!"
wait(0.03)
Message.Text = "Silly Is Here! HIDEEEE!!!!"
wait(0.03)
Message.Text = "RILLY Rs Rere! HIDE!!EEE!!!!"
wait(0.03)
Message.Text = "RUY RU RUe! HID!!!!EEEE!!!!"
wait(0.03)
Message.Text = "RUN RUN RUN! HIDEEE!!!E!!!!"
wait(0.03)
Message.Text = "RUY RU RUe! HID!!!!EEEE!!!!"
wait(0.03)
Message.Text = "RUN RUN RUN! HIDEEE!!!E!!!!"
wait(0.03)
Message.Text = "Silly Is Here! HIDEEEE!!!!"
wait(0.03)
Message.Text = "RILLY Rs Rere! HIDE!!EEE!!!!"
wait(0.03)
Message.Text = "RUY RU RUe! HID!!!!EEEE!!!!"
wait(0.03)
Message.Text = "RUN RUN RUN! HIDEEE!!!E!!!!"
Message.Text = "RUY RU RUe! HID!!!!EEEE!!!!"
wait(0.03)
Message.Text = "RUN RUN RUN! HIDEEE!!!E!!!!"
wait(0.03)
Message.Text = "Silly Is Here! HIDEEEE!!!!"
wait(0.03)
Message.Text = "RILLY Rs Rere! HIDE!!EEE!!!!"
wait(0.03)
Message.Text = "RUY RU RUe! HID!!!!EEEE!!!!"
wait(0.03)
Message.Text = "RUN RUN RUN! HIDEEE!!!E!!!!"
wait(0.03)
Message.Text = "RUY RU RUe! HID!!!!EEEE!!!!"
wait(0.03)
Message.Text = "RUN RUN RUN! HIDEEE!!!E!!!!"
wait(0.03)
Message.Text = "Silly Is Here! HIDEEEE!!!!"
wait(0.03)
Message.Text = "RILLY Rs Rere! HIDE!!EEE!!!!"
wait(0.03)
Message.Text = "RUY RU RUe! HID!!!!EEEE!!!!"
wait(0.03)
Message.Text = "RUN RUN RUN! HIDEEE!!!E!!!!"
end)

Silly=New("Model",workspace,"Silly",{})
Humanoid=New("Humanoid",Silly,"Humanoid",{MaxHealth=5000,WalkSpeed=45,UseJumpPower=true,JumpPower=100,RequiresNeck=false,HipHeight=-2})
Humanoid.Health=Humanoid.MaxHealth
HumanoidRootPart=New("Part",Silly,"HumanoidRootPart",{BrickColor=BrickColor.new('Maroon'),Transparency=1,Anchored=true,CanCollide=false,Material=Enum.Material.Sandstone,Size = Vector3.new(3, 10, 3)})
Torso=New("Part",Silly,"Torso",{BrickColor=BrickColor.new('Maroon'),Anchored=false,CanCollide=false,Material=Enum.Material.Sandstone,Size = Vector3.new(3, 10, 3)})
Root=New("Motor6D", HumanoidRootPart,"Root Hip",{Part0=HumanoidRootPart,Part1=Torso})
Head=New("Part",Silly,"Head",{BrickColor=BrickColor.new('Maroon'),Anchored=false,CanCollide=false,Material=Enum.Material.Sandstone,Size=Vector3.new(3,3,3)})
Face=New("Decal",Head,"face",{Texture="http://www.roblox.com/asset/?id=15203609338"})
Neck=New("Motor6D",Torso,"Neck",{Part0=Torso,Part1=Head,C0=CFrame.new(0, 6.5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)})
LeftArm=New("Part",Silly,"Left Arm",{BrickColor=BrickColor.new('Maroon'),Transparency=0,Anchored=false,CanCollide=false,Material=Enum.Material.Sandstone,Size = Vector3.new(2, 15, 2)})
LeftShoulder=New("Motor6D",Torso,"Left Shoulder",{Part0=Torso,Part1=LeftArm,C0 = CFrame.new(2.5, 3, 0, -4.37113883e-08, 0, -1, 0, 0.99999994, 0, 1, 0, -4.37113883e-08),C1=CFrame.new(0, 5, 0, -4.37113883e-08, 0, -1, 0, 0.99999994, 0, 1, 0, -4.37113883e-08)})
RightArm=New("Part",Silly,"Right Arm",{BrickColor=BrickColor.new('Maroon'),Transparency=0,Anchored=false,CanCollide=false,Material=Enum.Material.Sandstone,Size = Vector3.new(2, 15, 2)})
RightShoulder=New("Motor6D",Torso,"Right Shoulder",{Part0=Torso,Part1=RightArm,C0 = CFrame.new(-2.5, 3, 0, -4.37113883e-08, 0, 1, -0, 0.99999994, 0, -1, 0, -4.37113883e-08),C1=CFrame.new(0, 5, 0, -4.37113883e-08, 0, 1, 0, 0.99999994, 0, -1, 0, -4.37113883e-08)})
RightLeg=New("Part",Silly,"Right Leg",{BrickColor=BrickColor.new('Maroon'),Transparency=0,Anchored=false,CanCollide=false,Material=Enum.Material.Sandstone,Size = Vector3.new(2, 15, 2)})
RightHip=New("Motor6D",Torso,"Right Hip",{Part0=Torso,Part1=RightLeg,C0 = CFrame.new(-0.5, -5, 0, -4.37113883e-08, 0, 1, -0, 0.99999994, 0, -1, 0, -4.37113883e-08),C1=CFrame.new(0, 6, 0, -4.37113883e-08, 0, 1, 0, 0.99999994, 0, -1, 0, -4.37113883e-08),MaxVelocity=0.8})
LeftLeg=New("Part",Silly,"Left Leg",{BrickColor=BrickColor.new('Maroon'),Transparency=0,Anchored=false,CanCollide=false,Material=Enum.Material.Sandstone,Size = Vector3.new(2, 15, 2)})
LeftHip=New("Motor6D",Torso,"Left Hip",{Part0=Torso,Part1=LeftLeg,C0 = CFrame.new(0.5, -5, 0, -4.37113883e-08, 0, -1, 0, 0.99999994, 0, 1, 0, -4.37113883e-08),C1=CFrame.new(0, 6, 0, -4.37113883e-08, 0, -1, 0, 0.99999994, 0, 1, 0, -4.37113883e-08),MaxVelocity=0.8})
Silly.PrimaryPart=HumanoidRootPart

game.Debris:AddItem(Silly,200)

local Sound = Instance.new('Sound', HumanoidRootPart)
Sound.PlaybackSpeed = 0.699999988079071
Sound.SoundId = "rbxassetid://1244506786"
Sound.Looped = true
Sound.Volume = 1
Sound.RollOffMode = "Linear"
local CompressorSoundEffect = Instance.new('CompressorSoundEffect', Sound)
CompressorSoundEffect.Attack = 1
CompressorSoundEffect.GainMakeup = 10
CompressorSoundEffect.Ratio = 50
CompressorSoundEffect.Threshold = -35
local PitchShiftSoundEffect = Instance.new('PitchShiftSoundEffect', Sound)
PitchShiftSoundEffect.Octave = 0.5
local PitchShiftSoundEffect = Instance.new('PitchShiftSoundEffect', Sound)
PitchShiftSoundEffect.Octave = 0.5

local Idle = Instance.new('Sound', Torso)
Idle.Name = "Idle"


Idle.PlaybackSpeed = 2
Idle.RollOffMaxDistance = 300
Idle.RollOffMode = Enum.RollOffMode.Linear
Idle.SoundId = "rbxassetid://9043345732"
Idle.Volume = 0.09899999856948853
Idle.Looped = true
local DistortionSoundEffect = Instance.new('DistortionSoundEffect', Idle)
DistortionSoundEffect.Level = 1
local EchoSoundEffect = Instance.new('EchoSoundEffect', Idle)
EchoSoundEffect.Delay = 2.7950000762939453
EchoSoundEffect.DryLevel = -23.299999237060547
EchoSoundEffect.Feedback = 0.9200000166893005
EchoSoundEffect.WetLevel = -13.399999618530273
local EqualizerSoundEffect = Instance.new('EqualizerSoundEffect', Idle)
EqualizerSoundEffect.HighGain = 10
EqualizerSoundEffect.LowGain = -80
EqualizerSoundEffect.MidGain = 10
local PitchShiftSoundEffect = Instance.new('PitchShiftSoundEffect', Idle)
PitchShiftSoundEffect.Octave = 1.1449999809265137
local ReverbSoundEffect = Instance.new('ReverbSoundEffect', Idle)
Idle:Play()



local function canSeeTarget(Target,size)
					local origin = Head.Position
					local direction = (Target.HumanoidRootPart.Position - Head.Position).unit * size
					local ray = Ray.new(origin, direction)

					local hit, pos = workspace:FindPartOnRay(ray, Head)


					if hit then
						if hit:IsDescendantOf(target) then
							return true
						end
					else
						return false
					end
end
--!!

spawn(function()
   function waitForChild(parent, childName)
local child = parent:findFirstChild(childName)
if child then return child end
while true do
 child = parent.ChildAdded:wait()
 if child.Name==childName then return child end
end
end

-- ANIMATION

-- declarations

local Figure = Silly
local pose = "Standing"

local toolAnim = "None"
local toolAnimTime = 0

local jumpMaxLimbVelocity = 0.9

-- functions

function onRunning(speed)
if speed>0 then
 pose = "Running"
else
 pose = "Standing"
end
end

function onDied()
pose = "Dead"
end

function onJumping()
pose = "Jumping"
end

function onClimbing()
pose = "Climbing"
end

function onGettingUp()
pose = "GettingUp"
end

function onFreeFall()
pose = "FreeFall"
end

function onFallingDown()
pose = "FallingDown"
end

function onSeated()
pose = "Seated"
end

function onPlatformStanding()
pose = "PlatformStanding"
end

function onSwimming(speed)
if speed>0 then
 pose = "Running"
else
 pose = "Standing"
end
end

function moveJump()
RightShoulder.MaxVelocity = jumpMaxLimbVelocity
LeftShoulder.MaxVelocity = jumpMaxLimbVelocity
 RightShoulder:SetDesiredAngle(3.14)
LeftShoulder:SetDesiredAngle(-3.14)
RightHip:SetDesiredAngle(0)
LeftHip:SetDesiredAngle(0)
end


-- same as jump for now

function moveFreeFall()
RightShoulder.MaxVelocity = jumpMaxLimbVelocity
LeftShoulder.MaxVelocity = jumpMaxLimbVelocity
RightShoulder:SetDesiredAngle(3.14)
LeftShoulder:SetDesiredAngle(-3.14)
RightHip:SetDesiredAngle(0)
LeftHip:SetDesiredAngle(0)
end

function moveSit()
RightShoulder.MaxVelocity = 0.15
LeftShoulder.MaxVelocity = 0.15
RightShoulder:SetDesiredAngle(3.14 /2)
LeftShoulder:SetDesiredAngle(-3.14 /2)
RightHip:SetDesiredAngle(3.14 /2)
LeftHip:SetDesiredAngle(-3.14 /2)
end

function getTool()
for _, kid in ipairs(Figure:GetChildren()) do
 if kid.className == "Tool" then return kid end
end
return nil
end

function getToolAnim(tool)
for _, c in ipairs(tool:GetChildren()) do
 if c.Name == "toolanim" and c.className == "StringValue" then
  return c
 end
end
return nil
end

function animateTool()

if (toolAnim == "None") then
 RightShoulder:SetDesiredAngle(1.57)
 return
end

if (toolAnim == "Slash") then
 RightShoulder.MaxVelocity = 0.5
 RightShoulder:SetDesiredAngle(0)
 return
end

if (toolAnim == "Lunge") then
 RightShoulder.MaxVelocity = 0.9
 LeftShoulder.MaxVelocity = 0.9
 RightHip.MaxVelocity = 0.9
 LeftHip.MaxVelocity = 0.9
 RightShoulder:SetDesiredAngle(1.57)
 LeftShoulder:SetDesiredAngle(1.0)
 RightHip:SetDesiredAngle(1.57)
 LeftHip:SetDesiredAngle(1.0)
 return
end
end

function move(time)
local amplitude
local frequency
 
if (pose == "Jumping") then
 moveJump()
 return
end

if (pose == "FreeFall") then
 moveFreeFall()
 return
end

if (pose == "Seated") then
 moveSit()
 return
end

local climbFudge = 0

if (pose == "Running") then
   if (RightShoulder.CurrentAngle > 1.5 or RightShoulder.CurrentAngle -1.5) then
  RightShoulder.MaxVelocity = jumpMaxLimbVelocity
 else  
  RightShoulder.MaxVelocity = 0.15
 end
 if (LeftShoulder.CurrentAngle > 1.5 or LeftShoulder.CurrentAngle -1.5) then
  LeftShoulder.MaxVelocity = jumpMaxLimbVelocity
 else  
  LeftShoulder.MaxVelocity = 0.15
 end
 amplitude = 1
 frequency = 9
elseif (pose == "Climbing") then
 RightShoulder.MaxVelocity = 0.9
 LeftShoulder.MaxVelocity = 0.9
 amplitude = 1
 frequency = 9
 climbFudge = 3.14
else
 amplitude = 0.1
 frequency = 1
end

desiredAngle = amplitude * math.sin(time*frequency)

RightShoulder:SetDesiredAngle(desiredAngle + climbFudge)
LeftShoulder:SetDesiredAngle(desiredAngle - climbFudge)
RightHip:SetDesiredAngle(-desiredAngle)
LeftHip:SetDesiredAngle(-desiredAngle)


local tool = getTool()

if tool then

 animStringValueObject = getToolAnim(tool)

 if animStringValueObject then
  toolAnim = animStringValueObject.Value
  -- message recieved, delete StringValue
  animStringValueObject.Parent = nil
  toolAnimTime = time + .3
 end

 if time > toolAnimTime then
  toolAnimTime = 0
  toolAnim = "None"
 end

 animateTool()

 
else
 toolAnim = "None"
 toolAnimTime = 0
end
end


-- connect events

Humanoid.Died:connect(onDied)
Humanoid.Running:connect(onRunning)
Humanoid.Jumping:connect(onJumping)
Humanoid.Climbing:connect(onClimbing)
Humanoid.GettingUp:connect(onGettingUp)
Humanoid.FreeFalling:connect(onFreeFall)
Humanoid.FallingDown:connect(onFallingDown)
Humanoid.Seated:connect(onSeated)
Humanoid.PlatformStanding:connect(onPlatformStanding)
Humanoid.Swimming:connect(onSwimming)
-- main program

local runService = game:service("RunService");

while Figure.Parent~=nil do
local _, time = wait(0.1)
move(time)

if math.random(1,500) == 500 then
ohWHATTHEFU=New("Sound",Head,"Silly Scream",{Volume = 10,RollOffMode = "Linear",RollOffMaxDistance = 500})
ohWHATTHEFU:Play()
game.Debris:AddItem(ohWHATTHEFU,9)
end

end

end)

HumanoidRootPart.Anchored = false
Silly:PivotTo(spawnlocation.CFrame*CFrame.new(0,20,0))

if morph then
game.Players.LocalPlayer.Character = Silly
game.Workspace.CurrentCamera.CameraSubject = Silly

Sound:Play()

connect = game:GetService("RunService").RenderStepped:Connect(function()
--workspace:FindFirstChild(game.Players.LocalPlayer.Name):PivotTo(HumanoidRootPart.CFrame*CFrame.new(0,-50,0))
end)

Humanoid.Died:Connect(function()
Silly:Destroy()
connect:Disconnect()
game.Players.LocalPlayer.Character=workspace:FindFirstChild(game.Players.LocalPlayer.Name)
end)

return
end
spawn(function() wait(3)
Sound:Play()
if usePathfind then
while game:GetService("RunService").RenderStepped:Wait() do

    if Humanoid.Health<0 then
    target=nil
           Humanoid:Destroy()
           Torso.CanCollide = false
           Head.CanCollide = false
           game.Debris:AddItem(Silly,5)
       break
    end

    if target then
       local path = pathFindingS:CreatePath()
       path:ComputeAsync(Torso.Position,Character.Head.Position)

       local waypoints = path:GetWaypoints()

    if waypoints then
       for _,waypoint in pairs(waypoints) do
       
 --           Ball=New("Part",workspace,"Waypoint",{Shape="Ball",Anchored=true,CanCollide=false,Position=waypoint.Position,Material="Neon",Size=Vector3.new(0.6,0.6,0.6)}) game.Debris:AddItem(Ball,3)
            if waypoint.Action == Enum.PathWaypointAction.Jump then
                Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end

            Humanoid:MoveTo(waypoint.Position)
            Humanoid.MoveToFinished:Wait()
       end
       else
       Humanoid:MoveTo(Character.Head.Position)
       Humanoid.MoveToFinished:Wait()
    end

      else

      end
      if canSeeTarget(Character,520) then
        target=Character
      else
        target=nil
      end
      if (Character.Head.Position-Torso.Position).Magnitude < 20 then
         spawn(function()
            debounce=true
            
            Character.Humanoid:TakeDamage(10)
            wait(0.8)
            debounce=false
         end)
         if Character.Humanoid.Health <= 0 then
           target=nil
           Humanoid:Destroy()
           Torso.CanCollide = false
           Head.CanCollide = false
           game.Debris:AddItem(Silly,5)
         end
      end
end

else

while wait() do
     if target then
     Humanoid:MoveTo(Character.Head.Position)
     else
     
     end
      if canSeeTarget(Character,520) then
        target=Character
      else
        target=nil
      end
      if (Character.Head.Position-Torso.Position).Magnitude < 20 then
         spawn(function()
            debounce=true
            RightShoulder:SetDesiredAngle(1 + 5)
            LeftShoulder:SetDesiredAngle(1 - 5)
            Character.Humanoid:TakeDamage(10)
            wait(0.8)
            debounce=false
         end)
         if Character.Humanoid.Health <= 0 then
           target=nil
           Humanoid:Destroy()
           Torso.CanCollide = false
           Head.CanCollide = false
           game.Debris:AddItem(Silly,5)
         end
      end
end

end

end)


--]]
