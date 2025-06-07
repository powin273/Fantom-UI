--[[
    Fantom UI

]]
return function()
    local CoreGui = game:GetService("CoreGui")
    local UserInputService = game:GetService("UserInputService")

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FantomUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = CoreGui

    local Window = Instance.new("Frame")
    Window.Name = "MainWindow"
    Window.Size = UDim2.new(0, 640, 0, 480)
    Window.Position = UDim2.new(0.5, -320, 0.5, -240)
    Window.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Window.BorderSizePixel = 0
    Window.Parent = ScreenGui

    local UICorner = Instance.new("UICorner", Window)
    UICorner.CornerRadius = UDim.new(0, 12)

    local UIStroke = Instance.new("UIStroke", Window)
    UIStroke.Color = Color3.fromRGB(120, 120, 120)
    UIStroke.Thickness = 1
    UIStroke.Transparency = 0.4

    local TabBar = Instance.new("Frame")
    TabBar.Name = "TabBar"
    TabBar.Size = UDim2.new(1, 0, 0, 40)
    TabBar.BackgroundTransparency = 1
    TabBar.Parent = Window

    local TabLayout = Instance.new("UIListLayout", TabBar)
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabLayout.Padding = UDim.new(0, 6)

    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "Content"
    ContentFrame.Position = UDim2.new(0, 0, 0, 40)
    ContentFrame.Size = UDim2.new(1, 0, 1, -40)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = Window

    local Tabs = {}

    local function CreateTab(Name)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 120, 1, 0)
        TabButton.Text = Name
        TabButton.Font = Enum.Font.GothamBold
        TabButton.TextSize = 14
        TabButton.BackgroundColor3 = Color3.fromRGB(35,35,35)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.Parent = TabBar

        local TabFrame = Instance.new("Frame")
        TabFrame.Name = Name
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.BackgroundTransparency = 1
        TabFrame.Visible = false
        TabFrame.Parent = ContentFrame

        TabButton.MouseButton1Click:Connect(function()
            for _, tab in ipairs(Tabs) do
                tab.Frame.Visible = false
            end
            TabFrame.Visible = true
        end)

        table.insert(Tabs, {
            Button = TabButton,
            Frame = TabFrame
        })

        if #Tabs == 1 then
            TabFrame.Visible = true
        end

        return TabFrame
    end

    return {
        Instance = Window,
        CreateTab = CreateTab
    }
end

