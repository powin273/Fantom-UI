local Fantom = {}
Fantom.__index = Fantom

function Fantom:CreateWindow(config)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = config.Name or "FantomUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    local Main = Instance.new("Frame")
    Main.Size = config.Size or UDim2.new(0, 600, 0, 400)
    Main.Position = config.Position or UDim2.new(0.5, -300, 0.5, -200)
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = config.BackgroundColor or Color3.fromRGB(60, 42, 86) 
    Main.BorderSizePixel = 0
    Main.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 16)
    UICorner.Parent = Main

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Color = config.StrokeColor or Color3.fromRGB(110, 90, 140) 
    UIStroke.Thickness = 1.5
    UIStroke.Parent = Main

    local TabBar = Instance.new("Frame")
    TabBar.Size = UDim2.new(1, 0, 0, 40)
    TabBar.BackgroundColor3 = Color3.fromRGB(50, 38, 75)
    TabBar.BorderSizePixel = 0
    TabBar.Parent = Main

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = TabBar

    local ContentHolder = Instance.new("Frame")
    ContentHolder.Size = UDim2.new(1, 0, 1, -40)
    ContentHolder.Position = UDim2.new(0, 0, 0, 40)
    ContentHolder.BackgroundTransparency = 1
    ContentHolder.Parent = Main

    local UserInputService = game:GetService("UserInputService")
    local dragging = false
    local dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    Main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            UserInputService.InputChanged:Connect(function(moveInput)
                if moveInput == input and dragging then
                    update(moveInput)
                end
            end)
        end
    end)

    local windowObj = {}
    windowObj.Main = Main
    windowObj.TabBar = TabBar
    windowObj.ContentHolder = ContentHolder
    windowObj.Tabs = {}

    function windowObj:CreateTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 90, 1, 0)
        TabButton.BackgroundColor3 = Color3.fromRGB(90, 72, 140)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.Font = Enum.Font.GothamBold
        TabButton.TextSize = 13 
        TabButton.Text = name
        TabButton.BorderSizePixel = 0
        TabButton.Parent = TabBar

        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 12)
        Corner.Parent = TabButton

        local Content = Instance.new("Frame")
        Content.Size = UDim2.new(1, 0, 1, 0)
        Content.BackgroundTransparency = 1
        Content.Visible = false
        Content.Parent = ContentHolder

        local function ActivateTab()
            for _, tabContent in pairs(ContentHolder:GetChildren()) do
                if tabContent:IsA("Frame") then
                    tabContent.Visible = false
                end
            end
            for _, btn in pairs(TabBar:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.BackgroundColor3 = Color3.fromRGB(90, 72, 140)
                end
            end

            Content.Visible = true
            TabButton.BackgroundColor3 = Color3.fromRGB(65, 50, 100)
        end

        TabButton.MouseButton1Click:Connect(ActivateTab)

        if #ContentHolder:GetChildren() == 1 then
            ActivateTab()
        end

        local tab = {}
        tab.Button = TabButton
        tab.Content = Content

        function tab:AddLabel(text)
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -20, 0, 30)
            label.Position = UDim2.new(0, 10, 0, (#tab.Content:GetChildren() * 30))
            label.BackgroundTransparency = 1
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.Font = Enum.Font.Gotham
            label.TextSize = 14
            label.Text = text
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = tab.Content
        end

        return tab
    end

    return windowObj
end

return Fantom
