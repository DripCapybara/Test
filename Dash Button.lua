-- Dash Button
-- FE
-- Made By DripCapybara

if game.Players.LocalPlayer.PlayerGui:FindFirstChild("DashButton") then
game.Players.LocalPlayer.PlayerGui.DashButton:Destroy()
end

local bool = false
local delay = 2

local screengui = Instance.new("ScreenGui")
local button = Instance.new("TextButton")

local plr = game.Players.LocalPlayer
local chr = plr.Character or plr.CharacterAdded:Wait()

screengui.Name = "DashButton"
screengui.Parent = plr.PlayerGui

button.Name = "Button"
button.Size = UDim2.new(0, 70, 0, 50)
button.Position = UDim2.new(0.5, 230, 0.5, 100)
button.BackgroundColor3 = Color3.fromRGB(255,255,255)
button.BorderSizePixel = 5
button.Draggable = true
button.TextScaled = true
button.Text = "Dash"
button.Parent = screengui

button.MouseButton1Click:Connect(function()
if bool==false then
bool=true
chr.Humanoid.Jump = true
local root = game.Players.LocalPlayer.Character.HumanoidRootPart
root.Velocity = root.CFrame.LookVector * 50
for i = 1,delay do
button.Text = tostring(i)
wait(1)
end
button.Text = "Dash"
bool=false
elseif bool==true then
return
end
end)
