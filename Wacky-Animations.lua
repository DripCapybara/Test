-- Wacky Anims for Roblox
-- FE
-- Made By DripCapybara

function yum()

local function waitForChild(parent, childName)
local child = parent:findFirstChild(childName)
if child then return child end
while true do
 child = parent.ChildAdded:wait()
 if child.Name==childName then return child end
end
end

local function findFirstChild(p,c)

for _,v in pairs(p:GetDescendants()) do
if string.match(c,v.Name) then
return v
end
end

end

local Figure = game.Players.LocalPlayer.Character
local Torso = findFirstChild(Figure,"Torso")
local RightShoulder = findFirstChild(Torso, "Right Shoulder")
local LeftShoulder = findFirstChild(Torso, "Left Shoulder")
local RightHip = findFirstChild(Torso, "Right Hip")
local LeftHip = findFirstChild(Torso, "Left Hip")
local Neck = findFirstChild(Torso, "Neck")
local Humanoid = findFirstChild(Figure, "Humanoid")
local pose = "Standing"

local toolAnim = "None"
local toolAnimTime = 0

local jumpMaxLimbVelocity = 0.75

for _,v in pairs(Humanoid:GetPlayingAnimationTracks()) do
if v then
v:Stop()
end
end

if Figure:FindFirstChild("Animate") then
Figure.Animate.Enabled = false
end


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

local sitTime = 0


spawn(function()
while wait() do
sitTime+=0.10
end
end)

function moveSit()
RightShoulder.MaxVelocity = 0.15
LeftShoulder.MaxVelocity = 0.15
RightShoulder:SetDesiredAngle(3.14 /2+sitTime)
LeftShoulder:SetDesiredAngle(3.14 /2+sitTime)
RightHip:SetDesiredAngle(math.sin(sitTime))
LeftHip:SetDesiredAngle(math.sin(sitTime))
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
 RightShoulder.MaxVelocity = 1
 LeftShoulder.MaxVelocity = 1
 RightHip.MaxVelocity = 1
 LeftHip.MaxVelocity = 1
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
  RightShoulder.MaxVelocity = 1
 end
 if (LeftShoulder.CurrentAngle > 1.5 or LeftShoulder.CurrentAngle -1.5) then
  LeftShoulder.MaxVelocity = jumpMaxLimbVelocity
 else  
  LeftShoulder.MaxVelocity = 1
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
 frequency = 0.95
end

if pose == "Standing" then
amplitude = 0.2 / 10
frequency = 999
time += 0.01
end

desiredAngle = amplitude * math.sin(time*frequency) * 2

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
local _, time = wait(0)
move(time)
end

end

yum()
