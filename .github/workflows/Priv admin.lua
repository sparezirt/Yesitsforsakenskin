local method = "segway"
local serverlock = false
local screengui = Instance.new("ScreenGui")
screengui.IgnoreGuiInset = false
screengui.ResetOnSpawn = false
screengui.Parent = game.CoreGui
local textbox = Instance.new("TextBox")
textbox.Parent = screengui
textbox.BackgroundColor3 = Color3.new(0,0,0)
textbox.BackgroundTransparency = .64
textbox.Position = UDim2.new(0,0,-1,0)
textbox.Size = UDim2.new(1,0,0.05,0)
textbox.Font = Enum.Font.SourceSansBold
textbox.PlaceholderColor3 = Color3.fromRGB(111,0,222)
textbox.PlaceholderText = "ImaMeow's Private Admin"
textbox.TextColor3 = Color3.fromRGB(111,0,222)
textbox.TextScaled = true
textbox.TextXAlignment = Enum.TextXAlignment.Left
game:GetService("UserInputService").InputEnded:Connect(function(bind,istyping)
	if istyping then return end
	if bind.KeyCode == Enum.KeyCode.Semicolon then
		textbox:CaptureFocus()
		game:GetService("TweenService"):Create(textbox,TweenInfo.new(.4,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{Position = UDim2.new(0,0,.5,0)}):Play()
	end
end)
textbox.FocusLost:Connect(function(enter)
	game:GetService("TweenService"):Create(textbox,TweenInfo.new(.4,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{Position = UDim2.new(0,0,-1,0)}):Play()
	if not enter then return end
	local cmd = textbox.Text:split(" ")[1]
	local cmd2 = textbox.Text:split(" ")[2]
	if cmd == "kill" then
		if method == "segway" then
			if cmd2 == "all" then
			for i,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= game.Players.LocalPlayer.Name then
					for i,b in pairs(game:GetDescendants()) do
						if b.Name == "DestroySegway" then
							b:FireServer(v.Character.Head,{Value = v.Character.Head})
						end
					end
				end
			end
		end
		for i,v in pairs(game:GetDescendants()) do
			if v.Name == "DestroySegway" then
				v:FireServer(game.Workspace[cmd2].Head,{Value = game.Workspace[cmd2].Head})
			end
		end
		end
		if method == "car" then
			if cmd2 == "all" then
			for i,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= game.Players.LocalPlayer.Name then
					game.ReplicatedStorage.DeleteCar:FireServer(v.Character.Head)
				end
			end
		end
		game.ReplicatedStorage.DeleteCar:FireServer(game.Workspace[cmd2].Head)
		end
	end
	if cmd == "crash" then
		if method == "segway" then
			if cmd2 == "all" then
			for i,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= game.Players.LocalPlayer.Name then
					for i,b in pairs(game:GetDescendants()) do
						if b.Name == "DestroySegway" then
							b:FireServer(v,{Value = v})
						end
					end
				end
			end
		end
		for i,v in pairs(game:GetDescendants()) do
			if v.Name == "DestroySegway" then
				v:FireServer(game.Players[cmd2],{Value = game.Players[cmd2]})
			end
		end
		end
		if method == "car" then
			if cmd2 == "all" then
			for i,v in pairs(game.Players:GetPlayers()) do
				if v.Name ~= game.Players.LocalPlayer.Name then
					game.ReplicatedStorage.DeleteCar:FireServer(v)
				end
			end
		end
		game.ReplicatedStorage.DeleteCar:FireServer(game.Players[cmd2])
		end
	end
	if cmd == "nuke" then
		if method == "segway" then
			for i,v in pairs(game.Workspace:GetDescendants()) do
			if v:IsA("BasePart") then
				for i,b in pairs(game:GetDescendants()) do
					if b.Name == "DestroySegway" then
						b:FireServer(v,{Value = v})
					end
				end
			end
		end
		end
		if method == "car" then
			for i,v in pairs(game.Workspace:GetDescendants()) do
			if v:IsA("BasePart") then
				game.ReplicatedStorage.DeleteCar:FireServer(v)
			end
		end
		end
	end
	if cmd == "btools" then
		if method == "segway" then
			local destroytool = Instance.new("Tool")
		destroytool.Name = "Destroy Tool"
		destroytool.Parent = game.Players.LocalPlayer.Backpack
		destroytool.RequiresHandle = false
		destroytool.Activated:Connect(function()
			for i,v in pairs(game:GetDescendants()) do
				if v.Name == "DestroySegway" then
					v:FireServer(game.Players.LocalPlayer:GetMouse().Target,{Value = game.Players.LocalPlayer:GetMouse().Target})
				end
			end
		end)
		end
		if method == "car" then
			local destroytool = Instance.new("Tool")
		destroytool.Name = "Destroy Tool"
		destroytool.Parent = game.Players.LocalPlayer.Backpack
		destroytool.RequiresHandle = false
		destroytool.Activated:Connect(function()
			game.ReplicatedStorage.DeleteCar:FireServer(game.Players.LocalPlayer:GetMouse().Target)
		end)
		end
	end
	if cmd == "setmethod" then
		method = cmd2
	end
	if cmd == "ws" then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = cmd2
	end
	if cmd == "serverlock" then
		serverlock = not serverlock
	end
end)
game.Players.PlayerAdded:Connect(function(player)
	if not serverlock then return end
	if method == "segway" then
		for i,v in pairs(game:GetDescendants()) do
			if v.Name == "DestroySegway" then
				v:FireServer(player,{Value = player})
			end
		end
	end
	if method == "car" then
		game.ReplicatedStorage.DeleteCar:FireServer(player)
	end
end)
game.StarterGui:SetCore("SendNotification",{
	Title = game:GetService("HttpService"):GenerateGUID(true).." (LEAKED)";
	Text = "Welcome to Paplo Private Admin! Click ; to use cmds."
})
