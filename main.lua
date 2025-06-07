--[
--Fantom-UI
--]
local Fantom = {}
Fantom.Version = "1.0"

local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local existingUI 

function Fantom:CreateWindow(config)
    if existingUI then
        return existingUI 
    end

    config = config or {}
    local title = config.Title or "Fantom UI"
    local size = config.Size or UDim2.new(0, 700, 0, 480)
    local bgColor = config.BackgroundColor or Color3.fromRGB(25, 25, 25)
    local strokeColor = config.StrokeColor or Color3.fromRGB(100, 100, 100)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FantomUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui

    local Window = Instance.new("Frame")
    Window.Name = "Window"
    Window.Size = size
    Window.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
    Window.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.BackgroundColor3 = bgColor
    Window.BorderSizePixel = 0
    Window.ClipsDescendants = true
    Window.Parent = ScreenGui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = Window

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = strokeColor
    Stroke.Thickness = 2
    Stroke.Transparency = 0.4
    Stroke.Parent = Window

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Text = title
    TitleLabel.Size = UDim2.new(1, 0, 0, 30)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 20
    TitleLabel.Parent = Window

    existingUI = {
        ScreenGui = ScreenGui,
        Window = Window
    }
    return existingUI
end

return Fantom
