local Fantom = {}

Fantom.Version = "1.0.0"

function Fantom:CreateWindow(config)
    assert(type(config) == "table", "CreateWindow expects a config table")

    local UserInputService = game:GetService("UserInputService")
    local CoreGui = game:GetService("CoreGui")

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FantomUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui

    local Window = Instance.new("Frame")
    Window.Name = "Window"
    Window.Size = config.Size or UDim2.new(0, 700, 0, 480)
    Window.Position = UDim2.new(0.5, -(Window.Size.X.Offset / 2), 0.5, -(Window.Size.Y.Offset / 2))
    Window.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.BackgroundColor3 = config.BackgroundColor or Color3.fromRGB(30, 30, 30)
    Window.BorderSizePixel = 0
    Window.ClipsDescendants = true
    Window.Parent = ScreenGui

    if config.Acrylic then
        local Blur = Instance.new("BlurEffect")
        Blur.Size = 8
        Blur.Parent = game.Lighting
    end


    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = Window


    local Stroke = Instance.new("UIStroke")
    Stroke.Color = config.StrokeColor or Color3.fromRGB(120, 120, 120)
    Stroke.Thickness = config.StrokeThickness or 2
    Stroke.Transparency = config.StrokeTransparency or 0.5
    Stroke.Parent = Window

    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundTransparency = 1
    TitleBar.Parent = Window

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Text = config.Title or "Fantom UI " .. Fantom.Version
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 20
    TitleLabel.TextColor3 = config.TitleColor or Color3.fromRGB(240, 240, 240)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Size = UDim2.new(1, -10, 1, 0)
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleBar

    local SubTitleLabel = Instance.new("TextLabel")
    SubTitleLabel.Name = "SubTitle"
    SubTitleLabel.Text = config.SubTitle or ""
    SubTitleLabel.Font = Enum.Font.Gotham
    SubTitleLabel.TextSize = 14
    SubTitleLabel.TextColor3 = config.SubTitleColor or Color3.fromRGB(180, 180, 180)
    SubTitleLabel.BackgroundTransparency = 1
    SubTitleLabel.Size = UDim2.new(1, -10, 0, 18)
    SubTitleLabel.Position = UDim2.new(0, 10, 1, -18)
    SubTitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    SubTitleLabel.Parent = TitleBar

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

    TitleBar.InputBegan:Connect(function(input)
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

    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            update(input)
        end
    end)

    return Window
end

return Fantom
