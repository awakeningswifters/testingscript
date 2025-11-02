--[[
________   _______  ___   _____ _____ _____ _   _ 
| ___ \ \ / / ___ \/ _ \ /  ___/  ___|_   _| \ | |
| |_/ /\ V /| |_/ / /_\ \\ `--.\ `--. \ | | |  \||
| ___ \ \ / |  __/|  _  | `--. \`--. \ | | | . ` |
| |_/ / | | | |   | | | |/\__/ /\__/ /_| |_| |\  |
\____/  \_/ \_|   \_| |_/\____/\____/ \___/\_| \_/
]]--

    -- setup
    local repo
    if game:GetService("UserInputService").TouchEnabled or game:GetService("UserInputService").GamepadEnabled then
        repo = "https://raw.githubusercontent.com/LionTheGreatReaIFrFr/MobileLinoriaLib/main/"
    else
        repo = "https://raw.githubusercontent.com/LionTheGreatReaIFrFr/LinoriaLib/main/"
    end

    local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
    local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
    local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

    local Window = Library:CreateWindow({
        Title = "Bypassin | Rivals | " .. (identifyexecutor()),
        Center = true,
        AutoShow = true,
        Resizable = true,
        ShowCustomCursor = false,
        NotifySide = "Left",
    })

    local Tabs = {
        Main = Window:AddTab("Main");
        Combat = Window:AddTab("Combat");
        Visuals = Window:AddTab("Visuals");
        Settings = Window:AddTab("Settings");
    }

