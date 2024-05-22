
local script = game.ReplicatedStorage.ClientModules.EntityModules.Glitch
local v1 = {};
local v2 = game:GetService("ReplicatedStorage").Misc.Eyes:GetChildren();
v1.module_events = require(script.Parent.Parent.Module_Events);
local l__TweenService__1 = game:GetService("TweenService");
local glitchSpeed = 0.7 -- 0.7
function v1.stuff(p1, p2, p3)
	local u2 = p3;
	spawn(function()
		if p1.dead == true then
			return;
		end;
		if not u2 then
			u2 = math.random(1, 500);
		end;
		u2 = Random.new(u2);
		local l__LocalPlayer__3 = game.Players.LocalPlayer;
		local l__PrimaryPart__4 = l__LocalPlayer__3.Character.PrimaryPart;
		local v5 = (p1.cam.CFrame.LookVector * Vector3.new(1, 0, 1)).unit * -1;
		local l__p__6 = p1.cam.CFrame.p;
	--	if not tonumber(p2.Name) or not l__LocalPlayer__3:GetAttribute("CurrentRoom") then
--			return;
--		end;
		l__TweenService__1:Create(p1.cam, TweenInfo.new(0.9, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {
			CFrame = CFrame.new(l__p__6 + v5 * 2, l__p__6 + v5 * 10)
		}):Play();
		l__PrimaryPart__4.Anchored = true;
		p1.stopcam = true;
		p1.hideplayers = 1;
		local v7 = game:GetService("ReplicatedStorage").Entities.Glitch:Clone();
		local v8 = l__PrimaryPart__4.Position + Vector3.new(0, 7, 0) + v5 * 150;
		v7:SetPrimaryPartCFrame(CFrame.new(v8, v8 - v5));
		v7.Parent = p1.cam;
		v7.Root.SoundHurt:Play();
		v7.AnimationController:LoadAnimation(v7.Animations.Run):Play(0);
		
		l__TweenService__1:Create(v7.Root, TweenInfo.new(glitchSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
			CFrame = CFrame.new(v8 - v5 * 140, v8 - v5 * 250)
		}):Play();
		p1.camShaker:ShakeOnce(4, 15, 1, 1);
		p1.camShaker:ShakeOnce(12, 3, 1, 1);
		game.Lighting.FogEnd = 1000;
		l__TweenService__1:Create(game:GetService("Lighting"), TweenInfo.new(glitchSpeed+0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
			FogEnd = 0, 
			FogStart = 0, 
			FogColor = Color3.new(0, 0, 0), 
			Ambient = Color3.new(0, 0, 0)
		}):Play();
		local v9 = workspace.CurrentRooms:FindFirstChild(l__LocalPlayer__3:GetAttribute("CurrentRoom"));
		if v9 and v9.Parent then
		--	task.spawn(function()
		--		for v10, v11 in pairs(v9:GetDescendants()) do
	--				if v11:IsA("BasePart") then
		--			s1=v11.CFrame
	--				s2=v11.BrickColor
		--			s3=v11.Transparency
	--					delay(math.random(10, 60) / 100, function()
	--						v11.CFrame = v11.CFrame + Vector3.new(math.random(-10, 10), math.random(-10, 10), math.random(-10, 10));
	--						v11.BrickColor = BrickColor.Random();
	--						v11.Transparency = 0.3;
		--				end);
	--					wait(1.4);
		--				v11.CFrame = s1
		--				v11.BrickColor = s2
		--				v11.Transparency = s3
	--				end;
	--			end;
	--		end);
		end;
		local u3 = tick() + 2;
		task.spawn(function()
			local v12 = l__LocalPlayer__3.PlayerGui.MainUI.MainFrame.GlitchEffect:Clone();
			for v13 = 1, 60 do
				for v14 = 1, 8 do
					local v15 = v12:Clone();
					v15.Name = "FakeGlitchLive";
					v15.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0);
					v15.Rotation = math.random(0, 1) * 180;
					v15.Visible = true;
					v15.Parent = l__LocalPlayer__3.PlayerGui.MainUI;
					game.Debris:AddItem(v15, math.random(1, 20) / 100);
				end;
				task.wait(0.016666666666666666);
				if u3 <= tick() then
					break;
				end;
			end;
		end);
		script.Sound:Play();
		wait(glitchSpeed-0.05);
		v7.AnimationController:LoadAnimation(v7.Animations.Attack):Play(0);
		game.Lighting.Ambience_Glitch.Enabled = true;
		task.wait(0.05);
		l__LocalPlayer__3.PlayerGui.MainUI.MainFrame.GlitchScreen.Visible = true;
		task.wait(0.1);
		task.wait(0.6)
		l__LocalPlayer__3.PlayerGui.MainUI.MainFrame.GlitchScreen.Visible = false;
		v7:Destroy();
		p1.camShaker:ShakeOnce(6, 3, 1, 1);
		p1.hideplayers = 0;
		l__TweenService__1:Create(game:GetService("Lighting"), TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			FogEnd = 60000, 
			FogStart = 15, 
			FogColor = Color3.new(0, 0, 0)
		}):Play();
		p1.stopcam = false;
		l__PrimaryPart__4.Anchored = false;
		task.wait(0.05);
		game.Lighting.Ambience_Glitch.Enabled = false;
	end);
end;

return v1;
