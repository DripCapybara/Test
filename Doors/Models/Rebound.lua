local Rebound = Instance.new('Model')
local Speed = Instance.new('IntValue', Rebound)
local ShakeStrength = Instance.new('IntValue', Rebound)
local RoomInside = Instance.new('IntValue', Rebound)
local TimesBounced = Instance.new('IntValue', Rebound)
local endNodes = Instance.new('BindableEvent', Rebound)
local KillDistance = Instance.new('IntValue', Rebound)
local KillBadge = Instance.new('IntValue', Rebound)
local Arrival = Instance.new('Sound', Rebound)
local ReboundTimes = Instance.new('IntValue', Rebound)
local NeedsLOS = Instance.new('BoolValue', Rebound)
local Damage = Instance.new('IntValue', Rebound)
local Root = Instance.new('Part', Rebound)
local Idle = Instance.new('Sound', Root)
local EqualizerSoundEffect = Instance.new('EqualizerSoundEffect', Idle)
local ReboundTimes = Instance.new('IntValue', Rebound)
local Attachment = Instance.new('Attachment', Root)
local Lines = Instance.new('ParticleEmitter', Attachment)
local Smoke = Instance.new('ParticleEmitter', Attachment)
local Entity = Instance.new('ParticleEmitter', Attachment)
local BillboardGui = Instance.new('BillboardGui', Root)
local ImageLabel = Instance.new('ImageLabel', BillboardGui)
local PointLight = Instance.new('PointLight', Root)
local PointLight2 = Instance.new('PointLight', Root)
Rebound.Name = "Rebound"
RoomInside.Name = "RoomInside"
RoomInside.Value = game.ReplicatedStorage.GameData.LatestRoom.Value
ShakeStrength.Name = "ShakeStrength"
ShakeStrength.Value = 100
Speed.Name = "Speed"
Speed.Value = math.random(90,150)
TimesBounced.Name = "TimesBounced"
endNodes.Name = "endNodes"
KillDistance.Name = "KillDistance"
KillDistance.Value = 59
KillBadge.Name = "KillBadge"
KillBadge.Value = 2128765396
Arrival.Name = "Arrival"
Arrival.SoundId = "rbxassetid://9114397505"
local distort = Instance.new("DistortionSoundEffect")
distort.Parent = Arrival
distort.Level = 1
local distort2 = Instance.new("DistortionSoundEffect")
distort2.Parent = Arrival
distort2.Level = 1
local dist3 = Instance.new("DistortionSoundEffect",Arrival)
local pitch = Instance.new("PitchShiftSoundEffect")
pitch.Parent = Arrival
pitch.Octave = 0.5
local pitch2 = Instance.new("PitchShiftSoundEffect")
pitch2.Parent = Arrival
pitch2.Octave = 0.5
local pitch3 = Instance.new("PitchShiftSoundEffect")
pitch3.Parent = Arrival
pitch3.Octave = 0.5
Arrival:Play()
Damage.Name = "Damage"
Damage.Value = 100
NeedsLOS.Name = "NeedsLOS"
ReboundTimes.Name = "ReboundTimes"
Root.Name = "Root"
Root.BottomSurface = Enum.SurfaceType.Smooth
Root.CanCollide = false
Root.Rotation = Vector3.new(0, -90, 0)
Root.Size = Vector3.new(2, 2, 1)
Root.TopSurface = Enum.SurfaceType.Smooth
Root.Transparency = 1
Root.Anchored = true
Idle.Name = "Idle"
Idle.RollOffMaxDistance = 300
Idle.RollOffMinDistance = 0.30000001192092896
Idle.RollOffMode = Enum.RollOffMode.Linear
Idle.SoundId = "no u"
EqualizerSoundEffect.HighGain = -80
EqualizerSoundEffect.LowGain = 10
EqualizerSoundEffect.MidGain = 10
Attachment.CFrame = CFrame.new(0, 2.896487, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
Lines.Name = "Lines"
Lines.Brightness = 45
local color1 = {
	ColorSequenceKeypoint.new(0,Color3.new(0,1,1),0),
	ColorSequenceKeypoint.new(1,Color3.new(0,0.215685,1),0)
}
Lines.Color = ColorSequence.new(color1)
Lines.Lifetime = NumberRange.new(0.02 ,0.02 )
Lines.LightEmission = 1
Lines.Rate = 10
Lines.RotSpeed = NumberRange.new(-360 ,360 )
Lines.Rotation = NumberRange.new(-360 ,360 )
local size1 = {
	NumberSequenceKeypoint.new(0,10,0),
	NumberSequenceKeypoint.new(1,10,0)
}
Lines.Size = NumberSequence.new(size1)
Lines.Speed = NumberRange.new(0 ,0 )
local squash1 = {
	NumberSequenceKeypoint.new(0,0,0),
	NumberSequenceKeypoint.new(0.396639,0,0),
	NumberSequenceKeypoint.new(0.49916,0.0375001,2.1),
	NumberSequenceKeypoint.new(0.601681,-0.0375001,0),
	NumberSequenceKeypoint.new(1,0,0)
}
Lines.Squash = NumberSequence.new(squash1)
Entity.Name = "Entity"
local color2 = {
	ColorSequenceKeypoint.new(0,Color3.new(0.45098, 0.643137,1),0),
	ColorSequenceKeypoint.new(0.437716,Color3.new(0.0235294,0.168627,1),0),
	ColorSequenceKeypoint.new(0.629758,Color3.new(0,0.827451,0.619608),0),
	ColorSequenceKeypoint.new(0.67301,Color3.new(1,0,0),0),
	ColorSequenceKeypoint.new(0.707612,Color3.new(0.756863,0.847059,0.976471),0),
	ColorSequenceKeypoint.new(1,Color3.new(0.192157,0.117647,1),0)
}
Entity.Color = ColorSequence.new(color2)
Entity.Lifetime = NumberRange.new(0.04 ,0.04 )
Entity.LightEmission = 0.10000000149011612
Entity.LightInfluence = 1
Entity.Rate = 500
Entity.RotSpeed = NumberRange.new(-7 ,7 )
Entity.Rotation = NumberRange.new(-0.5 ,0.5 )
local size2 = {
	NumberSequenceKeypoint.new(0,4,0),
	NumberSequenceKeypoint.new(1,4,0)
}
Entity.Size = NumberSequence.new(size2)
Entity.Speed = NumberRange.new(-50, 50 )
Entity.SpreadAngle = Vector2.new(-360, 360)
local squash2 = {
	NumberSequenceKeypoint.new(0,0,0),
	NumberSequenceKeypoint.new(0.198971,0.0128753, 0),
	NumberSequenceKeypoint.new(0.297599, 0.218884,0),
	NumberSequenceKeypoint.new(0.397084, -0.11588, 0),
	NumberSequenceKeypoint.new(0.443396, 0.0386267, 0),
	NumberSequenceKeypoint.new(0.487993, -0.0386267, 0),
	NumberSequenceKeypoint.new(0.501715, 0.270386, 0),
	NumberSequenceKeypoint.new(0.517153, -0.0128756, 0),
	NumberSequenceKeypoint.new(0.691252, 0.218884, 0),
	NumberSequenceKeypoint.new(0.744425, 0.0901287, 0),
	NumberSequenceKeypoint.new(0.807033, -0.0643778, 0),
	NumberSequenceKeypoint.new(0.866209, 0.399142, 0),
	NumberSequenceKeypoint.new(0.897942, 0.0901287, 0),
	NumberSequenceKeypoint.new(1,0,0)
}
Entity.Squash = NumberSequence.new(squash2)
Entity.Texture = "rbxassetid://13272951808"
local transparency1 = {
	NumberSequenceKeypoint.new(0,0,0),
	NumberSequenceKeypoint.new(0.499253, 0.6, 0),
	NumberSequenceKeypoint.new(1,0,0)
}
Entity.Transparency = NumberSequence.new(transparency1)
Entity.ZOffset = 1
Smoke.Name = "Smoke"
Smoke.Acceleration = Vector3.new(0, -0.10000000149011612, 0)
local color3 = {
	ColorSequenceKeypoint.new(0,Color3.new(0.968627,0.968627,0.968627),0),
 ColorSequenceKeypoint.new(1,Color3.new(0.0156863, 0.0666667,0.968627),0)
}
Smoke.Color = ColorSequence.new(color3)
Smoke.Drag = 2
Smoke.Lifetime = NumberRange.new(0.1 ,0.8 )
Smoke.LightEmission = 2
Smoke.Rate = 80
Smoke.RotSpeed = NumberRange.new(-50 ,50 )
Smoke.Rotation = NumberRange.new(-360 ,360 )
local size3 = {
	NumberSequenceKeypoint.new(0,5,0),
	NumberSequenceKeypoint.new(0.427914,6,0),
	NumberSequenceKeypoint.new(1,0,0)
}
Smoke.Size = NumberSequence.new(size3)
Smoke.Speed = NumberRange.new(-10 ,10 )
Smoke.SpreadAngle = Vector2.new(-100, 100)
Smoke.Texture = "rbxassetid://4770542473"
local transparency2 = {
	NumberSequenceKeypoint.new(0,0,0),
	NumberSequenceKeypoint.new(0.473094,0.33125,0),
	NumberSequenceKeypoint.new(0.846039,0.45,0.08125),
	NumberSequenceKeypoint.new(1,1,0)
}
Smoke.Transparency = NumberSequence.new(transparency2)
BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
BillboardGui.Brightness = 4
BillboardGui.Size = UDim2.new(8, 0, 8, 0)
BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
BillboardGui.Enabled = false
PointLight2.Name = "PointLight2"
PointLight2.Brightness = 200
PointLight2.Color = Color3.new(0.219608, 0.0235294, 1)
PointLight2.Range = 10
PointLight.Brightness = 15
PointLight.Color = Color3.new(0, 0.784314, 1)
PointLight.Range = 40
ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
ImageLabel.BackgroundTransparency = 1
ImageLabel.Size = UDim2.new(1, 0, 1, 0)
ImageLabel.Image = "rbxassetid://10914800940"
return Rebound