-- services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera



    -- code
    local function applyStreakAmount()
        local streakValue = tonumber(Options.StreakAmount.Value)
        local player = game:GetService("Players").LocalPlayer
        player:SetAttribute("StatisticDuelsWinStreak", streakValue)
        print("StatisticDuelsWinStreak set to: " .. streakValue)
    end

    local function applyLevelAmount()
        local levelValue = tonumber(Options.LevelAmount.Value)
        local player = game:GetService("Players").LocalPlayer
        player:SetAttribute("Level", levelValue)
        print("Level set to: " .. levelValue)
    end

    local emotes = {
        {
            Name = "Emote 1",
            AnimationId = "rbxassetid://125921589993721",
            Sounds = {
                {SoundId = "rbxassetid://134218301690577", Volume = 0.5, Delay = 0.4},
                {SoundId = "rbxassetid://71288358864209", Volume = 1, Delay = 0.4}
            }
        },
        {
            Name = "Emote 2", 
            AnimationId = "rbxassetid://71250144811352",
            Sounds = {
                {SoundId = "rbxassetid://120250934207816", Volume = 1, Looped = true}
            }
        },
        {
            Name = "Emote 3",
            AnimationId = "rbxassetid://104639476409829", 
            Sounds = {
                {SoundId = "rbxassetid://116605809326430", Volume = 1, Looped = true}
            }
        },
        {
            Name = "Emote 4",
            AnimationId = "rbxassetid://133733650708343",
            Sounds = {
                {SoundId = "rbxassetid://13160326139", Volume = 1, Pitch = 1.3, Delay = 0.3},
                {SoundId = "rbxassetid://13160326139", Volume = 1.1, Pitch = 1.4, Delay = 0.7},
                {SoundId = "rbxassetid://13160326139", Volume = 0.8, Pitch = 0.8, Delay = 1.65},
                {SoundId = "rbxassetid://13160326139", Volume = 1, Pitch = 1, Delay = 2.05}
            }
        },
        {
            Name = "Emote 5",
            AnimationId = "rbxassetid://95292230449040",
            Sounds = {
                {SoundId = "rbxassetid://120797927157164", Volume = 1, Looped = true}
            }
        },
        {
            Name = "Emote 6",
            AnimationId = "rbxassetid://115000869501227",
            SecondaryAnim = "rbxassetid://83376670167687",
            Duration = 4.15,
            Sounds = {
                {SoundId = "rbxassetid://80133530921906", Volume = 1.5, Delay = 0},
                {SoundId = "rbxassetid://98970356172671", Volume = 1.5, Looped = true, Delay = 4.15}
            }
        },
        {
            Name = "Emote 7",
            AnimationId = "rbxassetid://98020061651338", 
            SecondaryAnim = "rbxassetid://99622591614050",
            Duration = 1.3,
            Sounds = {
                {SoundId = "rbxassetid://110965772629921", Volume = 1, Delay = 0},
                {SoundId = "rbxassetid://100664444144490", Volume = 1, Looped = true, Delay = 1.3}
            }
        },
        {
            Name = "Emote 8",
            AnimationId = "rbxassetid://77255514751814",
            Sounds = {
                {SoundId = "rbxassetid://88051081362116", Volume = 1, Looped = true}
            }
        },
        {
            Name = "Emote 9",
            AnimationId = "rbxassetid://119282539520778",
            Sounds = {
                {SoundId = "rbxassetid://79768694812211", Volume = 0.8, Pitch = 0.9, Delay = 0.4},
                {SoundId = "rbxassetid://79768694812211", Volume = 1, Pitch = 1.1, Delay = 1.0},
                {SoundId = "rbxassetid://79768694812211", Volume = 0.8, Pitch = 0.8, Delay = 1.95},
                {SoundId = "rbxassetid://79768694812211", Volume = 1, Pitch = 1, Delay = 2.35}
            }
        },
        {
            Name = "Emote 10",
            AnimationId = "rbxassetid://104273989039620",
            Sounds = {
                {SoundId = "rbxassetid://129000171133220", Volume = 1, Looped = true}
            }
        },
        {
            Name = "Emote 11",
            AnimationId = "rbxassetid://105875604689697",
            Sounds = {
                {SoundId = "rbxassetid://137662451042014", Volume = 1, Looped = true}
            }
        },
        {
            Name = "Emote 12", 
            AnimationId = "rbxassetid://84754316528381",
            Sounds = {
                {SoundId = "rbxassetid://134140996504107", Volume = 1, Delay = 1}
            }
        },
        {
            Name = "Emote 13",
            AnimationId = "rbxassetid://103862270973168",
            Sounds = {
                {SoundId = "rbxassetid://88377109323880", Volume = 1, Delay = 0},
                {SoundId = "rbxassetid://13160326139", Volume = 1.25, Delay = 0.7}
            }
        },
        {
            Name = "Emote 14",
            AnimationId = "rbxassetid://81555757574094",
            Sounds = {
                {SoundId = "rbxassetid://75485128790168", Volume = 1, Delay = 0},
                {SoundId = "rbxassetid://13158735106", Volume = 1, Pitch = 1.2, Delay = 0.4},
                {SoundId = "rbxassetid://13158735106", Volume = 1, Pitch = 1, Delay = 0.6},
                {SoundId = "rbxassetid://13158735106", Volume = 1, Pitch = 1.3, Delay = 0.8}
            }
        },
        {
            Name = "Emote 15",
            AnimationId = "rbxassetid://95986480266032",
            Sounds = {
                {SoundId = "rbxassetid://125575791507235", Volume = 1, Looped = true}
            }
        },
        {
            Name = "Emote 16",
            AnimationId = "rbxassetid://85429197687197",
            Sounds = {
                {SoundId = "rbxassetid://78663178795648", Volume = 1, Delay = 0.25}
            }
        }
    }

    local function playSelectedEmote()
        local selectedName = Options.SelectEmote.Value
        local selectedEmote

        for _, emote in ipairs(emotes) do
            if emote.Name == selectedName then
                selectedEmote = emote
                break
            end
        end

        if not selectedEmote then return end

        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        local character = player.Character
        if not character then return end

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end

        local anim = Instance.new("Animation")
        anim.AnimationId = selectedEmote.AnimationId
        local track = humanoid:LoadAnimation(anim)
        track:Play()

        if selectedEmote.SecondaryAnim then
            local secondaryAnim = Instance.new("Animation")
            secondaryAnim.AnimationId = selectedEmote.SecondaryAnim
            local secondaryTrack = humanoid:LoadAnimation(secondaryAnim)
            secondaryTrack:Play()
        end

        for _, soundData in ipairs(selectedEmote.Sounds) do
            task.delay(soundData.Delay or 0, function()
                local sound = Instance.new("Sound")
                sound.SoundId = soundData.SoundId
                sound.Volume = soundData.Volume or 1
                sound.Pitch = soundData.Pitch or (1 + 0.1 * math.random())
                sound.Looped = soundData.Looped or false

                local soundParent = character:FindFirstChild("Head") or character:FindFirstChildWhichIsA("BasePart")
                if soundParent then
                    sound.Parent = soundParent
                    sound:Play()

                    if not soundData.Looped then
                        sound.Ended:Connect(function()
                            sound:Destroy()
                        end)
                    end
                end
            end)
        end
    end

    local utility = require(game:GetService("ReplicatedStorage").Modules.Utility)
    local originalRaycast = utility.Raycast

    local config = {
        enabled = true,
        use_fov = true,
        show_fov = true,
        fov_amount = 100,
        fov_color = Color3.fromRGB(255, 255, 255),
        use_distance = false,
        distance_amount = 500,
        rainbow_fov = false,
        hit_chance = 100
    }

    if game:GetService("CoreGui"):FindFirstChild("FOVCircleGui") then
        game:GetService("CoreGui").FOVCircleGui:Destroy()
    end

    local silentAimFovCircle = Drawing.new("Circle")
    silentAimFovCircle.Visible = false
    silentAimFovCircle.Radius = config.fov_amount
    silentAimFovCircle.Color = config.fov_color
    silentAimFovCircle.Thickness = 2
    silentAimFovCircle.NumSides = 64
    silentAimFovCircle.Filled = false
    silentAimFovCircle.Transparency = 0.5

    local function getRainbowColor()
        local tick = tick()
        local r = math.sin(tick * 2) * 0.5 + 0.5
        local g = math.sin(tick * 2 + 2) * 0.5 + 0.5
        local b = math.sin(tick * 2 + 4) * 0.5 + 0.5
        return Color3.new(r, g, b)
    end

    local function get_mouse_position()
        local UserInputService = game:GetService("UserInputService")
        if UserInputService.MouseEnabled then
            return UserInputService:GetMouseLocation()
        else
            local viewport_size = workspace.CurrentCamera.ViewportSize
            return Vector2.new(viewport_size.X / 2, viewport_size.Y / 2)
        end
    end

    local function update_silent_aim_fov()
        if not config.enabled or not config.show_fov or not config.use_fov then
            silentAimFovCircle.Visible = false
            return
        end
        
        silentAimFovCircle.Visible = true
        local mouse_pos = get_mouse_position()
        
        silentAimFovCircle.Position = Vector2.new(mouse_pos.X, mouse_pos.Y)
        silentAimFovCircle.Radius = config.fov_amount
        
        if config.rainbow_fov then
            silentAimFovCircle.Color = getRainbowColor()
        else
            silentAimFovCircle.Color = config.fov_color
        end
    end

    game:GetService("RunService").RenderStepped:Connect(function()
        update_silent_aim_fov()
    end)

    local function get_players()
        local entities = {}
        for _, child in workspace:GetChildren() do
            if child:FindFirstChildOfClass("Humanoid") then
                local humanoid = child:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    table.insert(entities, child)
                end
            elseif child.Name == "HurtEffect" then
                for _, hurt_player in child:GetChildren() do
                    if hurt_player.ClassName ~= "Highlight" then
                        local humanoid = hurt_player:FindFirstChildOfClass("Humanoid")
                        if humanoid and humanoid.Health > 0 then
                            table.insert(entities, hurt_player)
                        end
                    end
                end
            end
        end
        return entities
    end

    local function get_closest_player()
        if math.random(1, 100) > config.hit_chance then
            return nil
        end
        
        local closest, closest_distance = nil, math.huge
        local character = game:GetService("Players").LocalPlayer.Character
        if not character then return end

        for _, player in get_players() do
            if player == game:GetService("Players").LocalPlayer then continue end
            if not player:FindFirstChild("HumanoidRootPart") then continue end

            local humanoid = player:FindFirstChildOfClass("Humanoid")
            if not humanoid or humanoid.Health <= 0 then continue end

            if config.use_distance then
                local distance = (character.HumanoidRootPart.Position - player.HumanoidRootPart.Position).Magnitude
                if distance > config.distance_amount then continue end
            end

            local position, on_screen = workspace.CurrentCamera:WorldToViewportPoint(player.HumanoidRootPart.Position)
            if not on_screen then continue end

            if config.use_fov then
                local mouse_pos = get_mouse_position()
                local distance = (mouse_pos - Vector2.new(position.X, position.Y)).Magnitude
                if distance > config.fov_amount then continue end
            end

            local mouse_pos = get_mouse_position()
            local distance = (mouse_pos - Vector2.new(position.X, position.Y)).Magnitude
            if distance > closest_distance then continue end

            closest = player
            closest_distance = distance
        end
        return closest
    end

    utility.Raycast = function(...)
        if not config.enabled then
            return originalRaycast(...)
        end
        
        local arguments = {...}
        if #arguments > 0 and arguments[4] == 999 then
            local closest = get_closest_player()
            if closest and closest:FindFirstChild("Head") then
                arguments[3] = closest.Head.Position
            end
        end
        return originalRaycast(table.unpack(arguments))
    end

    local fovCircle = Drawing.new("Circle")
    fovCircle.Visible = false
    fovCircle.Radius = 100
    fovCircle.Color = Color3.fromRGB(96, 205, 255)
    fovCircle.Thickness = 2
    fovCircle.NumSides = 64
    fovCircle.Filled = false
    fovCircle.Transparency = 0.5

    local function createAimlockState()
        local state = {
            AimlockEnabled = false,
            UseAimlockDistance = false,
            UseAimlockFOV = false,
            ShowFOV = false,
            FOVColor = Color3.fromRGB(255, 255, 255),
            TargetPlayer = nil,
            RainbowFOV = false
        }
        
        return {
            getAimlockEnabled = function() return state.AimlockEnabled end,
            setAimlockEnabled = function(value) state.AimlockEnabled = value end,
            
            getUseAimlockDistance = function() return state.UseAimlockDistance end,
            setUseAimlockDistance = function(value) state.UseAimlockDistance = value end,
            
            getUseAimlockFOV = function() return state.UseAimlockFOV end,
            setUseAimlockFOV = function(value) state.UseAimlockFOV = value end,
            
            getShowFOV = function() return state.ShowFOV end,
            setShowFOV = function(value) state.ShowFOV = value end,
            
            getFOVColor = function() return state.FOVColor end,
            setFOVColor = function(value) state.FOVColor = value end,
            
            getTargetPlayer = function() return state.TargetPlayer end,
            setTargetPlayer = function(value) state.TargetPlayer = value end,
            
            getRainbowFOV = function() return state.RainbowFOV end,
            setRainbowFOV = function(value) state.RainbowFOV = value end
        }
    end

    local Aimlock = createAimlockState()

    local function getClosestPlayerToMouse()
        local mousePos = game:GetService("UserInputService"):GetMouseLocation()
        local closestPlayer = nil
        local shortestDistance = Options.AimlockFOV.Value

        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game:GetService("Players").LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                -- Dead check
                if humanoid and humanoid.Health > 0 then
                    local rootPart = player.Character.HumanoidRootPart
                    local distanceFromLocal = (rootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if (Aimlock.getUseAimlockDistance() and distanceFromLocal <= Options.AimlockDistance.Value) or not Aimlock.getUseAimlockDistance() then
                        local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position)
                        if onScreen then
                            local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
                            if (Aimlock.getUseAimlockFOV() and dist <= shortestDistance) or not Aimlock.getUseAimlockFOV() then
                                shortestDistance = dist
                                closestPlayer = player
                            end
                        end
                    end
                end
            end
        end

        return closestPlayer
    end

    game:GetService("RunService").RenderStepped:Connect(function()
        local mousePos = game:GetService("UserInputService"):GetMouseLocation()
        
        local radius = (Options.AimlockFOV and Options.AimlockFOV.Value) or 100
        fovCircle.Position = Vector2.new(mousePos.X, mousePos.Y)
        fovCircle.Radius = radius

        if Aimlock.getRainbowFOV() then
            fovCircle.Color = getRainbowColor()
        else
            fovCircle.Color = (Aimlock.getFOVColor and Aimlock.getFOVColor()) or Color3.fromRGB(255,255,255)
        end
        
        fovCircle.Visible = (Aimlock.getAimlockEnabled and Aimlock.getAimlockEnabled())
            and (Aimlock.getShowFOV and Aimlock.getShowFOV())
            and (Aimlock.getUseAimlockFOV and Aimlock.getUseAimlockFOV())

        local keybindPressed = (Options.AimlockKeybind and Options.AimlockKeybind.GetState and Options.AimlockKeybind:GetState()) or false
        
        if keybindPressed and Aimlock.getAimlockEnabled and Aimlock.getAimlockEnabled() then
            local lp = game:GetService("Players").LocalPlayer
            if lp and lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                local humanoid = lp.Character:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    local target = getClosestPlayerToMouse and getClosestPlayerToMouse()
                    Aimlock.setTargetPlayer(target)
                    
                    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                        if targetHumanoid and targetHumanoid.Health > 0 then
                            local rootPart = target.Character.HumanoidRootPart
                            local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(rootPart.Position)
                            if onScreen and screenPos.Z > 0 then
                                local delta = Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mousePos.X, mousePos.Y)
                                local smoothing = (Options.AimlockSmoothing and Options.AimlockSmoothing.Value) or 50
                                local moveVector = delta * (1 - smoothing / 100)

                                pcall(function()
                                    mousemoverel(moveVector.X, moveVector.Y)
                                end)
                            end
                        end
                    end
                end
            end
        else
            if Aimlock.setTargetPlayer then
                Aimlock.setTargetPlayer(nil)
            end
        end
    end)

    local function createTriggerBotState()
        local state = {
            Enabled = false,
            Distance = 1000,
            Delay = 0
        }
        
        return {
            getEnabled = function() return state.Enabled end,
            setEnabled = function(value) state.Enabled = value end,
            
            getDistance = function() return state.Distance end,
            setDistance = function(value) state.Distance = value end,
            
            getDelay = function() return state.Delay end,
            setDelay = function(value) state.Delay = value end
        }
    end

    local TriggerBot = createTriggerBotState()

    local function isPlayerUnderCrosshair()
        local UserInputService = game:GetService("UserInputService")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local Camera = workspace.CurrentCamera
        
        local mousePos = UserInputService:GetMouseLocation()
        local mouseRay = Camera:ViewportPointToRay(mousePos.X, mousePos.Y)
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                
                if humanoid and humanoid.Health > 0 and rootPart then
                    local distanceFromLocal = (rootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if distanceFromLocal > TriggerBot.getDistance() then
                        continue
                    end
                    
                    local characterParts = player.Character:GetDescendants()
                    for _, part in ipairs(characterParts) do
                        if part:IsA("BasePart") then
                            local partPosition = part.Position
                            local screenPos, onScreen = Camera:WorldToViewportPoint(partPosition)
                            
                            if onScreen then
                                local distanceFromMouse = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                                
                                if distanceFromMouse <= 10 then
                                    return true
                                end
                            end
                        end
                    end
                end
            end
        end
        
        return false
    end

    local lastTriggerTime = 0
    local mouseDown = false

    local function simulateMouseClick()
        if not mouseDown then
            mouseDown = true
            pcall(function()
                mouse1click()
            end)
            
            delay(0.05, function()
                mouseDown = false
            end)
        end
    end

    game:GetService("RunService").RenderStepped:Connect(function()
        local LocalPlayer = game:GetService("Players").LocalPlayer
        
        if not TriggerBot.getEnabled() then return end
        if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
        
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if not humanoid or humanoid.Health <= 0 then return end
        
        local currentTime = tick()
        
        if currentTime - lastTriggerTime >= TriggerBot.getDelay() then
            if isPlayerUnderCrosshair() then
                simulateMouseClick()
                lastTriggerTime = currentTime
            end
        end
    end)

    local function getPlayerByName(name)
        if name == "No players available" then return nil end
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Name == name then
                return player
            end
        end
        return nil
    end

    local function updatePlayerList(dropdown)
        local playerNames = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                table.insert(playerNames, player.Name)
            end
        end
        if #playerNames == 0 then
            table.insert(playerNames, "No players available")
        end
        dropdown.Values = playerNames
        dropdown:SetValues()
    end

    local function teleportToPlayer(player)
        if not player or not player.Character then return end
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if localRoot and rootPart then
            localRoot.CFrame = rootPart.CFrame
        end
    end

    local Flags = {
        AmbientEnabled = false,
        FullBright = false,
        NoFog = false,
        FOVEnabled = false,
        SkyboxEnabled = false
    }

    local Defaults = {
        FogStart = Lighting.FogStart,
        FogEnd = Lighting.FogEnd,
        FOV = 70
    }

    local ColorCorrection = Instance.new("ColorCorrectionEffect")
    ColorCorrection.Name = "ColorCorrection"
    ColorCorrection.Parent = Lighting
    ColorCorrection.Saturation = 0

    local skyboxes = {
        ["Default"] = nil,
        ["Vaporwave"] = {"1417494030", "1417494146", "1417494253", "1417494402", "1417494499", "1417494643"},
        ["Redshift"] = {"401664839", "401664862", "401664960", "401664881", "401664901", "401664936"},
        ["Desert"] = {"1013852", "1013853", "1013850", "1013851", "1013849", "1013854"},
        ["Blaze"] = {"150939022", "150939038", "150939047", "150939056", "150939063", "150939082"},
        ["Among Us"] = {"5752463190", "5752463190", "5752463190", "5752463190", "5752463190", "5752463190"},
        ["Space Wave2"] = {"1233158420", "1233158838", "1233157105", "1233157640", "1233157995", "1233159158"},
        ["Turquoise Wave"] = {"47974894", "47974690", "47974821", "47974776", "47974859", "47974909"},
        ["Dark Night"] = {"6285719338", "6285721078", "6285722964", "6285724682", "6285726335", "6285730635"},
        ["Bright Pink"] = {"271042516", "271077243", "271042556", "271042310", "271042467", "271077958"},
        ["Oblivion Lost"] = {"5103110171", "5102993828", "5103111020", "5103112417", "5103113734", "5102993828"},
        ["Setting Sun"] = {"626460377", "626460216", "626460513", "626473032", "626458639", "626460625"},
    }

    local function applySkybox(name)
        local ids = skyboxes[name]
        if not ids then return end
        
        if Lighting:FindFirstChild("CustomSky") then
            Lighting.CustomSky:Destroy()
        end
        
        local sky = Instance.new("Sky")
        sky.Name = "CustomSky"
        sky.Parent = Lighting
        sky.SkyboxFt = "rbxassetid://"..ids[1]
        sky.SkyboxBk = "rbxassetid://"..ids[2]
        sky.SkyboxLf = "rbxassetid://"..ids[3]
        sky.SkyboxRt = "rbxassetid://"..ids[4]
        sky.SkyboxUp = "rbxassetid://"..ids[5]
        sky.SkyboxDn = "rbxassetid://"..ids[6]
    end

    local espLibrary = {
    instances = {},
    espCache = {},
    chamsCache = {},
    objectCache = {},
    conns = {},
    whitelist = {}, 
    blacklist = {}, 
    options = {
        enabled = false,
        minScaleFactorX = 1,
        maxScaleFactorX = 10,
        minScaleFactorY = 1,
        maxScaleFactorY = 10,
        scaleFactorX = 5,
        scaleFactorY = 6,
        boundingBox = false, 
        boundingBoxDescending = false,
        excludedPartNames = {},
        font = 2,
        fontSize = 13,
        limitDistance = false,
        maxDistance = 1000,
        visibleOnly = false,
        teamCheck = false,
        teamColor = false,
        useCustomTeamColor = false,
        customteamColor = Color3.new(1,1,1),
        fillColor = nil,
        whitelistColor = Color3.new(1, 0, 0),
        outOfViewArrows = false,
        outOfViewArrowsFilled = false,
        outOfViewArrowsSize = 25,
        outOfViewArrowsRadius = 100,
        outOfViewArrowsColor = Color3.new(1, 1, 1),
        outOfViewArrowsTransparency = 0.5,
        outOfViewArrowsOutline = false,
        outOfViewArrowsOutlineFilled = false,
        outOfViewArrowsOutlineColor = Color3.new(1, 1, 1),
        outOfViewArrowsOutlineTransparency = 1,
        names = false,
        nameTransparency = 1,
        nameColor = Color3.new(1, 1, 1),
        boxes = false,
        boxesTransparency = 1,
        boxesColor = Color3.new(1, 0, 0),
        boxFill = false,
        boxFillTransparency = 0.5,
        boxFillColor = Color3.new(1, 0, 0),
        healthBars = false,
        healthBarsSize = 1,
        healthBarsTransparency = 1,
        healthBarsColor = Color3.new(0, 1, 0),
        healthText = false,
        healthTextTransparency = 1,
        healthTextSuffix = "%",
        healthTextColor = Color3.new(1, 1, 1),
        distance = false,
        distanceTransparency = 1,
        distanceSuffix = " Studs",
        distanceColor = Color3.new(1, 1, 1),
        tool = false,
        toolTransparency = 1,
        toolColor = Color3.new(1,1,1),
        tracers = false,
        tracerTransparency = 1,
        tracerColor = Color3.new(1, 1, 1),
        tracerOrigin = "Bottom", 
        chams = false,
        chamsFillColor = Color3.new(1, 0, 0),
        chamsFillTransparency = 0.5,
        chamsOutlineColor = Color3.new(),
        chamsOutlineTransparency = 0,
        skeleton = false,
        skeletonColor = Color3.new(1, 1, 1),
        skeletonTransparency = 1,
    },
  };
  espLibrary.__index = espLibrary;
  
  local getService = game.GetService;
  local instanceNew = Instance.new;
  local drawingNew = Drawing.new;
  local vector2New = Vector2.new;
  local vector3New = Vector3.new;
  local cframeNew = CFrame.new;
  local color3New = Color3.new;
  local raycastParamsNew = RaycastParams.new;
  local abs = math.abs;
  local tan = math.tan;
  local rad = math.rad;
  local clamp = math.clamp;
  local floor = math.floor;
  local find = table.find;
  local insert = table.insert;
  local findFirstChild = game.FindFirstChild;
  local findFirstChildOfClass = game.FindFirstChildOfClass;
  local getChildren = game.GetChildren;
  local getDescendants = game.GetDescendants;
  local isA = workspace.IsA;
  local raycast = workspace.Raycast;
  local emptyCFrame = cframeNew();
  local pointToObjectSpace = emptyCFrame.PointToObjectSpace;
  local getComponents = emptyCFrame.GetComponents;
  local cross = vector3New().Cross;
  local inf = 1 / 0;
  
  local workspace = getService(game, "Workspace");
  local runService = getService(game, "RunService");
  local players = getService(game, "Players");
  local coreGui = getService(game, "CoreGui");
  local userInputService = getService(game, "UserInputService");
  
  local currentCamera = workspace.CurrentCamera;
  local localPlayer = players.LocalPlayer;
  local screenGui = instanceNew("ScreenGui", coreGui);
  local lastFov, lastScale;
  
  local wtvp = currentCamera.WorldToViewportPoint;
  
  local function isDrawing(type)
    return type == "Square" or type == "Text" or type == "Triangle" or type == "Image" or type == "Line" or type == "Circle";
  end
  
  local function create(type, properties)
    local drawing = isDrawing(type);
    local object = drawing and drawingNew(type) or instanceNew(type);
  
    if (properties) then
        for i,v in next, properties do
            object[i] = v;
        end
    end
  
    if (not drawing) then
        insert(espLibrary.instances, object);
    end
  
    return object;
  end
  
  local function worldToViewportPoint(position)
    local screenPosition, onScreen = wtvp(currentCamera, position);
    return vector2New(screenPosition.X, screenPosition.Y), onScreen, screenPosition.Z;
  end
  
  local function round(number)
    return typeof(number) == "Vector2" and vector2New(round(number.X), round(number.Y)) or floor(number);
  end
  
  function espLibrary.getTeam(player)
    local team = player.Team;
    return team, player.TeamColor.Color;
  end
  
  function espLibrary.getCharacter(player)
    local character = player.Character
    if not character then return nil, nil end
    
    local torso = character:FindFirstChild("HumanoidRootPart")
    
    if not torso then
        torso = character:FindFirstChild("UpperTorso")
    end
    
    if not torso then
        torso = character:FindFirstChild("Torso")
    end
    
    return character, torso
  end

  function espLibrary.getTool(player)
    local character = player.Character;
    return findFirstChildOfClass(character, "Tool") ~= nil and tostring(findFirstChildOfClass(character, "Tool")) or findFirstChildOfClass(character, "Tool") == nil and "None"
  end
  
  function espLibrary.getBoundingBox(character, torso)
    if (espLibrary.options.boundingBox) then
        local minX, minY, minZ = inf, inf, inf;
        local maxX, maxY, maxZ = -inf, -inf, -inf;
  
        for _, part in next, espLibrary.options.boundingBoxDescending and getDescendants(character) or getChildren(character) do
            if (isA(part, "BasePart") and not find(espLibrary.options.excludedPartNames, part.Name)) then
                local size = part.Size;
                local sizeX, sizeY, sizeZ = size.X, size.Y, size.Z;
  
                local x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22 = getComponents(part.CFrame);
  
                local wiseX = 0.5 * (abs(r00) * sizeX + abs(r01) * sizeY + abs(r02) * sizeZ);
                local wiseY = 0.5 * (abs(r10) * sizeX + abs(r11) * sizeY + abs(r12) * sizeZ);
                local wiseZ = 0.5 * (abs(r20) * sizeX + abs(r21) * sizeY + abs(r22) * sizeZ);
  
                minX = minX > x - wiseX and x - wiseX or minX;
                minY = minY > y - wiseY and y - wiseY or minY;
                minZ = minZ > z - wiseZ and z - wiseZ or minZ;
  
                maxX = maxX < x + wiseX and x + wiseX or maxX;
                maxY = maxY < y + wiseY and y + wiseY or maxY;
                maxZ = maxZ < z + wiseZ and z + wiseZ or maxZ;
            end
        end
  
        local oMin, oMax = vector3New(minX, minY, minZ), vector3New(maxX, maxY, maxZ);
        return (oMax + oMin) * 0.5, oMax - oMin;
    else
        return torso.Position, vector2New(espLibrary.options.scaleFactorX, espLibrary.options.scaleFactorY);
    end
  end
  
  function espLibrary.getScaleFactor(fov, depth)
    if (fov ~= lastFov) then
        lastScale = tan(rad(fov * 0.5)) * 2;
        lastFov = fov;
    end
  
    return 1 / (depth * lastScale) * 1000;
  end
  
  function espLibrary.getBoxData(position, size)
    local torsoPosition, onScreen, depth = worldToViewportPoint(position);
    local scaleFactor = espLibrary.getScaleFactor(currentCamera.FieldOfView, depth);
  
    local clampX = clamp(size.X, espLibrary.options.minScaleFactorX, espLibrary.options.maxScaleFactorX);
    local clampY = clamp(size.Y, espLibrary.options.minScaleFactorY, espLibrary.options.maxScaleFactorY);
    local size = round(vector2New(clampX * scaleFactor, clampY * scaleFactor));
  
    return onScreen, size, round(vector2New(torsoPosition.X - (size.X * 0.5), torsoPosition.Y - (size.Y * 0.5))), torsoPosition;
  end
  
  function espLibrary.getHealth(player, character)
    local humanoid = findFirstChild(character, "Humanoid");
  
    if (humanoid) then
        return math.floor(humanoid.Health), humanoid.MaxHealth;
    end
  
    return 100, 100;
  end
  
  function espLibrary.visibleCheck(character, position)
    local origin = currentCamera.CFrame.Position;
    local params = raycastParamsNew();
  
    params.FilterDescendantsInstances = { espLibrary.getCharacter(localPlayer), currentCamera, character };
    params.FilterType = Enum.RaycastFilterType.Blacklist;
    params.IgnoreWater = true;
  
    return (not raycast(workspace, origin, position - origin, params));
  end
  
  function espLibrary.addEsp(player)
    if (player == localPlayer) then
        return
    end
  
    local objects = {
        arrow = create("Triangle", {
            Thickness = 1,
        }),
        arrowOutline = create("Triangle", {
            Thickness = 1,
        }),
        bottom = create("Text", {
            Center = true,
            Size = 13,
            Outline = true,
            OutlineColor = color3New(),
            Font = 2,
        }),
        tool = create("Text", {
            Center = true,
            Size = 13,
            Outline = true,
            OutlineColor = color3New(),
            Font = 2,
        }),
        top = create("Text", {
            Center = true,
            Size = 13,
            Outline = true,
            OutlineColor = color3New(),
            Font = 2,
        }),
        side = create("Text", {
            Size = 13,
            Outline = true,
            OutlineColor = color3New(),
            Font = 2,
        }),
        boxFill = create("Square", {
            Thickness = 1,
            Filled = true,
        }),
        boxOutline = create("Square", {
            Thickness = 3,
            Color = color3New()
        }),
        box = create("Square", {
            Thickness = 1
        }),
        healthBarOutline = create("Square", {
            Thickness = 1,
            Color = color3New(),
            Filled = true
        }),
        healthBar = create("Square", {
            Thickness = 1,
            Filled = true
        }),
        lineoutline = create("Line", {Thickness = 3}),
        line = create("Line", {Thickness = 1}),
        
        skeletonHead = create("Line", {Thickness = 1}),
        skeletonTorso = create("Line", {Thickness = 1}),
        skeletonLeftArm = create("Line", {Thickness = 1}),
        skeletonRightArm = create("Line", {Thickness = 1}),
        skeletonLeftLeg = create("Line", {Thickness = 1}),
        skeletonRightLeg = create("Line", {Thickness = 1}),
        skeletonUpperTorso = create("Line", {Thickness = 1}),
        skeletonLeftUpperArm = create("Line", {Thickness = 1}),
        skeletonRightUpperArm = create("Line", {Thickness = 1}),
        skeletonLeftUpperLeg = create("Line", {Thickness = 1}),
        skeletonRightUpperLeg = create("Line", {Thickness = 1}),
    };
  
    espLibrary.espCache[player] = objects;

    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Died:Connect(function()
                for _, object in next, objects do
                    object.Visible = false
                end
            end)
        end
    end

    player.CharacterAdded:Connect(function(char)
        local humanoid = char:WaitForChild("Humanoid", 5)
        if humanoid then
            humanoid.Died:Connect(function()
                for _, object in next, objects do
                    object.Visible = false
                end
            end)
        end
    end)
  end
  
  function espLibrary.removeEsp(player)
    local espCache = espLibrary.espCache[player];
  
    if (espCache) then
        espLibrary.espCache[player] = nil;
  
        for index, object in next, espCache do
            espCache[index] = nil;
            object:Remove();
        end
    end
  end
  
  function espLibrary.addChams(player)
    if (player == localPlayer) then
        return
    end
  
    espLibrary.chamsCache[player] = create("Highlight", {
        Parent = screenGui,
    });
  end
  
  function espLibrary.removeChams(player)
    local highlight = espLibrary.chamsCache[player];
  
    if (highlight) then
        espLibrary.chamsCache[player] = nil;
        highlight:Destroy();
    end
  end
  
  function espLibrary.addObject(object, options)
    espLibrary.objectCache[object] = {
        options = options,
        text = create("Text", {
            Center = true,
            Size = 13,
            Outline = true,
            OutlineColor = color3New(),
            Font = 2,
        })
    };
  end
  
  function espLibrary.removeObject(object)
    local cache = espLibrary.objectCache[object];
  
    if (cache) then
        espLibrary.objectCache[object] = nil;
        cache.text:Remove();
    end
  end
  
  function espLibrary:AddObjectEsp(object, defaultOptions)
    assert(object and object.Parent, "invalid object passed");
  
    local options = defaultOptions or {};
  
    options.enabled = options.enabled or true;
    options.limitDistance = options.limitDistance or false;
    options.maxDistance = options.maxDistance or false;
    options.visibleOnly = options.visibleOnly or false;
    options.color = options.color or color3New(1, 1, 1);
    options.transparency = options.transparency or 1;
    options.text = options.text or object.Name;
    options.font = options.font or 2;
    options.fontSize = options.fontSize or 13;
  
    self.addObject(object, options);
  
    insert(self.conns, object.Parent.ChildRemoved:Connect(function(child)
        if (child == object) then
            self.removeObject(child);
        end
    end));
  
    return options;
  end
  
  function espLibrary:Unload()
    for _, connection in next, self.conns do
        connection:Disconnect();
    end
  
    for _, player in next, players:GetPlayers() do
        self.removeEsp(player);
        self.removeChams(player);
    end
  
    for object, _ in next, self.objectCache do
        self.removeObject(object);
    end
  
    for _, object in next, self.instances do
        object:Destroy();
    end
  
    screenGui:Destroy();
    runService:UnbindFromRenderStep("esp_rendering");
  end
  
  function espLibrary:Load(renderValue)
    insert(self.conns, players.PlayerAdded:Connect(function(player)
        self.addEsp(player);
        self.addChams(player);
    end));
