# Misc

```diff
local normal = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Lucifer4381/ui-normal-hub/main/scr')))()
```

# Create Window
```lua
_G.Color = Color3.fromRGB(0, 0, 255) -- Color UI
_G.Logo = 13990972098 -- ID Logo Your Hub
local Win = library:Evil("Evo","Tư Bản",_G.Logo )
```
# Create Tab
```lua
local Tab = Win:CraftTab('Main') -- Name
local Page = Tab:CraftPage('Main',1) -- Name,1 or 2
```
# Button
```lua
Page:Button('Button',function() --Name
    print("t")
end)
```
# Toggle
```lua
Page:Toggle('Test',nil,function(a) -- Toggle,Def,callback
    print(a)
end)
```
# Dropdown
```lua
Page:Dropdown("Dropdown",{"1","2"},{""},function(v)
    print(v)
end)

Page:MultiDropdown("MultiDropdown",{"MultiDropdown","MultiDropdown2"},{""},function(v)
    print(v)
end)
```
# Label
```lua
local A = Page:Label('Label') --name
local B = Page:LabelLog('Label') --name
```
# Set Label 
```lua
A:Refresh("A") -- name
B:Refresh("B") -- name
B:Color(Color3.fromRGB(255, 255, 255))  -- Color
```
# Slider
```lua
Page:Slider("Slider",true,0,100,1,function(value)
    print(value)
end)
```
# TextBox
```lua
Page:Textbox("Test","",function(v)
	print(v)
end)
```
