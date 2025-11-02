-- Mobile Aimbot + ESP + Triggerbot (Krnl & Mobile Compatible)
-- No Rayfield | Full GUI | Works on Android/iOS/PC
-- by Swift | v2.0

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- ============ LOBBY CHECK ============
local function isInLobby()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if not pg then return true end
    local lobbyGuis = {"Lobby", "MainMenu", "LobbyGui", "LobbyUI", "StartMenu", "MenuGui"}
    for _, name in ipairs(lobbyGuis) do
        local gui = pg:FindFirstChild(name)
        if gui and gui.Enabled then return true end
    end
    if Workspace:FindFirstChild("Lobby") then return true end
    return false
end

-- ============ SETTINGS ============
local Settings = {
    AimbotEnabled = false,
    FovRadius = 150,
    ShowFov = false,
    Smoothness = 8,
    Prediction = false,
    PredictionAmt = 0.13,
    AimPart = "Head",
    HitChance = 100,

    ESPEnabled = false,
    BoxESP = true,
    NameESP = true,
    HealthESP = true,
    TracerESP = true,

    TriggerbotEnabled = false,
    TriggerDelay = 0.05,

    TeamCheck = true,
    WallCheck = true,
    AliveCheck = true,
    LobbyCheck = true,
}

-- ============ GUI SETUP ============
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AimbotGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 320, 0, 450)
Frame.Position = UDim2.new(0.5, -160, 0.5, -225)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "Mobile Aimbot + ESP + Trigger"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.Parent = Frame

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -35, 0, 2)
Close.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.Parent = Title
Close.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- ============ UI HELPER FUNCTIONS ============
local yOffset = 40

