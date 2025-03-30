local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
 
-- Function to customize the character
local function reskinCharacter()
    character = player.Character or player.CharacterAdded:Wait()
 
    -- Remove old items from the character  
    for _, item in ipairs(character:GetChildren()) do  
        if item:IsA("Clothing") or item:IsA("ShirtGraphic") or item:IsA("Accessory") or item:IsA("BodyColors") or item:IsA("CharacterMesh") then  
            item:Destroy()  
        end  
    end  
 
    -- Set new colors
    local headColor = Color3.fromRGB(195, 210, 140)  -- Light yellow-green
    local torsoColor = Color3.fromRGB(120, 50, 50)   -- Reddish brown
    local limbsColor = Color3.fromRGB(30, 20, 20)    -- Dark black
 
    -- Apply new colors to body parts
    for _, part in ipairs(character:GetChildren()) do  
        if part:IsA("BasePart") then  
            if part.Name == "Head" then
                part.Color = headColor
                part.Transparency = 1 -- Now the head is completely invisible
                -- Remove any face that might be on the head
                local face = part:FindFirstChild("face")
                if face then
                    face:Destroy()
                end
            elseif part.Name == "Torso" or part.Name == "UpperTorso" or part.Name == "LowerTorso" then
                part.Color = torsoColor
            elseif part.Name == "Left Arm" or part.Name == "Right Arm" or part.Name == "Left Leg" or part.Name == "Right Leg" then
                part.Color = limbsColor
            end
        end  
    end  
 
    -- Apply new clothes  
    local shirt = Instance.new("Shirt")  
    shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=12225832080"  
    shirt.Parent = character  
 
    local pants = Instance.new("Pants")  
    pants.PantsTemplate = "http://www.roblox.com/asset/?id=12230993022"  
    pants.Parent = character  
 
    -- Create a new hat  
    local hat = Instance.new("Accessory")  
    hat.Name = "CustomHat"  
 
    local hatHandle = Instance.new("Part")  
    hatHandle.Name = "Handle"  
    hatHandle.Size = Vector3.new(1.4, 1.2, 1.6)  
    hatHandle.Parent = hat  
    hatHandle.CanCollide = false  
    hatHandle.Anchored = false  
 
    -- Apply hat mesh  
    local hatMesh = Instance.new("SpecialMesh")  
    hatMesh.MeshId = "rbxassetid://136153244937460"  
    hatMesh.TextureId = "rbxassetid://115876850544992"  
    hatMesh.Scale = Vector3.new(1.1, 1.1, 1.1)  
    hatMesh.Parent = hatHandle  
 
    -- Position the hat correctly on the head  
    local head = character:FindFirstChild("Head")
    if head then  
        local headHeight = head.Size.Y  
        hatHandle.CFrame = head.CFrame * CFrame.new(0, (headHeight / 2) - 0.4, -0.0) -- Moves the hat backward  
        local weld = Instance.new("WeldConstraint")  
        weld.Part0 = hatHandle  
        weld.Part1 = head  
        weld.Parent = hatHandle  
    end  
    hat.Parent = character
end
 
-- Executes the script automatically when run
reskinCharacter()
