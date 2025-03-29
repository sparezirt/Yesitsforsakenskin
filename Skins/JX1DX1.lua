local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- function to display a message on the screen (smaller) 
local function showMessage(message, position)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player.PlayerGui
 
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0.4, 0, 0.05, 0) -- smaller size
    textLabel.Position = position or UDim2.new(0.3, 0, 0.9, 0) -- Position at bottom by default
    textLabel.Text = message
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.BackgroundColor3 = Color3.new(0, 0, 0)
    textLabel.BackgroundTransparency = 0.5
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 18
    textLabel.Parent = screenGui
 
    -- Remove messages after 5 seconds
    task.delay(5, function()
        screenGui:Destroy()
    end)
end
 
-- Function to check if the character is JX1DX1
local function checkJX1DX1()
    local characterName = player.Character.Name
    if characterName ~= "Jason" then
        showMessage("Oops, your current character isn't JX1DX1. This script may not work correctly!", UDim2.new(0.3, 0, 0.5, 0))
        return false
    end
    return true
end
 
-- Function to play a sound
local function playSound(id)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. id
    sound.Parent = character
    sound:Play()
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
end
 
-- Function to apply glitch effect
local function applyGlitchEffect()
    -- Particle effects of number "0" and "1"
    local glitchEffect = Instance.new("ParticleEmitter")
    glitchEffect.Parent = character
    glitchEffect.Texture = "rbxassetid://139225455829885" -- Texture numbers
    glitchEffect.Lifetime = NumberRange.new(1, 2)
    glitchEffect.Rate = 100
    glitchEffect.Speed = NumberRange.new(10, 20)
    glitchEffect.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)})
    glitchEffect.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})
    glitchEffect.Rotation = NumberRange.new(0, 360)
    glitchEffect.VelocitySpread = 360
    glitchEffect.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)), -- Red
        ColorSequenceKeypoint.new(0.5, Color3.new(0, 1, 0)), -- Green
        ColorSequenceKeypoint.new(1, Color3.new(0, 0, 1)) -- Blue
    })
    task.delay(2, function()
        glitchEffect:Destroy()
    end)
 
    -- Visual distortion effects
    local distortion = Instance.new("BlurEffect")
    distortion.Parent = game.Lighting
    distortion.Size = 10
    task.delay(2, function()
        distortion:Destroy()
    end)
end
 
-- Function to remove specific items from the characters
local function removeSpecificItems()
    local itemsToRemove = {"Mask", "Chainsaw", "Machete"}
    for _, itemName in ipairs(itemsToRemove) do
        local item = character:FindFirstChild(itemName)
        if item then
            item:Destroy()
        end
    end
end
 
-- Function to replace mesh and the texture of the head
local function replaceHeadMeshAndTexture()
    local head = character:FindFirstChild("Head")
    if head then
        local mesh = head:FindFirstChildOfClass("SpecialMesh")
        if mesh then
            mesh.MeshId = "rbxassetid://96631676497276"
            mesh.TextureId = "rbxassetid://99136147881903"
            mesh.Scale = Vector3.new(1, 1, 1) -- keeping the original size
        end
    end
end
 
-- Function to apply the correct body color to body parts
local function applyBodyColors()
    local head = character:FindFirstChild("Head")
    local leftArm = character:FindFirstChild("Left Arm")
    local rightArm = character:FindFirstChild("Right Arm")
    local leftLeg = character:FindFirstChild("Left Leg")
    local rightLeg = character:FindFirstChild("Right Leg")
    local torso = character:FindFirstChild("Torso")
 
    if head then
        head.Color = Color3.new(1, 0, 0) -- Red
    end
    if leftArm then
        leftArm.Color = Color3.new(1, 0, 0) -- Red
    end
    if rightArm then
        rightArm.Color = Color3.new(1, 0, 0) -- Red
    end
    if leftLeg then
        leftLeg.Color = Color3.new(0, 0.5, 0) -- Dark green
    end
    if rightLeg then
        rightLeg.Color = Color3.new(0, 0.5, 0) -- Drak green
    end
    if torso then
        torso.Color = Color3.new(0.5, 0, 0) -- Darker red
    end
end
 