local function AddToggle(name, default, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(1, -20, 0, 30)
    toggle.Position = UDim2.new(0, 10, 0, yOffset)
    toggle.BackgroundColor3 = default and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    toggle.Text = name .. ": " .. (default and "ON" or "OFF")
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Font = Enum.Font.Gotham
    toggle.Parent = Frame

    toggle.MouseButton1Click:Connect(function()
        Settings[name] = not Settings[name]
        toggle.BackgroundColor3 = Settings[name] and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
        toggle.Text = name .. ": " .. (Settings[name] and "ON" or "OFF")
        if callback then callback(Settings[name]) end
    end)

    yOffset = yOffset + 35
    return toggle
end

local function AddSlider(name, min, max, default, suffix, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 50)
    frame.Position = UDim2.new(0, 10, 0, yOffset)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.Parent = Frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0.5, 0)
    label.BackgroundTransparency = 1
    label.Text = name .. ": " .. default .. (suffix or "")
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.Parent = frame

    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(1, -10, 0, 8)
    slider.Position = UDim2.new(0, 5, 0.6, 0)
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    slider.Parent = frame

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    fill.Parent = slider

    local dragging = false
    slider.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    slider.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local rel = math.clamp((i.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
            local val = min + (max - min) * rel
            Settings[name] = val
            fill.Size = UDim2.new(rel, 0, 1, 0)
            label.Text = name .. ": " .. math.floor(val * 100) / 100 .. (suffix or "")
            if callback then callback(val) end
        end
    end)

    yOffset = yOffset + 55
end

local function AddDropdown(name, options, default, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, yOffset)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Text = name .. ": " .. default
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.Parent = Frame

    local index = 1
    btn.MouseButton1Click:Connect(function()
        index = (index % #options) + 1
        local val = options[index]
        Settings[name] = val
        btn.Text = name .. ": " .. val
        if callback then callback(val) end
    end)

    yOffset = yOffset + 35
end

-- ============ ADD UI ELEMENTS ============
AddToggle("AimbotEnabled", false)
AddSlider("FovRadius", 20, 600, 150, "px")
AddToggle("ShowFov", false)
AddSlider("Smoothness", 1, 30, 8, "")
AddToggle("Prediction", false)
AddSlider("PredictionAmt", 0, 0.5, 0.13, "")
AddDropdown("AimPart", {"Head", "UpperTorso", "LowerTorso", "HumanoidRootPart"}, "Head")
AddSlider("HitChance", 0, 100, 100, "%")

AddToggle("ESPEnabled", false)
AddToggle("BoxESP", true)
AddToggle("NameESP", true)
AddToggle("HealthESP", true)
AddToggle("TracerESP", true)

AddToggle("TriggerbotEnabled", false)
AddSlider("TriggerDelay", 0, 0.5, 0.05, "s")

AddToggle("TeamCheck", true)
AddToggle("WallCheck", true)
AddToggle("AliveCheck", true)
AddToggle("LobbyCheck", true)

-- ============ FOV CIRCLE ============
local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 2
fovCircle.Filled = false
fovCircle.Color = Color3.fromRGB(255, 0, 0)
fovCircle.Radius = Settings.FovRadius
fovCircle.Visible = false

RunService.RenderStepped:Connect(function()
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    fovCircle.Position = center
    fovCircle.Radius = Settings.FovRadius
    fovCircle.Visible = Settings.ShowFov and Settings.AimbotEnabled
end)

-- ============ ESP ============
local ESP = {}
local function createESP(plr)
    if ESP[plr] then return end
    local box = Drawing.new("Square")
    box.Thickness = 2; box.Filled = false; box.Color = Color3.fromRGB(255, 0, 0); box.Visible = false

    local name = Drawing.new("Text")
    name.Size = 16; name.Center = true; name.Outline = true; name.Color = Color3.fromRGB(255, 255, 255); name.Visible = false

    local health = Drawing.new("Text")
    health.Size = 14; health.Center = true; health.Outline = true; health.Color = Color3.fromRGB(0, 255, 0); health.Visible = false

    local tracer = Drawing.new("Line")
    tracer.Thickness = 1; tracer.Color = Color3.fromRGB(255, 0, 0); tracer.Visible = false

    ESP[plr] = {box=box, name=name, health=health, tracer=tracer}
end

Players.PlayerAdded:Connect(function(p) createESP(p) end)
for _, p in Players:GetPlayers() do if p ~= LocalPlayer then createESP(p) end end
Players.PlayerRemoving:Connect(function(p)
    if ESP[p] then for _, v in pairs(ESP[p]) do v:Remove() end ESP[p] = nil end
end)

RunService.RenderStepped:Connect(function()
    if not Settings.ESPEnabled then
        for _, e in pairs(ESP) do for _, v in pairs(e) do v.Visible = false end end
        return
    end

    for plr, esp in pairs(ESP) do
        local char = plr.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Head") then
            for _, v in pairs(esp) do v.Visible = false end
            continue
        end

        local hrp = char.HumanoidRootPart
        local head = char.Head
        local hum = char:FindFirstChild("Humanoid")

        if Settings.TeamCheck and plr.Team == LocalPlayer.Team then
            for _, v in pairs(esp) do v.Visible = false end
            continue
        end
        if Settings.AliveCheck and (not hum or hum.Health <= 0) then
            for _, v in pairs(esp) do v.Visible = false end
            continue
        end

        local rootPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
        if not onScreen then
            for _, v in pairs(esp) do v.Visible = false end
            continue
        end

        -- Box
        if Settings.BoxESP then
            local top = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1, 0))
            local bottom = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
            local width = math.abs(top.X - bottom.X) * 1.8
            local height = math.abs(top.Y - bottom.Y)
            esp.box.Size = Vector2.new(width, height)
            esp.box.Position = Vector2.new(rootPos.X - width/2, rootPos.Y - height/2)
            esp.box.Visible = true
        else
            esp.box.Visible = false
        end

        -- Name
        if Settings.NameESP then
            local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1.2, 0))
            esp.name.Text = plr.Name
            esp.name.Position = Vector2.new(headPos.X, headPos.Y)
            esp.name.Visible = true
        else
            esp.name.Visible = false
        end

        -- Health
        if Settings.HealthESP and hum then
            local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 1.7, 0))
            esp.health.Text = math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth)
            esp.health.Position = Vector2.new(headPos.X, headPos.Y)
            esp.health.Visible = true
        else
            esp.health.Visible = false
        end

        -- Tracer
        if Settings.TracerESP then
            esp.tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
            esp.tracer.To = Vector2.new(rootPos.X, rootPos.Y)
            esp.tracer.Visible = true
        else
            esp.tracer.Visible = false
        end
    end
end)

