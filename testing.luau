if not game:IsLoaded() then
    game.Loaded:Wait()
end
if game.GameId ~= 6035872082 then
    return
end
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
repeat
    task.wait()
until LocalPlayer
print("Rivals Anticheat Disabler executed!")
local success, err = pcall(function()
    assert(getgc, "executor missing required function getgc")
    assert(debug and debug.info, "executor missing required function debug.info (somehow)")
    assert(hookfunction, "executor missing required function hookfunction")
    assert(getconnections, "executor missing required function getconnections")
    assert(newcclosure, "executor missing required function newcclosure")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local LogService = game:GetService("LogService")
    local ScriptContext = game:GetService("ScriptContext")
    task.spawn(function()
        local hooked = 0
        for _, v in pairs(getgc(true)) do
            if typeof(v) == "function" then
                local ok, src = pcall(function()
                    return debug.info(v, "s")
                end)
                if ok and type(src) == "string" and string.find(src, "AnalyticsPipelineController") then
                    hooked += 1
                    local oldfn
                    oldfn = hookfunction(v, newcclosure(function(...)
                        return wait(9e9)
                    end))
                end
            end
        end
        print("Hanged " .. hooked .. " functions")
    end)
    task.spawn(function()
        local ok, remote = pcall(function()
            return ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("AnalyticsPipeline"):WaitForChild("RemoteEvent")
        end)
        if ok and remote and remote.OnClientEvent then
            local hooked = 0
            for _, conn in pairs(getconnections(remote.OnClientEvent)) do
                if conn and conn.Function then
                    if pcall(function()
                        hookfunction(conn.Function, newcclosure(function(...)
                        end))
                    end) then 
                        hooked += 1
                    end
                end
            end
            print("Hooked " .. hooked .. " anticheat remotes")
        end
    end)
    task.spawn(function()
        local hooked = 0
        for _, conn in pairs(getconnections(LogService.MessageOut)) do
            if conn and conn.Function then
                if pcall(function()
                    hookfunction(conn.Function, newcclosure(function(...)
                    end))
                end) then
                    hooked += 1
                end
            end
        end
        print("Hooked " .. hooked .. " MessageOut connections")
    end)
    task.spawn(function()
        local hooked = 0
        for _, conn in ipairs(getconnections(ScriptContext.Error)) do
            if pcall(function()
                conn:Disable()
            end) then
                hooked += 1
            end
        end
        print("Hooked " .. hooked .. " error connections")
        pcall(function()
            hookfunction(ScriptContext.Error.Connect, newcclosure(function(...)
                return nil
            end))
        end)
    end)
    task.spawn(function()
        local KickNames = {
            "Kick",
            "kick"
        }
        for _, name in ipairs(KickNames) do
            local fn = LocalPlayer[name]
            if type(fn) == "function" then
                local oldkick
                oldkick = hookfunction(fn, newcclosure(function(self, ...)
                    if self == LocalPlayer then
                        return
                    end
                    return oldkick(self, ...)
                end))
            end
        end
    end)
end)
if not success then
    game:GetService("StarterGui"):SetCore("SendNotification", {
    	Title = "Rivals Anticheat Disabler",
    	Text = "Error, please check console",
    	Duration = 5
    })
    print("Rivals Anticheat Disabler failed: " .. tostring(err))
else
    game:GetService("StarterGui"):SetCore("SendNotification", {
    	Title = "Rivals Anticheat Disabler",
    	Text = "Successfully disabled anticheat!",
    	Duration = 5
    })
end

local replicated_storage = game.GetService(game, "ReplicatedStorage");
local players = game.GetService(game, "Players");

local camera = workspace.CurrentCamera;
local utility = require(replicated_storage.Modules.Utility);

local get_players = function() -- this is dumb asf, feel free to modify.
    local entities = {};

    for _, child in workspace.GetChildren(workspace) do
        if child.FindFirstChildOfClass(child, "Humanoid") then
            table.insert(entities, child);
        elseif child.Name == "HurtEffect" then
            for _, hurt_player in child.GetChildren(child) do
                if (hurt_player.ClassName ~= "Highlight") then
                    table.insert(entities, hurt_player);
                end
            end
        end
    end
    return entities
end
local get_closest_player = function()
    local closest, closest_distance = nil, math.huge;
    local character = players.LocalPlayer.Character;

    if (character == nil) then
        return;
    end

    for _, player in get_players() do
        if (player == players.LocalPlayer) then
            continue;
        end

        if (not player:FindFirstChild("HumanoidRootPart")) then
            continue;
        end

        local position, on_screen = camera.WorldToViewportPoint(camera, player.HumanoidRootPart.Position);

        if (on_screen == false) then
            continue;
        end

        local center = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2);
        local distance = (center - Vector2.new(position.X, position.Y)).Magnitude;

        if (distance > closest_distance) then
            continue;
        end

        closest = player;
        closest_distance = distance;
    end
    return closest;
end

local old = utility.Raycast; utility.Raycast = function(...)
    local arguments = {...};

    if (#arguments > 0 and arguments[4] == 999) then
        local closest = get_closest_player();

        if (closest) then
            arguments[3] = closest.Head.Position;
        end
    end
    return old(table.unpack(arguments));
end
