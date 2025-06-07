local InterfaceManager = {}

InterfaceManager.Windows = {}

InterfaceManager.Folder = "FantomUI"

function InterfaceManager:SetFolder(folderName)
    self.Folder = folderName or self.Folder
end

function InterfaceManager:RegisterWindow(windowName, windowInstance)
    if not windowName or not windowInstance then
        error("InterfaceManager:RegisterWindow requires windowName and windowInstance")
    end
    self.Windows[windowName] = windowInstance
end

function InterfaceManager:OpenWindow(windowName)
    local win = self.Windows[windowName]
    if win then
        win.Visible = true
    end
end

function InterfaceManager:CloseWindow(windowName)
    local win = self.Windows[windowName]
    if win then
        win.Visible = false
    end
end

function InterfaceManager:ToggleWindow(windowName)
    local win = self.Windows[windowName]
    if win then
        win.Visible = not win.Visible
    end
end

function InterfaceManager:IsWindowOpen(windowName)
    local win = self.Windows[windowName]
    if win then
        return win.Visible
    end
    return false
end

function InterfaceManager:SaveWindowStates()
    local HttpService = game:GetService("HttpService")
    local states = {}
    for name, win in pairs(self.Windows) do
        states[name] = win.Visible
    end
    local json = HttpService:JSONEncode(states)
  
    return json
end

function InterfaceManager:LoadWindowStates(json)
    local HttpService = game:GetService("HttpService")
    if not json then return end
    local success, states = pcall(function()
        return HttpService:JSONDecode(json)
    end)
    if success and type(states) == "table" then
        for name, visible in pairs(states) do
            if self.Windows[name] then
                self.Windows[name].Visible = visible
            end
        end
    end
end

return InterfaceManager
