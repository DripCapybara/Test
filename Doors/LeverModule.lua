local v1 = {}

local u1 = game:GetObjects("rbxassetid://17271863184")[1]:FindFirstChildOfClass("Model")
u1.Timer:Destroy()
u1.Timer:Destroy()
u1.Wire1:Destroy()
u1.Wire2:Destroy()
u1.ActivateEventPrompt.Style = "Custom"

function v1.lever(p2, p3, p4, p5)
	local u3 = p4;
	spawn(function()
		local v3, v4 = pcall(function()
			if not u3 then
				u3 = math.random(1, 500);
			end;
			u3 = Random.new(u3);
			local v5 = {};
			local v6 = {};
			for v7, v8 in pairs(p2:GetDescendants()) do
				if v8:IsA("BasePart") then
					if v8.Name == "Wall" or v8.Name == "Wall_Strip" then
						table.insert(v5, v8);
					end;
					if v8.Name == "Carpet" then
						table.insert(v6, v8);
					end;
				end;
			end;
			if #v6 <= 0 then
				for v9, v10 in pairs(p2:GetDescendants()) do
					if v10:IsA("BasePart") and v10.Name == "Floor" then
						table.insert(v6, v10);
					end;
				end;
			end;
			local v11 = RaycastParams.new();
			v11.CollisionGroup = "CheckWallStuff";
			local v12 = RaycastParams.new();
			v12.CollisionGroup = "CheckWallStuff";
			
			local v13 = p3;
			for v14 = 1, 100 do
				local v15 = workspace:Raycast(v6[u3:NextInteger(1, #v6)].Position + Vector3.new(u3:NextInteger(-5, 5), u3:NextInteger(5, 11), u3:NextInteger(-5, 5)), CFrame.Angles(0, math.rad(u3:NextInteger(0, 360)), 0).LookVector * 150, v11);
				local v16 = Vector3.new(4, 2, 0);
				if v15 then
					local l__Position__17 = v15.Position;
					local l__Instance__18 = v15.Instance;
					local l__Normal__19 = v15.Normal;
					local v21
					local v22
					local v24 = true
					if l__Position__17 and l__Instance__18 and l__Instance__18.Anchored == true and (l__Instance__18.Name == "Wall" or l__Instance__18.Name == "WallAlt") then
						for v20 = 1, 4 do
							if v20 <= 2 then
								v21 = 1;
							else
								v21 = -1;
							end;
							if v20 == 2 or v20 == 4 then
								v22 = 1;
							else
								v22 = -1;
							end;
							local v23 = workspace:Raycast((CFrame.new(l__Position__17 + l__Normal__19, l__Position__17) * CFrame.new(v16.X / 2 * v21, v16.Y / 2 * v22, 0)).Position, l__Normal__19 * -1.1, v12);
							if not v23 then
								v24 = false;
								break;
							end;
							local l__Instance__25 = v23.Instance;
							local l__Normal__26 = v23.Normal;
							if not v23.Position then
								v24 = false;
								break;
							end;
							if not l__Instance__25 then
								v24 = false;
								break;
							end;
							if l__Instance__25.Anchored ~= true then
								v24 = false;
								break;
							end;
							if l__Instance__25.Name ~= "Wall" and l__Instance__25.Name ~= "WallAlt" then
								v24 = false;
								break;
							end;
						end;
					else
						v24 = false;
					end;
					if v24 == true then
						local v27 = u1:Clone();
						l__Position__17 = Vector3.new(l__Position__17.X, l__Instance__18.Position.Y - 2, l__Position__17.Z)
						v27:SetPrimaryPartCFrame(CFrame.new(l__Position__17, l__Position__17 + l__Normal__19) * CFrame.new(0,0,-0.4));
						v27.Parent = p2;
						v27.ActivateEventPrompt.Triggered:Connect(function(p)
						     v27.ActivateEventPrompt:Destroy()
					 	    v27.Lever.Anchored = false
						     v27.Lever.ToUnanchor.Anchored = false
				     		v27.Main.SoundToPlay:Play()
				task.spawn(p5, p)
						end)
						spawn(function()
							pcall(function()
								task.delay(3, function()
									for v28, v29 in pairs(v27:GetDescendants()) do
										if v29:IsA("BasePart") then
											v29.CanCollide = false;
											v29.CanQuery = false;
											v29.CanTouch = false;
											v29.CollisionGroupId = 1;
										end;
									end;
								end);
							end);
						end);
						v13 = v13 - 1;
					end;
				end;
				task.wait(0.016666666666666666);
				if v13 <= 0 then
					break;
				end;
			end;
		end);
		if v4 then
			warn(v4);
		end;
	end);
end;

return v1
--v1.lever(workspace.CurrentRooms[game.ReplicatedStorage.GameData.LatestRoom.Value], 1, 50)
