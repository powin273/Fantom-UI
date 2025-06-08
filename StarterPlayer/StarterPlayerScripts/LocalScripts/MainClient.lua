local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")


local WindowModule = require(game:GetService("ReplicatedStorage"):WaitForChild("Source"):WaitForChild("WindowModule"))


local Window = WindowModule.new()
Window.Parent = PlayerGui
Window.Size = UDim2.new(0, 700, 0, 480)
Window.Position = UDim2.new(0.5, -350, 0.5, -240)
Window.AnchorPoint = Vector2.new(0.5, 0.5)


local MainTab = Window:CreateTab("Main")


local Section1 = MainTab:AddSection("Section 1")

local label = Instance.new("TextLabel")
label.Text = "Welcome to Fantom UI!"
label.Size = UDim2.new(1, 0, 0, 30)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.fromRGB(230, 230, 255)
label.Font = Enum.Font.GothamBold
label.TextSize = 18
label.Parent = Section1

