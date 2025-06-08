local Window = {}
Window.__index = Window

function Window.new()
    local self = setmetatable({}, Window)

    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Size = UDim2.new(0, 600, 0, 400)
    self.MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    self.MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    self.MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    self.MainFrame.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")

    self.TabContainer = Instance.new("Frame")
    self.TabContainer.Size = UDim2.new(1, 0, 0, 40)
    self.TabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    self.TabContainer.Parent = self.MainFrame

    self.ContentHolder = Instance.new("Frame")
    self.ContentHolder.Size = UDim2.new(1, 0, 1, -40)
    self.ContentHolder.Position = UDim2.new(0, 0, 0, 40)
    self.ContentHolder.BackgroundTransparency = 1
    self.ContentHolder.Parent = self.MainFrame

    return self
end

function Window:CreateTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0, 100, 0, 32)  
    TabButton.BackgroundColor3 = Color3.fromRGB(75, 50, 130) 
    TabButton.TextColor3 = Color3.fromRGB(230, 230, 255)
    TabButton.Font = Enum.Font.GothamSemibold
    TabButton.TextSize = 15
    TabButton.Text = name
    TabButton.BorderSizePixel = 0
    TabButton.Parent = self.TabContainer 

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 12)  
    TabCorner.Parent = TabButton

    local TabStroke = Instance.new("UIStroke")
    TabStroke.Color = Color3.fromRGB(110, 90, 140) 
    TabStroke.Thickness = 1.5
    TabStroke.Transparency = 0
    TabStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    TabStroke.Parent = TabButton

    local TabContent = Instance.new("Frame")
    TabContent.Size = UDim2.new(1, 0, 1, -40)
    TabContent.Position = UDim2.new(0, 0, 0, 40)
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
       
        for _, btn in pairs(self.TabContainer:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Color3.fromRGB(75, 50, 130) 
            end
        end
        TabButton.BackgroundColor3 = Color3.fromRGB(120, 85, 190) 
    end)

    local tabObj = {}
    function tabObj:AddSection(name)
        local section = Instance.new("Frame")
        section.Size = UDim2.new(1, -20, 0, 100)
        section.Position = UDim2.new(0, 10, 0, #TabContent:GetChildren() * 110)
        section.BackgroundColor3 = Color3.fromRGB(40, 30, 70)
        section.BorderSizePixel = 0
        section.Parent = TabContent

        local sectionCorner = Instance.new("UICorner")
        sectionCorner.CornerRadius = UDim.new(0, 10)
        sectionCorner.Parent = section

        local label = Instance.new("TextLabel")
        label.Text = name
        label.Size = UDim2.new(1, 0, 0, 25)
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.fromRGB(220, 220, 255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 16
        label.Parent = section

        return section
    end

    tabObj.Content = TabContent
    tabObj.Button = TabButton
    return tabObj
end

return Window
