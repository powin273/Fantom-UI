local Fantom = {}
Fantom.__index = Fantom

function Fantom:CreateWindow(config)
    local self = setmetatable({}, Fantom)
    
    local player = game.Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = config.Name or "FantomUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui
    self.ScreenGui = screenGui

    local Main = Instance.new("Frame")
    Main.Size = config.Size or UDim2.new(0, 600, 0, 400)
    Main.Position = config.Position or UDim2.new(0.5, 0, 0.5, 0)
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = config.BackgroundColor or Color3.fromRGB(25, 25, 25)
    Main.BorderSizePixel = 0
    Main.Parent = screenGui
    self.MainFrame = Main

    self:MakeDraggable(Main)

    local TabBar = Instance.new("Frame")
    TabBar.Size = UDim2.new(1, 0, 0, 40)
    TabBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TabBar.BorderSizePixel = 0
    TabBar.Parent = Main
    self.TabBar = TabBar

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 4)
    UIListLayout.Parent = TabBar

    local ContentHolder = Instance.new("Frame")
    ContentHolder.Size = UDim2.new(1, 0, 1, -40)
    ContentHolder.Position = UDim2.new(0, 0, 0, 40)
    ContentHolder.BackgroundTransparency = 1
    ContentHolder.Parent = Main
    self.ContentHolder = ContentHolder

    self.Tabs = {}

    return self
end

function Fantom:CreateTab(name)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 120, 1, 0)
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 14
    Button.Text = name
    Button.BorderSizePixel = 0
    Button.Parent = self.TabBar

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Button

    local Content = Instance.new("Frame")
    Content.Size = UDim2.new(1, 0, 1, 0)
    Content.BackgroundTransparency = 1
    Content.Visible = false
    Content.Parent = self.ContentHolder

    local function ActivateTab()
        for _, tab in pairs(self.ContentHolder:GetChildren()) do
            if tab:IsA("Frame") then
                tab.Visible = false
            end
        end
        for _, btn in pairs(self.TabBar:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            end
        end
        Content.Visible = true
        Button.BackgroundColor3 = Color3.fromRGB(70, 120, 180)
    end

    Button.MouseButton1Click:Connect(ActivateTab)

    if #self.Tabs == 0 then
        ActivateTab()
    end

    local tabObj = {
        Button = Button,
        Content = Content,
        Activate = ActivateTab
    }
    table.insert(self.Tabs, tabObj)

    return tabObj
end

function Fantom:MakeDraggable(frame)
    local UserInputService = game:GetService("UserInputService")
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            update(input)
        end
    end)
end

return Fantom
