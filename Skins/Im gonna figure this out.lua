local player = game.Players.LocalPlayer 
local character = player.Character or player.CharacterAdded:Wait()

-- Função para remover roupas e acessórios 
local function removeClothesAndAccessories()
    for _, child in pairs(character:GetChildren()) do
        if child:IsA("Accessory") or child:IsA("Shirt") or child:IsA("Pants") or child:IsA("ShirtGraphic") then
            child:Destroy()
        end
    end
end

-- Função para criar partes arredondadas (seios e bunda) 
local function createRoundedPart(size, position, color, parent)
    local part = Instance.new("Part")
    part.Size = size
    part.Shape = Enum.PartType.Ball -- Forma arredondada
    part.BrickColor = BrickColor.new(color)
    part.Material = Enum.Material.SmoothPlastic -- Remover highlight
    part.CanCollide = false
    part.Anchored = false
    part.Position = position
    part.Parent = parent
  end

local weld = Instance.new("Weld")
weld.Part0 = part
weld.Part1 = parent
weld.C0 = CFrame.new(position)
weld.Parent = part

return part

end

-- Função para criar os seios local function createBreasts(parent) -- Cor da pele do personagem local skinColor = parent.Head.BrickColor

-- Seio esquerdo
local breast1 = createRoundedPart(Vector3.new(3, 3, 3), Vector3.new(-1.5, 1.5, 0.8), skinColor.Name, parent.Torso)
breast1.Name = "Breast1"

-- Seio direito
local breast2 = createRoundedPart(Vector3.new(3, 3, 3), Vector3.new(1.5, 1.5, 0.8), skinColor.Name, parent.Torso)
breast2.Name = "Breast2"

-- Bolinha rosa na frente dos seios
local nipple1 = createRoundedPart(Vector3.new(0.5, 0.5, 0.5), Vector3.new(-1.5, 1.5, 1.2), "Hot pink", breast1)
local nipple2 = createRoundedPart(Vector3.new(0.5, 0.5, 0.5), Vector3.new(1.5, 1.5, 1.2), "Hot pink", breast2)

end

-- Função para criar a bunda local function createButt(parent) -- Cor da pele do personagem local skinColor = parent.Head.BrickColor

-- Posicionar a bunda um pouco acima das pernas e atrás
local butt = createRoundedPart(Vector3.new(4, 4, 4), Vector3.new(0, -0.5, -1.8), skinColor.Name, parent.Torso)
butt.Name = "Butt"

end

-- Função para adicionar física de balanço local function addPhysics(part) local bodyVelocity = Instance.new("BodyVelocity") bodyVelocity.Velocity = Vector3.new(0, 0, 0) bodyVelocity.MaxForce = Vector3.new(0, 0, 0) bodyVelocity.Parent = part

local bodyGyro = Instance.new("BodyGyro")
bodyGyro.MaxTorque = Vector3.new(0, 0, 0)
bodyGyro.Parent = part

local bodyAngularVelocity = Instance.new("BodyAngularVelocity")
bodyAngularVelocity.MaxTorque = Vector3.new(1, 1, 1) * 1000
bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
bodyAngularVelocity.Parent = part

end

-- Função para aplicar balanço aos seios e bunda local function applyJigglePhysics() local breasts = {character:FindFirstChild("Breast1"), character:FindFirstChild("Breast2")} local butt = character:FindFirstChild("Butt")

for _, part in pairs(breasts) do
    if part then
        addPhysics(part)
    end
end

if butt then
    addPhysics(butt)
end

end

-- Função para exibir a mensagem acima da cabeça do jogador local function displayMessage(message) local billboardGui = Instance.new("BillboardGui") billboardGui.Adornee = character.Head billboardGui.Size = UDim2.new(0, 200, 0, 50) billboardGui.StudsOffset = Vector3.new(0, 2, 0) billboardGui.Parent = character

local textLabel = Instance.new("TextLabel")
textLabel.Text = message
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.BackgroundTransparency = 1
textLabel.Parent = billboardGui

end

-- Função para criar um Dummy local function createDummy() local dummy = Instance.new("Model") dummy.Name = "Dummy"

local humanoid = Instance.new("Humanoid")
humanoid.Parent = dummy

local torso = Instance.new("Part")
torso.Name = "Torso"
torso.Size = Vector3.new(2, 2, 1)
torso.Position = Vector3.new(0, 5, 0)
torso.Parent = dummy

local head = Instance.new("Part")
head.Name = "Head"
head.Size = Vector3.new(2, 1, 1)
head.Position = Vector3.new(0, 6.5, 0)
head.Parent = dummy

local weld = Instance.new("Weld")
weld.Part0 = head
weld.Part1 = torso
weld.C0 = CFrame.new(0, 1.5, 0)
weld.Parent = head

dummy.Parent = workspace

return dummy

end

-- Função para perguntar ao jogador se ele quer invocar um Dummy local function askForDummy() local screenGui = Instance.new("ScreenGui") screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
frame.Parent = screenGui

local textLabel = Instance.new("TextLabel")
textLabel.Text = "Você quer invocar um Dummy?"
textLabel.Size = UDim2.new(1, 0, 0.5, 0)
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.BackgroundTransparency = 1
textLabel.Parent = frame

local yesButton = Instance.new("TextButton")
yesButton.Text = "Sim"
yesButton.Size = UDim2.new(0.4, 0, 0.4, 0)
yesButton.Position = UDim2.new(0.1, 0, 0.6, 0)
yesButton.Parent = frame

local noButton = Instance.new("TextButton")
noButton.Text = "Não"
noButton.Size = UDim2.new(0.4, 0, 0.4, 0)
noButton.Position = UDim2.new(0.5, 0, 0.6, 0)
noButton.Parent = frame

yesButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    local dummy = createDummy()
    createBreasts(dummy)
    createButt(dummy)
    applyJigglePhysics()
end)

noButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

end

-- Remover roupas e acessórios removeClothesAndAccessories()

-- Criar seios e bunda createBreasts(character) createButt(character)

-- Aplicar física de balanço applyJigglePhysics()

-- Exibir a mensagem acima da cabeça do jogador displayMessage("Oi bebêeee, já está na hora.")

-- Perguntar ao jogador se ele quer invocar um Dummy askForDummy()

-- os peitos e bundas estão MUITO grandes, e os peitos não estão corretamente acima do torso/barriga, faça que a bunda fique mais pra baixo atrás das pernas e um pouco mais pra cima, e faça que a mensagem desapareça, e quando eu cliquei para invocar o dummy o dummy não apareceu, faça que quando invocar o dummy, o jogador ficará agachado, e o Dummy irá ir para frente e para atrás na bunda do jogador (isso ficou um pouco estranho)

-- E faça que os seios fiquem iguais como está na imagem