-- Function to  customize the character to JX1DX1
local function reskinJX1DX1()
    if not checkJX1DX1() then return end -- check the character before continuing
 
    character = player.Character or player.CharacterAdded:Wait()
 
    -- Remove everything from the character before modyfiying
    for _, item in ipairs(character:GetChildren()) do
        if item:IsA("Clothing") or item:IsA("ShirtGraphic") or item:IsA("Accessory") or item:IsA("BodyColors") or item:IsA("CharacterMesh") then
            item:Destroy()
        end
    end
 
    -- Remove specific items
    removeSpecificItems()
 
    -- Apply new clothes
    local shirt = Instance.new("Shirt")
    shirt.ShirtTemplate = "http://www.roblox.com/asset/?id=15233281070"
    shirt.Parent = character
 
    local pants = Instance.new("Pants")
    pants.PantsTemplate = "http://www.roblox.com/asset/?id=109335451982076"
    pants.Parent = character
 
    -- Function to correctly create accessories and attach them to the character
    local function addAccessory(name, meshId, textureId, parentPart, position, rotation, customWeldC0, customWeldC1)
        local accessory = Instance.new("Accessory")
        accessory.Name = name
 
        local handle = Instance.new("Part")
        handle.Name = "Handle"
        handle.Size = Vector3.new(1, 1, 1)
        handle.CanCollide = false
        handle.Anchored = false
        handle.Parent = accessory
 
        local mesh = Instance.new("SpecialMesh")
        mesh.MeshId = meshId
        if textureId ~= "" then
            mesh.TextureId = textureId
        end
        mesh.Parent = handle
 
        local weld = Instance.new("Weld")
        weld.Part0 = handle
        weld.Part1 = character:FindFirstChild(parentPart)
 
        if customWeldC0 and customWeldC1 then
            weld.C0 = CFrame.new(unpack(customWeldC0))
            weld.C1 = CFrame.new(unpack(customWeldC1))
        else
            weld.C0 = CFrame.new(unpack(position)) * CFrame.Angles(math.rad(rotation[1]), math.rad(rotation[2]), math.rad(rotation[3]))
        end
 
        weld.Parent = handle
        accessory.Parent = character
    end
 
    -- Adicionar acessórios do JX1DX1
    addAccessory("InkStreamAccessory", "rbxassetid://11355876084", "rbxassetid://11355953536", "Head", 
        {-0.01308441162109375, -0.023116588592529297, 0.10596466064453125}, {0, 180, 0}, 
        {-0.0130844116, -0.0231165886, 0.105964661, -1, 0, 0, 0, 1, 0, 0, 0, -1},
        {0, 0, -0.600000024, 1, 0, 0, 0, 1, 0, 0, 0, 1})
 
    addAccessory("RedTie2025", "rbxassetid://113700904021744", "rbxassetid://80268262288585", "Torso", 
        {0, 0.7549999952316284, 0.5419999957084656}, {0, 0, 0}, 
        {0, 0.754999995, 0.541999996, 1, 0, 0, 0, 1, 0, 0, 0, 1},
        {0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1})
 
    addAccessory("CrimsonEyeGemAccessory", "rbxassetid://18904924899", "rbxassetid://18920887987", "Torso", 
        {0.5838318467140198, -0.5967679023742676, -0.07608413696289062}, {0, 180, 0}, 
        {0.583831847, -0.596767902, -0.076084137, -1, 0, 0, 0, 1, 0, 0, 0, -1},
        {0, 0, -0.5, 1, 0, 0, 0, 1, 0, 0, 0, 1})
 
    addAccessory("applAccessory", "rbxassetid://18959417148", "rbxassetid://18959417375", "Right Arm", 
        {-2.0910823345184326, 0.6025786399841309, 1.250074028968811}, {11.067476272583008, -146.04066467285156, -75.31954193115234}, 
        {-2.09108233, 0.60257864, 1.25007403, -0.106470108, -0.829532444, -0.548215389, -0.949363172, 0.248714626, -0.191964939, 0.295590341, 0.500016987, -0.814008236},
        {0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1})
 
    addAccessory("EyeInk(R)", "rbxassetid://12306663511", "rbxassetid://12306678780", "Head", 
        {-0.20721435546875, -0.014445304870605469, -0.07403182983398438}, {0, 0, 0}, 
        {-0.207214355, -0.0144453049, -0.0740318298, 1, 0, 0, 0, 1, 0, 0, 0, 1},
        {0, 0, -0.600000024, 1, 0, 0, 0, 1, 0, 0, 0, 1})
 
    addAccessory("Meshes/animedisappointmentlinesAccessory", "rbxassetid://14630512593", "rbxassetid://14630517668", "Head", 
        {-0.2673218250274658, 0.017516613006591797, 0.23295974731445312}, {0, 0, 0}, 
        {-0.267321825, 0.017516613, 0.232959747, 1, 0, 0, 0, 1, 0, 0, 0, 1},
        {0, 0, -0.600000024, 1, 0, 0, 0, 1, 0, 0, 0, 1})
 
    addAccessory("Meshes/verticaldisappointedAccessory", "rbxassetid://14630649589", "rbxassetid://14630517668", "Head", 
        {-0.32176685333251953, -0.18348360061645508, 0.12277603149414062}, {0, 0, 0}, 
        {-0.321766853, -0.183483601, 0.122776031, 1, 0, 0, 0, 1, 0, 0, 0, 1},
        {0, 0, -0.600000024, 1, 0, 0, 0, 1, 0, 0, 0, 1})
 
    addAccessory("Curve.004Accessory", "rbxassetid://13986092318", "rbxassetid://13986092251", "Head", 
        {-0.0014255940914154053, 0.08711099624633789, 0.5606200695037842}, {0, 0, 0}, 
        {-0.00142559409, 0.0871109962, 0.56062007, 1, 0, 0, 0, 1, 0, 0, 0, 1},
        {0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1})
 
    -- replace the head mesh and texture
    replaceHeadMeshAndTexture()
 
    -- Apply the correct colors to the body parts
    applyBodyColors()
 
    -- Applying the glitch effects
    applyGlitchEffect()
    playSound("75504743390858") -- Som ao aplicar a reskin
