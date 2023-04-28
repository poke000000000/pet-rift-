local function API_Check()
    if Drawing == nil then
        return "No"
    else
        return "Yes"
    end
end

local Find_Required = API_Check()

if Find_Required == "No" then
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Exunys Developer";
        Text = "ESP script could not be loaded because your exploit is unsupported.";
        Duration = math.huge;
        Button1 = "OK"
    })

    return
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

local Typing = false

getgenv().ESP_SendNotifications = true   -- If set to true then the script would notify you frequently on any changes applied and when loaded / errored. (If a game can detect this, it is recommended to set it to false)
getgenv().ESP_DefaultSettings = false   -- If set to true then the ESP script would run with default settings regardless of any changes you made.

getgenv().ESP_TeamCheck = false   -- If set to true then the script would create ESP only for the enemy team members.

getgenv().ESP_ESPVisible = false   -- If set to true then the ESP will be visible and vice versa.
getgenv().ESP_TextColor = Color3.fromRGB(255, 80, 10)   -- The color that the boxes would appear as.
getgenv().ESP_TextSize = 22   -- The size of the text.
getgenv().ESP_Center = true   -- If set to true then the script would be located at the center of the label.
getgenv().ESP_Outline = true   -- If set to true then the text would have an outline.
getgenv().ESP_OutlineColor = Color3.fromRGB(0, 0, 0)   -- The outline color of the text.
getgenv().ESP_TextTransparency = 0.7   -- The transparency of the text.
getgenv().ESP_TextFont = Drawing.Fonts.UI   -- The font of the text. (UI, System, Plex, Monospace) 

getgenv().ESP_DisableKey = Enum.KeyCode.Q   -- The key that disables / enables the ESP.

local function CreateESP()
    for _, v in next, Players:GetPlayers() do
        if v.Name ~= Players.LocalPlayer.Name then
            local ESP = Drawing.new("Text")

            RunService.RenderStepped:Connect(function()
                if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                    local Vector, OnScreen = Camera:WorldToViewportPoint(workspace[v.Name]:WaitForChild("Head", math.huge).Position)

                    ESP.Size = getgenv().ESP_TextSize
                    ESP.Center = getgenv().ESP_Center
                    ESP.Outline = getgenv().ESP_Outline
                    ESP.OutlineColor = getgenv().ESP_OutlineColor
                    ESP.Color = getgenv().ESP_TextColor
                    ESP.Transparency = getgenv().ESP_TextTransparency
                    ESP.Font = getgenv().ESP_TextFont

                    if OnScreen == true then
                        local Part1 = workspace:WaitForChild(v.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position
                        local Part2 = workspace:WaitForChild(Players.LocalPlayer.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position or 0
                        local Dist = (Part1 - Part2).Magnitude
                        ESP.Position = Vector2.new(Vector.X, Vector.Y - 25)
                        ESP.Text = ("("..tostring(math.floor(tonumber(Dist)))..") "..v.Name.." ["..workspace[v.Name].Humanoid.Health.."]")
                        if getgenv().ESP_TeamCheck == true then 
                            if Players.LocalPlayer.Team ~= v.Team then
                                ESP.Visible = getgenv().ESP_ESPVisible
                            else
                                ESP.Visible = false
                            end
                        else
                            ESP.Visible = getgenv().ESP_ESPVisible
                        end
                    else
                        ESP.Visible = false
                    end
                else
                    ESP.Visible = false
                end
            end)

            Players.PlayerRemoving:Connect(function()
                ESP.Visible = false
            end)
        end
    end

    Players.PlayerAdded:Connect(function(Player)
        Player.CharacterAdded:Connect(function(v)
            if v.Name ~= Players.LocalPlayer.Name then 
                local ESP = Drawing.new("Text")
    
                RunService.RenderStepped:Connect(function()
                    if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                        local Vector, OnScreen = Camera:WorldToViewportPoint(workspace[v.Name]:WaitForChild("Head", math.huge).Position)
    
                        ESP.Size = getgenv().ESP_TextSize
                        ESP.Center = getgenv().ESP_Center
                        ESP.Outline = getgenv().ESP_Outline
                        ESP.OutlineColor = getgenv().ESP_OutlineColor
                        ESP.Color = getgenv().ESP_TextColor
                        ESP.Transparency = getgenv().ESP_TextTransparency
    
                        if OnScreen == true then
                            local Part1 = workspace:WaitForChild(v.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position
                        local Part2 = workspace:WaitForChild(Players.LocalPlayer.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position or 0
                            local Dist = (Part1 - Part2).Magnitude
                            ESP.Position = Vector2.new(Vector.X, Vector.Y - 25)
                            ESP.Text = ("("..tostring(math.floor(tonumber(Dist)))..") "..v.Name.." ["..workspace[v.Name].Humanoid.Health.."]")
                            if getgenv().ESP_TeamCheck == true then 
                                if Players.LocalPlayer.Team ~= Player.Team then
                                    ESP.Visible = getgenv().ESP_ESPVisible
                                else
                                    ESP.Visible = false
                                end
                            else
                                ESP.Visible = getgenv().ESP_ESPVisible
                            end
                        else
                            ESP.Visible = false
                        end
                    else
                        ESP.Visible = false
                    end
                end)
    
                Players.PlayerRemoving:Connect(function()
                    ESP.Visible = false
                end)
            end
        end)
    end)
end

if getgenv().ESP_DefaultSettings == true then
    getgenv().ESP_TeamCheck = false
    getgenv().ESP_ESPVisible = true
    getgenv().ESP_TextColor = Color3.fromRGB(40, 90, 255)
    getgenv().ESP_TextSize = 14
    getgenv().ESP_Center = true
    getgenv().ESP_Outline = false
    getgenv().ESP_OutlineColor = Color3.fromRGB(0, 0, 0)
    getgenv().ESP_DisableKey = Enum.KeyCode.Q
    getgenv().ESP_TextTransparency = 0.75
end

UserInputService.TextBoxFocused:Connect(function()
    Typing = true
end)

UserInputService.TextBoxFocusReleased:Connect(function()
    Typing = false
end)

local Success, Errored = pcall(function()
    CreateESP()
end)

if Success and not Errored then
    if getgenv().ESP_SendNotifications == true then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Exunys Developer";
            Text = "ESP script has successfully loaded.";
            Duration = 5;
        })
    end
elseif Errored and not Success then
    if getgenv().ESP_SendNotifications == true then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Exunys Developer";
            Text = "ESP script has errored while loading, please check the developer console! (F9)";
            Duration = 5;
        })
    end
    TestService:Message("The ESP script has errored, please notify Exunys with the following information :")
    warn(Errored)
    print("!! IF THE ERROR IS A FALSE POSITIVE (says that a player cannot be found) THEN DO NOT BOTHER !!")
end
