local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local correctKeys = {
    ["WorkZnow"] = true,
    ["MySecretKey"] = true,
}

-- Create UI for key input
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "KeyGui"
KeyGui.ResetOnSpawn = false
KeyGui.Parent = CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.Parent = KeyGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

local TextLabel = Instance.new("TextLabel")
TextLabel.Size = UDim2.new(1, -20, 0, 50)
TextLabel.Position = UDim2.new(0, 10, 0, 10)
TextLabel.BackgroundTransparency = 1
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Text = "Please enter the key to activate"
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextSize = 18
TextLabel.Parent = Frame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -20, 0, 40)
TextBox.Position = UDim2.new(0, 10, 0, 70)
TextBox.PlaceholderText = "Enter key here..."
TextBox.Text = ""
TextBox.ClearTextOnFocus = true
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 18
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Parent = Frame

local SubmitButton = Instance.new("TextButton")
SubmitButton.Size = UDim2.new(0, 100, 0, 30)
SubmitButton.Position = UDim2.new(1, -110, 1, -40)
SubmitButton.AnchorPoint = Vector2.new(1, 1)
SubmitButton.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 18
SubmitButton.Text = "Submit"
SubmitButton.Parent = Frame

local function openMainUI()
    KeyGui:Destroy() -- Close key input UI
    -- Load your main UI, for example main.lua returning window
    local Fantom = loadstring(game:HttpGet("https://raw.githubusercontent.com/powin273/Fantom-UI/main/main.lua"))()
    local window = Fantom
    window.Visible = true
end

SubmitButton.MouseButton1Click:Connect(function()
    local enteredKey = TextBox.Text
    if correctKeys[enteredKey] then
        openMainUI()
    else
        TextLabel.Text = "Invalid key, please try again"
        TextLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)
