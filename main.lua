--[[
    Fantom UI
  ]]


local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Fantom = {}
Fantom.Version = "1.0"

Fantom.Windows = {}

function Fantom:CreateWindow(config)
    config = config or {}
    local title = config.Title or "Fantom UI"
    local size = config.Size or UDim2.fromOffset(700, 480)
    local bgColor = config.BackgroundColor or Color3.fromRGB(25, 25, 25)
    local strokeColor = config.StrokeColor or Color3.fromRGB(100, 100, 100)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FantomUI_" .. title:gsub("%s+", "")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Window = Instance.new("Frame")
    Window.Name = "Window"
    Window.Size = size
    Window.Position = UDim2.new(0.5, -size.X.Offset/2, 0.5, -size.Y.Offset/2)
    Window.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.BackgroundColor3 = bgColor
    Window.BorderSizePixel = 0
    Window.ClipsDescendants = true
    Window.Parent = ScreenGui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 16)
    Corner.Parent = Window

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = strokeColor
    Stroke.Thickness = 2
    Stroke.Transparency = 0.4
    Stroke.Parent = Window


    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 36)
    TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    TitleBar.Parent = Window

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Text = title
    TitleLabel.Size = UDim2.new(1, -40, 1, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 20
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Position = UDim2.new(0, 16, 0, 0)
    TitleLabel.Parent = TitleBar

   
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -36, 0, 3)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    CloseBtn.Text = "X"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 18
    CloseBtn.AutoButtonColor = false
    CloseBtn.Parent = TitleBar

    CloseBtn.MouseEnter:Connect(function()
        CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    end)
    CloseBtn.MouseLeave:Connect(function()
        CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
    end)
    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui.Enabled = false
    end)

 
    local dragging = false
    local dragInput, dragStart, startPos

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
            local delta = input.Position - dragStart
            Window.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

้
    self.Windows[title] = {
        ScreenGui = ScreenGui,
        Window = Window,
        TitleBar = TitleBar,
        CloseBtn = CloseBtn,
        TitleLabel = TitleLabel,
        Tabs = {},
        CurrentTab = nil,
    }

    return self.Windows[title]
end

function Fantom:AddTab(window, tabName)
    if not window or not tabName then return end
    local tabContainer = window.TabsContainer
    if not tabContainer then
        tabContainer = Instance.new("Frame")
        tabContainer.Name = "TabsContainer"
        tabContainer.Size = UDim2.new(1, 0, 1, -36)
        tabContainer.Position = UDim2.new(0, 0, 0, 36)
        tabContainer.BackgroundTransparency = 1
        tabContainer.Parent = window.Window
        window.TabsContainer = tabContainer
    end

    local tabButton = Instance.new("TextButton")
    tabButton.Text = tabName
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextSize = 16
    tabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    tabButton.BackgroundTransparency = 1
    tabButton.Size = UDim2.new(0, 120, 0, 36)
    tabButton.Parent = tabContainer


    local index = #window.Tabs + 1
    tabButton.Position = UDim2.new(0, (index - 1) * 120, 0, 0)

    local tabContent = Instance.new("Frame")
    tabContent.Name = "TabContent"
    tabContent.Size = UDim2.new(1, 0, 1, -36)
    tabContent.Position = UDim2.new(0, 0, 0, 36)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.Parent = window.Window


    window.Tabs[tabName] = {
        Button = tabButton,
        Content = tabContent
    }


    tabButton.MouseButton1Click:Connect(function()

        for _, tab in pairs(window.Tabs) do
            tab.Content.Visible = false
            tab.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
        end


        window.Tabs[tabName].Content.Visible = true
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        window.CurrentTab = tabName
    end)


    if #window.Tabs == 0 then
        tabButton:MouseButton1Click()
    end

    table.insert(window.Tabs, window.Tabs[tabName])

    return window.Tabs[tabName]
end

return Fantom
