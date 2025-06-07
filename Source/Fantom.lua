function Window:CreateTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0, 140, 0, 40)
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Font = Enum.Font.GothamSemibold
    TabButton.TextSize = 14
    TabButton.Text = name
    TabButton.BorderSizePixel = 0
    TabButton.Parent = self.TabContainer 

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 10)
    TabCorner.Parent = TabButton

    local TabStroke = Instance.new("UIStroke")
    TabStroke.Color = Color3.fromRGB(90, 90, 90)
    TabStroke.Thickness = 1
    TabStroke.Transparency = 0.4
    TabStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    TabStroke.Parent = TabButton


    local TabContent = Instance.new("Frame")
    TabContent.Size = UDim2.new(1, 0, 1, -50)
    TabContent.Position = UDim2.new(0, 0, 0, 50)
    TabContent.BackgroundTransparency = 1
    TabContent.Visible = false
    TabContent.Parent = self.ContentHolder 

    TabButton.MouseButton1Click:Connect(function()
        for _, content in pairs(self.ContentHolder:GetChildren()) do
            if content:IsA("Frame") then
                content.Visible = false
            end
        end
        TabContent.Visible = true
    end)

    local tabObj = {}
    function tabObj:AddSection(name)

    end

    tabObj.Content = TabContent
    tabObj.Button = TabButton
    return tabObj
end
