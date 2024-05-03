-- Plank/Hammer troll for GEF
-- Made By DripCapybara

-- (Hammer Needed)

local Player = game.Players.LocalPlayer

local MainGUI = Instance.new('ScreenGui', game.CoreGui)

MainGUI.Name = "MainGUI"

local Frame = Instance.new('Frame', MainGUI)

Frame.BackgroundColor3 = Color3.new(0, 0, 0)
Frame.BorderColor3 = Color3.new(0.509434, 0.792453, 1)
Frame.BorderSizePixel = 5
Frame.Position = UDim2.new(0, 700, 0, 200)
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Draggable = true

local TextButton = Instance.new('TextButton', Frame)

TextButton.BackgroundTransparency = 1
TextButton.Position = UDim2.new(0, 0, 0, 75)
TextButton.Size = UDim2.new(0, 200, 0, 50)
TextButton.Text = "Off"
TextButton.TextScaled = true
TextButton.TextColor3 = Color3.new(0.623116, 0, 0)

local Title = Instance.new('TextLabel', Frame)

Title.Name = "Title"
Title.BackgroundTransparency = 1
Title.BorderColor3 = Color3.new(0.179198, 0.278752, 0.351759)
Title.BorderSizePixel = 3
Title.Size = UDim2.new(0, 200, 0, 25)
Title.Text = "GEF"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextScaled = true

------ -------- ------- --------
local Speed = 1
local IsFocused = false
local last = false

local UserInputService = game:GetService("UserInputService")
local dragging,dragInput,dragStart,startPos

local function UpdatePos(input)
	local delta = input.Position - dragStart
	Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
Frame.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		dragging =true
		dragStart =input.Position
		startPos =Frame.Position
		input.Changed:Connect(function()
			if( input.UserInputState == (Enum.UserInputState.End)) then
				dragging = false
			end
		end)
	end
end)
Frame.InputChanged:Connect(function(input)
	if (input.UserInputType == (Enum.UserInputType.MouseMovement) or input.UserInputType == (Enum.UserInputType.Touch)) then
		dragInput = input
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if (input == dragInput and dragging) then
		UpdatePos(input)
	end
end)

local Active = false

TextButton.MouseButton1Click:Connect(function()
if Active == false then
Active = true
last = Active
TextButton.Text = "On"
elseif Active == true then
Active = false
last = Active
TextButton.Text = "Off"
end
end)



game:GetService("RunService").RenderStepped:Connect(function()
 if Active then
local args = {
    [1] = game.Players.LocalPlayer.Character.Head.Position,
    [2] = game.Players.LocalPlayer.Character.Head.Position,
    [3] = workspace:WaitForChild("Buildings"):WaitForChild("Shop4"):WaitForChild("Part"),
    [4] = workspace:WaitForChild("Road"):WaitForChild("Part"),
    [5] = Vector3.zAxis
}

game:GetService("Players").LocalPlayer.Character.Hammer.BuildPlank:FireServer(unpack(args))
 end
end)