-- ============ TRIGGERBOT ============
local lastShot = 0
RunService.RenderStepped:Connect(function()
    if not Settings.TriggerbotEnabled or tick() - lastShot < Settings.TriggerDelay then return end
    if Settings.LobbyCheck and isInLobby() then return end

    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    local ray = Camera:ScreenPointToRay(center.X, center.Y)
    local result = Workspace:Raycast(ray.Origin, ray.Direction * 1000, RaycastParams.new{
        FilterDescendantsInstances = {LocalPlayer.Character},
        FilterType = Enum.RaycastFilterType.Blacklist
    })

    if result and result.Instance then
        local model = result.Instance:FindFirstAncestorWhichIsA("Model")
        if model then
            local plr = Players:GetPlayerFromCharacter(model)
            if plr and plr ~= LocalPlayer and (not Settings.TeamCheck or plr.Team ~= LocalPlayer.Team) then
                if not Settings.AliveCheck or (model:FindFirstChild("Humanoid") and model.Humanoid.Health > 0) then
                    VirtualInputManager:SendMouseButtonEvent(center.X, center.Y, 0, true, game, 0)
                    task.wait(0.03)
                    VirtualInputManager:SendMouseButtonEvent(center.X, center.Y, 0, false, game, 0)
                    lastShot = tick()
                end
            end
        end
    end
end)

-- ============ AIMBOT ============
local function getClosest()
    local closest = nil
    local best = Settings.FovRadius
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)

    for _, plr in Players:GetPlayers() do
        if plr == LocalPlayer then continue end
        local char = plr.Character
        if not char or not char:FindFirstChild(Settings.AimPart) then continue end

        local part = char[Settings.AimPart]
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if not hrp then continue end

        if Settings.AliveCheck and (not hum or hum.Health <= 0) then continue end
        if Settings.TeamCheck and plr.Team == LocalPlayer.Team then continue end

        if Settings.WallCheck then
            local ray = Workspace:Raycast(Camera.CFrame.Position, part.Position - Camera.CFrame.Position, RaycastParams.new{
                FilterDescendantsInstances = {LocalPlayer.Character},
                FilterType = Enum.RaycastFilterType.Blacklist
            })
            if ray and not ray.Instance:IsDescendantOf(char) then continue end
        end

        local pos, onScreen = Camera:WorldToViewportPoint(part.Position)
        if not onScreen then continue end
        local dist = (Vector2.new(pos.X, pos.Y) - center).Magnitude
        if dist < best then
            best = dist
            closest = plr
        end
    end
    return closest
end

local function aimAt(target)
    local part = target.Character[Settings.AimPart]
    local pos = part.Position
    if Settings.Prediction and target.Character:FindFirstChild("HumanoidRootPart") then
        local vel = target.Character.HumanoidRootPart.Velocity
        pos = pos + Vector3.new(vel.X * Settings.PredictionAmt, 0, vel.Z * Settings.PredictionAmt)
    end

    local scr = Camera:WorldToViewportPoint(pos)
    local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    local delta = Vector2.new(scr.X - center.X, scr.Y - center.Y)
    if delta.Magnitude == 0 then return end

    local step = delta / (Settings.Smoothness * 10)
    local rot = CFrame.Angles(-math.rad(step.Y), math.rad(step.X), 0)
    Camera.CFrame = Camera.CFrame * rot

    if math.random(1, 100) <= Settings.HitChance then
        VirtualInputManager:SendMouseButtonEvent(center.X, center.Y, 0, true, game, 0)
        task.wait(0.03)
        VirtualInputManager:SendMouseButtonEvent(center.X, center.Y, 0, false, game, 0)
    end
end

RunService.RenderStepped:Connect(function()
    if not Settings.AimbotEnabled then return end
    if Settings.LobbyCheck and isInLobby() then return end
    local target = getClosest()
    if target then aimAt(target) end
end)

-- ============ NOTIFY ============
local notify = Instance.new("ScreenGui")
local text = Instance.new("TextLabel")
text.Size = UDim2.new(0, 300, 0, 50)
text.Position = UDim2.new(0.5, -150, 0, 10)
text.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
text.BackgroundTransparency = 0.5
text.Text = "Aimbot Loaded! Drag GUI to move."
text.TextColor3 = Color3.fromRGB(0, 255, 0)
text.Font = Enum.Font.GothamBold
text.Parent = LocalPlayer.PlayerGui
task.wait(3)
text:Destroy()
