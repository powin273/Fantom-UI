--[[
    Fantom UI

]]


local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local Fantom = {}

Fantom.Windows = {}

function Fantom:CreateWindow(config)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = config.Name or "FantomUI"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false

    local Window = Instance.new("Frame")
    Window.Size = config.Size or UDim2.new(0, 600, 0, 400)
    Window.Position = UDim2.new(0.5, -300, 0.5, -200)
    Window.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Window.BorderSizePixel = 0
    Window.Parent = ScreenGui

    local corner = Instance.new("UICorner", Window)
    corner.CornerRadius = UDim.new(0, 12)

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.Text = config.Name or "Fantom UI"
    Title.Parent = Window

    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        Window.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    Window.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Window.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Window.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            update(input)
        end
    end)

    if config.ConfigurationSaving and config.ConfigurationSaving.Enabled then
        local configFileName = config.ConfigurationSaving.FileName or "FantomConfig"
        local success, savedConfig = pcall(function()
            return readfile(configFileName)
        end)

        if success then
            local decoded = HttpService:JSONDecode(savedConfig)
        end

        function saveConfig(data)
            local json = HttpService:JSONEncode(data)
            writefile(configFileName, json)
        end
    end

    if config.Discord and config.Discord.Enabled then
        local discordLabel = Instance.new("TextLabel")
        discordLabel.Size = UDim2.new(1, 0, 0, 30)
        discordLabel.Position = UDim2.new(0, 0, 0, 40)
        discordLabel.BackgroundTransparency = 1
        discordLabel.TextColor3 = Color3.fromRGB(100, 150, 255)
        discordLabel.Text = "Join Discord: ".. (config.Discord.Invite or "")
        discordLabel.Font = Enum.Font.Gotham
        discordLabel.TextSize = 16
        discordLabel.Parent = Window
    end

    if config.KeySystem then
    end

    table.insert(self.Windows, Window)
    return Window
end

return Fantom
