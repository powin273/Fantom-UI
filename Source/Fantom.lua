local Fantom = {}

function Fantom:CreateWindow(config)
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    ScreenGui.Name = "FantomUI"
    ScreenGui.ResetOnSpawn = false

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = config.Size or UDim2.new(0, 600, 0, 400)
    Main.Position = UDim2.new(0.5, -300, 0.5, -200)
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.BorderSizePixel = 0

    local Corner = Instance.new("UICorner", Main)
    Corner.CornerRadius = UDim.new(0, 12)

    local TabHolder = Instance.new("Frame", Main)
    TabHolder.Size = UDim2.new(0, 150, 1, 0)
    TabHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Instance.new("UICorner", TabHolder).CornerRadius = UDim.new(0, 12)

    local ContentHolder = Instance.new("Frame", Main)
    ContentHolder.Position = UDim2.new(0, 150, 0, 0)
    ContentHolder.Size = UDim2.new(1, -150, 1, 0)
    ContentHolder.BackgroundTransparency = 1

    local Window = {}

    Window.Tabs = {}
    Window.ContentHolder = ContentHolder
    Window.TabHolder = TabHolder

    function Window:CreateTab(name)
        local TabButton = Instance.new("TextButton", TabHolder)
        TabButton.Size = UDim2.new(1, -20, 0, 40)
        TabButton.Position = UDim2.new(0, 10, 0, #self.Tabs * 50 + 20)
        TabButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabButton.Text = name
        TabButton.Font = Enum.Font.GothamBold
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 14
        TabButton.BorderSizePixel = 0
        Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 8)

        local TabContent = Instance.new("Frame", ContentHolder)
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.Visible = #self.Tabs == 0

        TabButton.MouseButton1Click:Connect(function()
            for _, tab in ipairs(self.Tabs) do
                tab.Content.Visible = false
            end
            TabContent.Visible = true
        end)

        local Tab = {}
        Tab.Button = TabButton
        Tab.Content = TabContent

        function Tab:CreateButton(text, callback)
            local Button = Instance.new("TextButton", TabContent)
            Button.Size = UDim2.new(0, 200, 0, 40)
            Button.Position = UDim2.new(0, 20, 0, #TabContent:GetChildren() * 45)
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Button.Text = text
            Button.Font = Enum.Font.Gotham
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 14
            Button.BorderSizePixel = 0
            Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

            Button.MouseButton1Click:Connect(function()
                if callback then callback() end
            end)
        end

        table.insert(self.Tabs, Tab)
        return Tab
    end

    return Window
end

return Fantom
