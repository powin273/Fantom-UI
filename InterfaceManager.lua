local InterfaceManager = {}

InterfaceManager.Windows = {}
InterfaceManager.Folder = "FantomUI"

function InterfaceManager:SetFolder(folderName)
    self.Folder = folderName or self.Folder
end

function InterfaceManager:RegisterWindow(windowName, windowInstance)
    if typeof(windowName) ~= "string" or typeof(windowInstance) ~= "Instance" then
        error("InterfaceManager:RegisterWindow requires a valid string and Instance")
    end
    self.Windows[windowName] = windowInstance
end

function InterfaceManager:OpenWindow(windowName)
    local win = self.Windows[windowName]
    if win and typeof(win) == "Instance" then
        win.Visible = true
    else
        warn("OpenWindow: window '" .. tostring(windowName) .. "' not found")
    end
end

function InterfaceManager:CloseWindow(windowName)
    local win = self.Windows[windowName]
    if win and typeof(win) == "Instance" then
        win.Visible = false
    else
        warn("CloseWindow: window '" .. tostring(windowName) .. "' not found")
    end
end

function InterfaceManager:ToggleWindow(windowName)
    local win = self.Windows[windowName]
    if win and typeof(win) == "Instance" then
        win.Visible = not win.Visible
    else
        warn("ToggleWindow: window '" .. tostring(windowName) .. "' not found")
    end
end

function InterfaceManager:IsWindowOpen(windowName)
    local win = self.Windows[windowName]
    if win and typeof(win) == "Instance" then
        return win.Visible
    end
    return false
end

function InterfaceManager:SaveWindowStates()
    local HttpService = game:GetService("HttpService")
    local states = {}
    for name, win in pairs(self.Windows) do
        if typeof(win) == "Instance" then
            states[name] = win.Visible
        end
    end
    local json = HttpService:JSONEncode(states)
    return json
end

function InterfaceManager:LoadWindowStates(json)
    local HttpService = game:GetService("HttpService")
    if not json or type(json) ~= "string" then return end
    local success, states = pcall(function()
        return HttpService:JSONDecode(json)
    end)
    if success and type(states) == "table" then
        for name, visible in pairs(states) do
            local win = self.Windows[name]
            if win and typeof(win) == "Instance" and type(visible) == "boolean" then
                win.Visible = visible
            end
        end
    else
        warn("LoadWindowStates: Invalid JSON data")
    end
end

return InterfaceManager