end
 
-- Function to change the characters name
local function renameCharacter()
    if player.Character.Name == "JX1DX1" then
        character.Name = "JX1DX1"
    end
end
 
-- Function to laod the JX1DX1 animations
local function loadJX1DX1Animations()
    local Humanoid = character:WaitForChild("Humanoid")
    local Animator = Humanoid:WaitForChild("Animator")
 
    -- Animation IDs
    local ANIMATION_IDS = {
        IDLE = "rbxassetid://83465205704188",
        WALK = "rbxassetid://103292185212679",
        RUN = "rbxassetid://103292185212679",
        SWING = "rbxassetid://109230267448394",
        GASHING_WOUND = "rbxassetid://99465988880393",
        STUN = "rbxassetid://128923537868786",
        STUN_LOOP = "rbxassetid://122580527125278",
        STUN_END = "rbxassetid://99164529472582",
        KILLING_VICTIM = "rbxassetid://129491851057694",
        VICTIM_DIE = "rbxassetid://116544958644813"
    }
 
    -- Old animation IDs
    local OLD_ANIMATION_IDS = {
        IDLE = "rbxassetid://116050994905421",
        WALK = "rbxassetid://93622022596108",
        RUN = "rbxassetid://93054787145505",
        SWING = "rbxassetid://126830014841198",
        GASHING_WOUND = "rbxassetid://121086746534252",
        STUN = "rbxassetid://84525150536125",
        STUN_LOOP = "rbxassetid://75595031025056",
        STUN_END = "rbxassetid://125119944753086",
        KILLING_VICTIM = "rbxassetid://129546372182752",
        VICTIM_DIE = "rbxassetid://71908227364423"
    }
 
    -- Load the animations
    local idleTrack = Humanoid:LoadAnimation(Instance.new("Animation", {AnimationId = ANIMATION_IDS.IDLE}))
    local walkTrack = Humanoid:LoadAnimation(Instance.new("Animation", {AnimationId = ANIMATION_IDS.WALK}))
    local runTrack = Humanoid:LoadAnimation(Instance.new("Animation", {AnimationId = ANIMATION_IDS.RUN}))
    local swingTrack = Humanoid:LoadAnimation(Instance.new("Animation", {AnimationId = ANIMATION_IDS.SWING}))
    local gashingWoundTrack = Humanoid:LoadAnimation(Instance.new("Animation", {AnimationId = ANIMATION_IDS.GASHING_WOUND}))
    local stunTrack = Humanoid:LoadAnimation(Instance.new("Animation", {AnimationId = ANIMATION_IDS.STUN}))
    local stunLoopTrack = Humanoid:LoadAnimation(Instance.new("Animation", {AnimationId = ANIMATION_IDS.STUN_LOOP}))
    local stunEndTrack = Humanoid:LoadAnimation(Instance.new("Animation", {AnimationId = ANIMATION_IDS.STUN_END}))
    local killingVictimTrack = Humanoid:LoadAnimation(Instance.new("Animation", {AnimationId = ANIMATION_IDS.KILLING_VICTIM}))
    local victimDieTrack = Humanoid:LoadAnimation(Instance.new("Animation", {AnimationId = ANIMATION_IDS.VICTIM_DIE}))
 
    -- Connecting humanoid state event
    Humanoid.StateChanged:Connect(function(_, newState)
        if newState == Enum.HumanoidStateType.Idle then
            idleTrack:Play()
        elseif newState == Enum.HumanoidStateType.Walking then
            walkTrack:Play()
        elseif newState == Enum.HumanoidStateType.Running then
            runTrack:Play()
        elseif newState == Enum.HumanoidStateType.Freefall then
            swingTrack:Play()
        elseif newState == Enum.HumanoidStateType.Dead then
            playSound("74700922826005") -- Som ao morrer
        end
    end)
 
    -- Function to replace animations
    local function ReplaceAnimation(oldId, newId)
        if not Humanoid then
            warn("Humanoid não encontrado!")
            return
        end
 
        local Animator = Humanoid:FindFirstChildOfClass("Animator")
        if not Animator then
            warn("Animator não encontrado!")
            return
        end
 
        for _, track in pairs(Animator:GetPlayingAnimationTracks()) do
            if track.Animation and track.Animation.AnimationId == oldId then
                local newAnimation = Instance.new("Animation")
                newAnimation.AnimationId = newId
 
                local newTrack = Animator:LoadAnimation(newAnimation)
                newTrack:Play()
 
                track:Stop()
 
                print("Animation is replaced successfully")
                break
            end
        end
    end
 
    -- Replaces the animation in a constant loop
    while true do
        ReplaceAnimation(OLD_ANIMATION_IDS.IDLE, ANIMATION_IDS.IDLE) -- IDLE
        ReplaceAnimation(OLD_ANIMATION_IDS.WALK, ANIMATION_IDS.WALK) -- WALK
        ReplaceAnimation(OLD_ANIMATION_IDS.RUN, ANIMATION_IDS.RUN) -- RUN
        ReplaceAnimation(OLD_ANIMATION_IDS.SWING, ANIMATION_IDS.SWING) -- SWING
        ReplaceAnimation(OLD_ANIMATION_IDS.GASHING_WOUND, ANIMATION_IDS.GASHING_WOUND) -- GASHING WOUND
        ReplaceAnimation(OLD_ANIMATION_IDS.STUN, ANIMATION_IDS.STUN) -- STUN
        ReplaceAnimation(OLD_ANIMATION_IDS.STUN_LOOP, ANIMATION_IDS.STUN_LOOP) -- STUN LOOP
        ReplaceAnimation(OLD_ANIMATION_IDS.STUN_END, ANIMATION_IDS.STUN_END) -- STUN END
        ReplaceAnimation(OLD_ANIMATION_IDS.KILLING_VICTIM, ANIMATION_IDS.KILLING_VICTIM) -- KILLING VICTIM
        ReplaceAnimation(OLD_ANIMATION_IDS.VICTIM_DIE, ANIMATION_IDS.VICTIM_DIE) -- VICTIM DIE
        task.wait(0.1) -- checking every 0.1 seconds
    end
end
 
-- Function to replace the character and activate the script
local function checkAndActivate()
    showMessage("wait for the rounds to end, then use JX1DX1.", UDim2.new(0.3, 0, 0.5, 0)) -- Mensagem centralizada
 
    player.CharacterAdded:Connect(function()
        if player.Character.Name == "Jason" then
            reskinJX1DX1()
            renameCharacter()
            loadJX1DX1Animations()
            showMessage("JX1DX1 ativado.", UDim2.new(0.8, 0, 0.1, 0)) -- Mensage in the upper right corner
        else
            local characterName = player.Character.Name
            showMessage("Are you using" .. characterName .. " instead of JX1DX1!", UDim2.new(0.3, 0, 0.5, 0))
        end
    end)
end
 
-- Actomatically run when running the script
checkAndActivate()
