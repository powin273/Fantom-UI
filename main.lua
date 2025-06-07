--[[
    Fantom UI


]]

local Fantom = {}

Fantom.Windows = {}

function Fantom:CreateWindow(config)
    local UserInputService = game:GetService("UserInputService")
    local CoreGui = game:GetService("CoreGui")

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = config.Title or "FantomUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui

    local Window = Instance.new("Frame")
    Window.Size = config.Size or UDim2.new(0, 700, 0, 480)
    Window.Position = UDim2.new(0.5, -(Window.Size.X.Offset / 2), 0.5, -(Window.Size.Y.Offset / 2))
    Window.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.BackgroundColor3 = config.BackgroundColor or Color3.fromRGB(25, 25, 25)
    Window.BorderSizePixel = 0
    Window.Parent = ScreenGui

    local UICorner = Instance.new("UICorner", Window)
    UICorner.CornerRadius = UDim.new(0, 16)

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

    table.insert(self.Windows, Window)

    return Window
end

return Fantom
