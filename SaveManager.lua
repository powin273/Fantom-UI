local SaveManager = {}

local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

SaveManager.Filename = "FantomUI_SaveData"
SaveManager.Window = nil

function SaveManager:SetUI(window)
    self.Window = window
end

function SaveManager:Save()
    if not self.Window then return end
    local data = {
        Position = {
            X = self.Window.Position.X.Offset,
            Y = self.Window.Position.Y.Offset,
        }
    }
    local json = HttpService:JSONEncode(data)

    game:SetFastFlagForUserId(123456789, "FantomUI_SaveData", json)
end

function SaveManager:Load()
    if not self.Window then return end

    local success, json = pcall(function()
        return game:GetFastFlag("FantomUI_SaveData")
    end)
    if success and json then
        local data = HttpService:JSONDecode(json)
        if data and data.Position then
            local x = data.Position.X or self.Window.Position.X.Offset
            local y = data.Position.Y or self.Window.Position.Y.Offset
            self.Window.Position = UDim2.new(self.Window.Position.X.Scale, x, self.Window.Position.Y.Scale, y)
        end
    end
end

return SaveManager
