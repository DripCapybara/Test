local script = game.ReplicatedStorage.ClientModules.EntityModules.Shade
local v1 = {};
local v2 = game:GetService("ReplicatedStorage").Misc.Eyes:GetChildren();
v1.module_events = require(script.Parent.Parent.Module_Events);
local l__TweenService__1 = game:GetService("TweenService");
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
		p1.camShaker:ShakeOnce(4, 15, 0.4, 1);
		p1.camShaker:ShakeOnce(2, 6, 0.6, 1);
		p1.camShaker:ShakeOnce(18, 0.5, 5, 20);
		p1.camShaker:ShakeOnce(3, 12, 5, 20);
		script.Music:Play();
		l__TweenService__1:Create(game:GetService("Lighting"), TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
			FogEnd = 0, 
			FogStart = 0, 
			FogColor = Color3.new(0, 0.1, 0.1), 
			Ambient = Color3.new(0, 0.219608, 0.243137)
		}):Play();
		wait(1);
		p1.hideplayers = 1;
		game:GetService("Lighting").Ambience_Shade.Enabled = true;
		l__TweenService__1:Create(game:GetService("Lighting"), TweenInfo.new(5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			FogEnd = 60, 
			FogStart = 15, 
			FogColor = Color3.new(0, 0, 0)
		}):Play();
		local l__LocalPlayer__3 = game.Players.LocalPlayer;
		local l__Character__4 = l__LocalPlayer__3.Character;
		local l__PrimaryPart__5 = l__Character__4.PrimaryPart;
		local l__LookVector__6 = p2.RoomEntrance.CFrame.LookVector;
		local v7 = Ray.new(p2.RoomEntrance.Position + Vector3.new(0, 1, 0), l__LookVector__6);
		local l__Jumpscare_Shade__8 = l__LocalPlayer__3.PlayerGui.MainUI.Jumpscare_Shade;
		l__Jumpscare_Shade__8.Visible = true;
		l__LocalPlayer__3.Character:SetPrimaryPartCFrame(CFrame.new(p2.RoomEntrance.CFrame.Position + l__LookVector__6 * 10, p2.RoomEntrance.CFrame.Position + l__LookVector__6 * 20));
		wait(0.5);
		local v9 = game:GetService("ReplicatedStorage").Entities:WaitForChild("Shade"):Clone();
		v9.CFrame = p1.cam.CFrame + Vector3.new(0, 1000, 0);
		local u3 = l__LookVector__6;
		local u4 = tick() + 4;
		task.delay(2, function()
			local u5 = nil;
			spawn(function()
				if u5 then
					game:GetService("ReplicatedStorage"):FindFirstChild("Bricks"):FindFirstChild("ShadeResult"):FireServer(u5);
				end;
				if u3 == l__LookVector__6 then
					u4 = tick() + math.random(30, 70) / 10;
					script.Sound.Pitch = math.random(100, 130) / 100;
					v9.WhisperWeird.Pitch = math.random(50, 70) / 100;
				else
					u4 = tick() + math.random(20, 40) / 10;
					script.Sound.Pitch = math.random(50, 70) / 100;
					v9.WhisperWeird.Pitch = math.random(100, 120) / 100;
				end;
				script.Sound.TimePosition = 0.2;
				script.Sound:Play();
				u3 = -u3;
				local v10 = v7:ClosestPoint(l__LocalPlayer__3.Character.PrimaryPart.Position + Vector3.new(0, 2, 0) + u3 * 45);
				if v9.Parent == p1.cam then
					v9.BodyPosition.Position = v9.Position + Vector3.new(0, 100, 0);
					wait(0.5);
					v9.CFrame = CFrame.new(v10 + Vector3.new(0, 50, 0));
				else
					v9.CFrame = CFrame.new(v10 + Vector3.new(0, 50, 0));
				end;
				local v11 = 40 / (u4 - tick());
				v9.BodyVelocity.Velocity = Vector3.new(0, 0, 0);
				v9.BodyPosition.Position = v10;
				wait(0.5);
				v9.BodyVelocity.Velocity = u3 * -v11;
			end);
		end);
		v9.Parent = p1.cam;
		for v12, v13 in pairs(v9:GetChildren()) do
			if v13:IsA("Sound") then
				v13:Play();
			end;
		end;
		local u6 = false;
		local u7 = nil;
		u7 = l__LocalPlayer__3:GetAttributeChangedSignal("CurrentRoom"):Connect(function()
			u6 = true;
			u7:Disconnect();
		end);
		while true do
			task.wait(0.016666666666666666);
			local l__Magnitude__14 = (v9.Position - l__PrimaryPart__5.Position).Magnitude;
			local l__Magnitude__15 = (l__PrimaryPart__5.Position - p2.RoomExit.Position).Magnitude;
			local l__Magnitude__16 = (l__PrimaryPart__5.Position - p2.RoomExit.Position).Magnitude;
			l__Jumpscare_Shade__8.Static.Position = UDim2.new(math.random(0, 1000) / 1000, 0, math.random(0, 1000) / 1000, 0);
			l__Jumpscare_Shade__8.Static.Rotation = 180 * math.random(0, 1);
			local v17
			if math.random(1, 2) == 2 then
				v17 = "rbxassetid://8681113503";
			else
				v17 = "rbxassetid://8681113666";
			end;
			l__Jumpscare_Shade__8.Static.Image = v17;
			l__Jumpscare_Shade__8.Static.ImageTransparency = 1 + l__Magnitude__14 / 80;
			l__Jumpscare_Shade__8.Eyes.Visible = false;
			l__Jumpscare_Shade__8.Overlay.Visible = false;
			if u6 then
				break;
			end;
			if l__Character__4.Humanoid.health < 0.1 then
				break;
			end;
			if l__Magnitude__16 < 4 then
				u6 = true;
				u7:Disconnect();
			end
			if l__Magnitude__14 < 30 then
				if math.random(1, 55) == 5 then
					l__Jumpscare_Shade__8.Overlay.Position = UDim2.new(math.random(0, 1000) / 1000, 0, math.random(0, 1000) / 1000, 0);
					l__Jumpscare_Shade__8.Overlay.Visible = true;
				else
					l__Jumpscare_Shade__8.Overlay.Visible = false;
				end;
				if math.random(1, 45) == 5 then
					l__Jumpscare_Shade__8.Eyes.Position = UDim2.new(math.random(450, 550) / 1000, 0, math.random(450, 550) / 1000, 0);
					l__Jumpscare_Shade__8.Eyes.Visible = true;
				else
					l__Jumpscare_Shade__8.Eyes.Visible = false;
				end;
			end;
			if l__Magnitude__14 < 8 then
				v9.CFrame = v9.CFrame + Vector3.new(0, 50, 0);
				local u8 = true;
				spawn(function()
					if u8 then
						game:GetService("ReplicatedStorage"):FindFirstChild("Bricks"):FindFirstChild("ShadeResult"):FireServer(u8);
					end;
					if u3 == l__LookVector__6 then
						u4 = tick() + math.random(30, 70) / 10;
						script.Sound.Pitch = math.random(100, 130) / 100;
						v9.WhisperWeird.Pitch = math.random(50, 70) / 100;
					else
						u4 = tick() + math.random(20, 40) / 10;
						script.Sound.Pitch = math.random(50, 70) / 100;
						v9.WhisperWeird.Pitch = math.random(100, 120) / 100;
					end;
					script.Sound.TimePosition = 0.2;
					script.Sound:Play();
					u3 = -u3;
					local v18 = v7:ClosestPoint(l__LocalPlayer__3.Character.PrimaryPart.Position + Vector3.new(0, 2, 0) + u3 * 45);
					if v9.Parent == p1.cam then
						v9.BodyPosition.Position = v9.Position + Vector3.new(0, 100, 0);
						wait(0.5);
						v9.CFrame = CFrame.new(v18 + Vector3.new(0, 50, 0));
					else
						v9.CFrame = CFrame.new(v18 + Vector3.new(0, 50, 0));
					end;
					local v19 = 40 / (u4 - tick());
					v9.BodyVelocity.Velocity = Vector3.new(0, 0, 0);
					v9.BodyPosition.Position = v18;
					wait(0.5);
					v9.BodyVelocity.Velocity = u3 * -v19;
				end);
				script.SoundHurt:Play();
				u8 = 1;
				for u8 = u8, 15 do
					task.wait(0.05);
					l__Jumpscare_Shade__8.Overlay.Position = UDim2.new(math.random(0, 1000) / 1000, 0, math.random(0, 1000) / 1000, 0);
					l__Jumpscare_Shade__8.Overlay.Visible = true;
					l__Jumpscare_Shade__8.Static.Position = UDim2.new(math.random(0, 1000) / 1000, 0, math.random(0, 1000) / 1000, 0);
					l__Jumpscare_Shade__8.Static.Rotation = 180 * math.random(0, 1);
					local v20
					if math.random(1, 2) == 2 then
						v20 = "rbxassetid://8681113503";
					else
						v20 = "rbxassetid://8681113666";
					end;
					l__Jumpscare_Shade__8.Static.Image = v20;
					l__Jumpscare_Shade__8.Static.ImageTransparency = math.random(1, 5) / 10;
					l__Jumpscare_Shade__8.Eyes.Visible = true;
					if math.random(1, 2) == 2 then
						l__Jumpscare_Shade__8.Eyes.Position = UDim2.new(math.random(450, 550) / 1000, 0, math.random(450, 550) / 1000, 0);
					end;
				end;
				l__Jumpscare_Shade__8.Eyes.Visible = false;
				l__Jumpscare_Shade__8.Overlay.Visible = false;
			elseif u4 <= tick() then
				local u9 = false;
				spawn(function()
					if u9 then
						game:GetService("ReplicatedStorage"):FindFirstChild("Bricks"):FindFirstChild("ShadeResult"):FireServer(u9);
					end;
					if u3 == l__LookVector__6 then
						u4 = tick() + math.random(30, 70) / 10;
						script.Sound.Pitch = math.random(100, 130) / 100;
						v9.WhisperWeird.Pitch = math.random(50, 70) / 100;
					else
						u4 = tick() + math.random(20, 40) / 10;
						script.Sound.Pitch = math.random(50, 70) / 100;
						v9.WhisperWeird.Pitch = math.random(100, 120) / 100;
					end;
					script.Sound.TimePosition = 0.2;
					script.Sound:Play();
					u3 = -u3;
					local v21 = v7:ClosestPoint(l__LocalPlayer__3.Character.PrimaryPart.Position + Vector3.new(0, 2, 0) + u3 * 45);
					if v9.Parent == p1.cam then
						v9.BodyPosition.Position = v9.Position + Vector3.new(0, 100, 0);
						wait(0.5);
						v9.CFrame = CFrame.new(v21 + Vector3.new(0, 50, 0));
					else
						v9.CFrame = CFrame.new(v21 + Vector3.new(0, 50, 0));
					end;
					local v22 = 40 / (u4 - tick());
					v9.BodyVelocity.Velocity = Vector3.new(0, 0, 0);
					v9.BodyPosition.Position = v21;
					wait(0.5);
					v9.BodyVelocity.Velocity = u3 * -v22;
				end);
				u9 = 1;
				for u9 = u9, 4 do
					task.wait(0.05);
					l__Jumpscare_Shade__8.OverlayTurn.Position = UDim2.new(math.random(0, 1000) / 1000, 0, math.random(0, 1000) / 1000, 0);
					l__Jumpscare_Shade__8.OverlayTurn.Visible = true;
					l__Jumpscare_Shade__8.Static.Position = UDim2.new(math.random(0, 1000) / 1000, 0, math.random(0, 1000) / 1000, 0);
					l__Jumpscare_Shade__8.Static.Rotation = 180 * math.random(0, 1);
					local v23
					if math.random(1, 2) == 2 then
						v23 = "rbxassetid://8681113503";
					else
						v23 = "rbxassetid://8681113666";
					end;
					l__Jumpscare_Shade__8.Static.Image = v23;
					l__Jumpscare_Shade__8.Static.ImageTransparency = 0.4;
					if math.random(1, 4) == 2 then
						l__Jumpscare_Shade__8.Eyes.Position = UDim2.new(math.random(450, 550) / 1000, 0, math.random(450, 550) / 1000, 0);
						l__Jumpscare_Shade__8.Eyes.Visible = true;
					else
						l__Jumpscare_Shade__8.Eyes.Visible = false;
					end;
				end;
				l__Jumpscare_Shade__8.Eyes.Visible = false;
				l__Jumpscare_Shade__8.Overlay.Visible = false;
				l__Jumpscare_Shade__8.OverlayTurn.Visible = false;
			end;		
		end;
		p1.hideplayers = 0;
		script.Music:Stop();
		script.Sound.Pitch = math.random(150, 170) / 100;
		script.Sound.TimePosition = 0.2;
		script.Sound:Play();
		for v24 = 1, 2 do
			task.wait(0.05);
			l__Jumpscare_Shade__8.Overlay.Position = UDim2.new(math.random(0, 1000) / 1000, 0, math.random(0, 1000) / 1000, 0);
			l__Jumpscare_Shade__8.Overlay.Visible = true;
			l__Jumpscare_Shade__8.Static.Position = UDim2.new(math.random(0, 1000) / 1000, 0, math.random(0, 1000) / 1000, 0);
			l__Jumpscare_Shade__8.Static.Rotation = 180 * math.random(0, 1);
			local v25
			if math.random(1, 2) == 2 then
				v25 = "rbxassetid://8681113503";
			else
				v25 = "rbxassetid://8681113666";
			end;
			l__Jumpscare_Shade__8.Static.Image = v25;
			l__Jumpscare_Shade__8.Static.ImageTransparency = math.random(1, 5) / 10;
			l__Jumpscare_Shade__8.Eyes.Visible = true;
			l__Jumpscare_Shade__8.Eyes.Position = UDim2.new(math.random(450, 550) / 1000, 0, math.random(450, 550) / 1000, 0);
		end;
		l__Jumpscare_Shade__8.Eyes.Visible = false;
		l__Jumpscare_Shade__8.Overlay.Visible = false;
		l__Jumpscare_Shade__8.Visible = false;
		v9:Destroy();
		l__TweenService__1:Create(game:GetService("Lighting"), TweenInfo.new(5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			FogEnd = 2000, 
			FogStart = 50
		}):Play();
		game:GetService("Lighting").Ambience_Shade.Enabled = false;
	end);
end;
return v1;
