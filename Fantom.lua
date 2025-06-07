local Fantom = {}
Fantom.Version = "1.0"

function Fantom:CreateWindow(options)
    local UserInputService = game:GetService("UserInputService")
    local CoreGui = game:GetService("CoreGui")

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = options.Title or "FantomUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui

    local Window = Instance.new("Frame")
    Window.Name = "Window"
    Window.Size = options.Size or UDim2.new(0, 700, 0, 480)
    Window.Position = UDim2.new(0.5, -Window.Size.X.Offset/2, 0.5, -Window.Size.Y.Offset/2)
    Window.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.BackgroundColor3 = options.BackgroundColor or Color3.fromRGB(25, 25, 25)
    Window.BorderSizePixel = 0
    Window.ClipsDescendants = true
    Window.Parent = ScreenGui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = Window

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = options.StrokeColor or Color3.fromRGB(100, 100, 100)
    Stroke.Thickness = options.StrokeThickness or 2
    Stroke.Transparency = options.StrokeTransparency or 0.4
    Stroke.Parent = Window

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Text = options.Title or "Fantom UI"
    TitleLabel.Size = UDim2.new(1, 0, 0, 40)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 24
    TitleLabel.Parent = Window

    return Window
end

return Fantom
