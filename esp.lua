local EspTab = getgenv().Ui_EspTab
getgenv().ESP_ESPVisible = false
-- Esp Variables

local EspTransparency
local EspOutlineTransparency
local EspColor
local EspOutlineColor
local EspTeam = "All"
local EspToggled = false

local EspToggle = EspTab:AddToggle({
    Name = "Esp Toggle",
    Default = false,
    Callback = function(Value)
        if Value then
            EspToggled = true
            getgenv().ESP_ESPVisible = true
            for i, v in pairs(game.Players:GetChildren()) do
                if v.Name ~= game.Players.LocalPlayer.Name then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = v.Character
                    highlight.Name = "esp"
                    highlight.FillTransparency = EspTransparency
                    highlight.OutlineTransparency = EspOutlineTransparency
                    highlight.FillColor = EspColor
                    highlight.OutlineColor = EspOutlineColor
                end
            end
        else
            EspToggled = false
            getgenv().ESP_ESPVisible = false
            for i, v in pairs(game.Players:GetChildren()) do
                if v.Character:FindFirstChild("esp") then
                    v.Character:FindFirstChildOfClass("Highlight"):Destroy()
                end
            end
        end
    end
})

EspTab:AddBind({
    Name = "Esp Bind",
    Default = Enum.KeyCode.Zero,
    Hold = false,
    Callback = function()
        if EspToggled then
            EspToggle:Set(false)
        else
            EspToggle:Set(true)
        end
    end
})

local EspColorTab = EspTab:AddSection({
    Name = "Color"
})

local EspFillPicker = EspColorTab:AddColorpicker({
    Name = "Esp Fill Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(Value)
        EspColor = Value
        for i, v in pairs(game.Players:GetChildren()) do
            if v.Character:FindFirstChild("esp") then
                v.Character.esp.FillColor = EspColor
            end
        end
    end
})

local EspColorOutlinePicker = EspColorTab:AddColorpicker({
    Name = "Esp Outline Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(Value)
        EspOutlineColor = Value
        for i, v in pairs(game.Players:GetChildren()) do
            if v.Character:FindFirstChild("esp") then
                v.Character.esp.OutlineColor = EspOutlineColor
            end
        end
    end
})

local EspCust = EspTab:AddSection({
    Name = "Customization"
})

local FillTransSlider = EspCust:AddSlider({
    Name = "Fill Transparency",
    Min = 0,
    Max = 1,
    Default = 0.5,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 0.05,
    ValueName = "Transparency",
    Callback = function(Value)
        EspTransparency = Value
        for i, v in pairs(game.Players:GetChildren()) do
            if v.Character:FindFirstChild("esp") then
                v.Character.esp.FillTransparency = EspTransparency
            end
        end
    end
})

local OutTransSlider = EspCust:AddSlider({
    Name = "Outline Transparency",
    Min = 0,
    Max = 1,
    Default = 0,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 0.05,
    ValueName = "Transparency",
    Callback = function(Value)
        EspOutlineTransparency = Value
        for i, v in pairs(game.Players:GetChildren()) do
            if v.Character:FindFirstChild("esp") then
                v.Character.esp.OutlineTransparency = EspOutlineTransparency
            end
        end
    end
})

local OtherEsp = EspTab:AddSection({
    Name = "Other"
})

OtherEsp:AddButton({
    Name = "Refresh (for new players)",
    Callback = function()
        if EspToggled then
            for i, v in pairs(game:FindFirstChildOfClass("Players"):GetChildren()) do
                if not v.Character:FindFirstChild("esp") and v.Name ~= game:FindFirstChildOfClass("Players").LocalPlayer.Name then
                        local highlight = Instance.new("Highlight")
                        highlight.Parent = v.Character
                        highlight.Name = "esp"
                        highlight.FillTransparency = EspTransparency
                        highlight.OutlineTransparency = EspOutlineTransparency
                        highlight.FillColor = EspColor
                        highlight.OutlineColor = EspOutlineColor
                end
            end
        end
    end
})

OtherEsp:AddBind({
    Name = "Refresh bind",
    Default = Enum.KeyCode.Plus,
    Hold = false,
    Callback = function()
        if EspToggled then
            for i, v in pairs(game:FindFirstChildOfClass("Players"):GetChildren()) do
                if not v.Character:FindFirstChild("esp") and v.Name ~= game:FindFirstChildOfClass("Players").LocalPlayer.Name then
                        local highlight = Instance.new("Highlight")
                        highlight.Parent = v.Character
                        highlight.Name = "esp"
                        highlight.FillTransparency = EspTransparency
                        highlight.OutlineTransparency = EspOutlineTransparency
                        highlight.FillColor = EspColor
                        highlight.OutlineColor = EspOutlineColor
                end
            end
        end
    end
})

OtherEsp:AddButton({
    Name = "Reset Settings",
    Callback = function()
        EspFillPicker:Set(Color3.fromRGB(255, 0, 0))
        EspColorOutlinePicker:Set(Color3.fromRGB(255, 255, 255))
        FillTransSlider:Set(0.5)
        OutTransSlider:Set(0)
    end
})
