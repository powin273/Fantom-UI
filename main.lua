--[[
    Fantom UI

]]
return function()
    local UserInputService = game:GetService("UserInputService")
    local CoreGui = game:GetService("CoreGui")

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FantomUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui

    local Window = Instance.new("Frame")
    Window.Name = "Window"
    Window.Size = UDim2.new(0, 700, 0, 500)
    Window.Position = UDim2.new(0.5, -350, 0.5, -250)
    Window.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Window.BorderSizePixel = 0
    Window.Parent = ScreenGui

    local UICorner = Instance.new("UICorner", Window)
    UICorner.CornerRadius = UDim.new(0, 16)

    local UIStroke = Instance.new("UIStroke", Window)
    UIStroke.Color = Color3.fromRGB(120, 120, 120)
    UIStroke.Transparency = 0.4

    local TabContainer = Instance.new("Frame")
    TabContainer.Name = "TabContainer"
    TabContainer.Size = UDim2.new(1, 0, 0, 40)
    TabContainer.BackgroundTransparency = 1
    TabContainer.Parent = Window

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Position = UDim2.new(0, 0, 0, 40)
    ContentFrame.Size = UDim2.new(1, 0, 1, -40)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = Window

    local Tabs = {}

    local function CreateTab(name, icon)
        local button = Instance.new("TextButton")
        button.Text = name
        button.Size = UDim2.new(0, 120, 1, 0)
        button.BackgroundTransparency = 1
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        button.Parent = TabContainer

        local tabFrame = Instance.new("Frame")
        tabFrame.Name = name
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.Visible = false
        tabFrame.BackgroundTransparency = 1
        tabFrame.Parent = ContentFrame

        table.insert(Tabs, {
            Name = name,
            Button = button,
            Frame = tabFrame
        })

        button.MouseButton1Click:Connect(function()
            for _, tab in ipairs(Tabs) do
                tab.Frame.Visible = false
            end
            tabFrame.Visible = true
        end)

        if #Tabs == 1 then
            tabFrame.Visible = true
        end

        return tabFrame
    end

    return {
        Instance = Window,
        CreateTab = CreateTab
    }
end
