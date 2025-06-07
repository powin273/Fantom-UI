local SaveManager = require(path_to_SaveManager)
local UserInputService = game:GetService("UserInputService")

local Window = script.Parent.Window -- อ้างถึง UI Frame ของคุณ

SaveManager:SetUI(Window)
SaveManager:Load()

local dragging = false
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    Window.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

Window.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Window.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                SaveManager:Save() -- บันทึกตำแหน่งเมื่อปล่อยเมาส์
            end
        end)
    end
end)

Window.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)
